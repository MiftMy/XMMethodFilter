//
//  MRClassMethod.m
//  OKZOOM
//
//  Created by Mifit on 2019/8/12.
//  Copyright © 2019 OKZOOM. All rights reserved.
//

#import "MRClassMethod.h"
#import <UIKit/UIKit.h>

@implementation MRClassMethod
+ (void)nsbundleMethodList:(NSString *)path {
    
    NSArray *allFiles = [self subfilesWithPath:path];
    NSMutableDictionary *info = [NSMutableDictionary dictionary];
    for (NSString *file in allFiles) {
//        if ([file hasSuffix:@"MyFunc.m"])
        {
            NSArray *methodList = [self methodFromFile:file];
            if (methodList) {
                [info setValue:methodList forKey:file];
            }
        }
    }
}

// 检索所有.h、.m文件
+ (NSArray *)subfilesWithPath:(NSString *)path {
    NSError *error = nil;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    /// 文件内容
    NSArray * filePathArr = [fileManager contentsOfDirectoryAtPath:path error:&error];
    NSMutableArray *fileSet = [NSMutableArray array];
    for (NSString *temPath in filePathArr) {
        NSString *tem = [path stringByAppendingPathComponent:temPath];
        BOOL isDir = NO;
        if ([fileManager fileExistsAtPath:tem isDirectory:&isDir]) {
            if (isDir) {
                NSArray *temSet = [self subfilesWithPath:tem];
                [fileSet addObjectsFromArray:temSet];
            } else {
                if ([temPath hasSuffix:@".m"]) {
//                    if (![temPath isEqualToString:@"MRClassMethod.m"])
                    {
                        [fileSet addObject:tem];
                    }
                    
                    NSLog(@"%@", tem);
                }
                if ([temPath hasSuffix:@".h"]) {
                    [fileSet addObject:tem];
                    NSLog(@"%@", tem);
                }
            }
        }
    }
    return fileSet;
}

/*
 *      思路：只管严前面部分： - ( 返回类型 )
 *           第一对()是返回类型
 *           方法名和参数只管()配对，且没有{;符号，不在正则里面处理
 *           C形式参数也可以处理、匿名函数也可以
 *      不足：
 *           1）可能方法体里面内容有可能冲突，需要大量测试。比如if语句，很相似
 *           2）注释/*...🌟/ 紧贴开头无法处理。若要处理可以把methodZZ第一个+号变成*，但是可能导致方法体内容也识别成方法误区放大。
 *           3）不支持返回类型block嵌套
 */
+ ( NSArray * __nullable ) methodFromFile : ( NSString * __nonnull ) file NS_AVAILABLE_IOS(9_0) {
    NSError *error = nil;
    // 读取文件字符串
    NSString *fileStr = [[NSString alloc]initWithContentsOfFile:file encoding:NSUTF8StringEncoding error:&error];
    
    //      空白符号开头 or ; or 文件头   +-         (  除了)  ) 除了{;符号  {;
//    NSString *pattern = @"(\\s*|^)(\\+|-)\\s*\\(([^)]+)\\)([^{;]+)(\\{|;)"; // 不严谨，且解析方法难

    // const NSArray < const NSString const *  > const * const __nullable
    // 继承协议的变量、基本类型、oc类型 （不包含block） 会有修饰符，可能在不同位置出现
    NSString *protocolOrOCZZ = @"(?:\\w+\\s*){1,2}(?:\\<\\s*(?:\\w+\\s*)+(?:[*]\\s*)?\\>\\s*)?(?:\\w+\\s*)?[*]?(?:\\s*\\w+\\s*){0,2}";
    
    // 继承协议的变量、基本类型、oc类型和block，不包含or嵌套，即返回类型和参数不包含block
    //                                                               返回类型       (     ^      )      (      参数多个，可继承协议        )
    NSString *protocolOrOCOrBlockZZ = [NSString stringWithFormat:@"(?:%@)\\s*(?:\\(\\s*\\^\\s*(\\w+\\s*)?\\)\\s*\\((?:\\s*[a-zA-Z0-9_,<>*]+\\s*)*\\))?", protocolOrOCZZ];
    
    //   id id<My_Protocol3> UIView* block size_t  [[[ block: void (^)(id, int, UIView *) ]]]   有<就一定有>  有(就一定有)^
    
    //                                     空白符号开头 or ; or 文件头   +-       (    返回类型      )  方法名和参数   {;
    NSString *methodZZ = [NSString stringWithFormat:@"(?:\\s+|;|^)(\\+|-)\\s*\\(\\s*(?:%@)\\s*\\)([^{};]+)(?:\\{|;)", protocolOrOCOrBlockZZ];
   
    NSMutableArray *methods = [NSMutableArray array];
    NSInteger offset = 0;
    NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern: methodZZ options: NSRegularExpressionCaseInsensitive error: &error];
    if (!error) {
        while (YES) {
            NSTextCheckingResult *result = [regular firstMatchInString:fileStr options:0 range:NSMakeRange(offset, fileStr.length-offset)];
            if (result) {
                NSRange range = result.range;
                NSString *methodOrg = [fileStr substringWithRange:range];
                NSLog(@"method: %@", methodOrg);
                
                // 方法名和参数定义部分
                if (result.numberOfRanges >= 4) { // 第一部分是检索的整个方法、第二部分是+-符号、第三部分是返回类型、第四部分是方法名和参数。就看正则里面有多少个括号没有?:
                    range = [result rangeAtIndex:3];
                    NSString * methodTitle = [fileStr substringWithRange:range];
                    NSString *temLeft = [methodTitle stringByReplacingOccurrencesOfString:@"(" withString:@""];
                    NSString *temRight = [methodTitle stringByReplacingOccurrencesOfString:@")" withString:@""];
                    
                     // 括号个数匹配()，避免方法体里面内容混淆。
                    if (temLeft.length == temRight.length) {
                        NSString *methodStr = [self methodFromeString:methodOrg];
                        if (methodStr) {
                            SEL sel = NSSelectorFromString(methodStr);
                            [methods addObject:methodStr];
                        }
                    }
                }
                
                offset = range.location + range.length;
            } else {
                break;
            }
        }
    }
    NSLog(@"File : %@ Count : %d", [file lastPathComponent], methods.count);
    return methods;
}

+ (NSString *)methodFromeString:(NSString *)str {
    str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
    str = [str stringByReplacingOccurrencesOfString:@"\t" withString:@" "];
    str = [str substringToIndex:str.length-1];
    str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return str;
}

@end
