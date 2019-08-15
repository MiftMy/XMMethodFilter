//
//  MyFunc.m
//  XMFrame
//
//  Created by Mifit on 2019/8/14.
//  Copyright © 2019 Mifit. All rights reserved.
//

#import "MyFunc.h"
#import <UIKit/UIKit.h>

@protocol MyPro_3 <NSObject>
@end

@interface MYClass_3 : NSObject

@end
// 20个方法，其中有没名字的方法。系统只提示16个
@implementation MyFunc
// 无返回值、无参数
- (void)myFuncNone {
    
}

// 无返回值、1参数
- (void)myFuncOne:(NSString *)vla {
    
}

// 无返回值、2参数
- (void)myFuncTwo:(NSString *)val1 with:(NSArray *)val2 {
    
}

// 1返回值、无参数
- (NSArray *)myFuncReturn {
    return nil;
}

// 1返回值、1参数
- (NSArray *)myFuncReturnVal : (NSObject *) obj {
    return nil;
}

// 1返回值、2参数
- (NSArray *)myFuncReturnVal : (NSObject *) obj with :(NSMutableSet *)set {
    return nil;
}

// 返回值带协议的
- (id<MyPro_3>)myFuncReturnPro:(char [])sfd {
    return nil;
}

// 参数协议和类型说明的的
+ ( void ) myFuncProType : ( id<MyPro_3> ) val1 with :( NSArray<NSString *> *) val2 {}

// 返回值带协议
- (const id<MyPro_3> ) myFuncProTypeReturn : ( id<MyPro_3> ) val1 with :( NSArray<NSString *> *) val2 {
    return nil;
}

// 返回值带自定义对象。 参数带协议和自定义数组
+ ( const NSArray < const MYClass_3 const * > const * const __nonnull) myFuncProTypeCusReturn : ( id<MyPro_3> ) val1 with :( NSArray<NSString *> *) val2 {
    int vvv = 1;
    int vv = 3;
    if ( vvv - (vv)) {
        
    }
    return nil;
}

// 返回值带block
- (void (^)(void))myFuncReturnBlock {
    return nil;
}

// 返回值带block，有自定义协议和数据
+ (__nonnull id<MyPro_3> (^)(void))myFuncReturnBlockCus {
    return nil;
}

// 返回值带block，有自定义协议和数据
- (id<MyPro_3> (^)(MYClass_3 *, int, NSArray<NSString *> *, id<MyPro_3>))myFuncReturnBlockCusCls : ( id<MyPro_3> ) val1 with :( NSArray<NSString *> *) val2 {
    return nil;
}

// 返回值带block，有自定义协议和数据，参数也有block
+ (id<MyPro_3> (^)(MYClass_3 *, int, NSArray<NSString *> *, id<MyPro_3>))myFuncReturnBlockCusCls : ( id<MyPro_3> ) val1 with :( NSArray<NSString *> *) val2 mt:(id<MyPro_3> (^)(MYClass_3 *, int, NSArray<NSString *> *, id<MyPro_3>))block {
    return nil;
}

// 返回值带block，有自定义协议和数据，参数也有block 带修饰符的
- (id<MyPro_3> (^)(MYClass_3 *, int, NSArray<NSString *> *, id<MyPro_3>))myFuncReturnBlockCusClsConst : ( const id<MyPro_3> __nonnull ) val1 with :( NSArray<NSString *> const * const __nonnull ) val2 mt:(id<MyPro_3> (^)(MYClass_3 *, int, NSArray<NSString *> *, id<MyPro_3>))block st:(id<MyPro_3> (^)(MYClass_3 *, int, NSArray<NSString *> *, id<MyPro_3>))block {
    return nil;
}

// 带使用版本的
+ (id<MyPro_3> (^ __nullable )(MYClass_3 *, int, NSArray<NSString *> *, id<MyPro_3>)  )myFuncReturnBlockCusClsConstVersion : ( const id<MyPro_3> __nonnull ) val1 with :( NSArray<NSString *> const * const __nonnull ) val2 mt:(id<MyPro_3> (^)(MYClass_3 *, int, NSArray<NSString *> *, id<MyPro_3>))block NS_AVAILABLE_IOS(9_0) {
    return nil;
}

// 带各种控制符的： 空格、回车、tab。你压根看不懂的方式，就是上面方法加了很多\n \t space
    -
    (
     id
     <
     MyPro_3
     >
     (
     ^
     )
     (
      MYClass_3
      *
      ,
      int
      ,
      NSArray
      <
      NSString
      *
      >
      *
      ,
      id
      <
      MyPro_3
      >
      )
     )
    myFuncReturnBlockCusClsConstVersionCtl
    :
    (
     const
     id
     <
     MyPro_3
     >
     __nonnull
     )
    val1
     with
    :
    (
     NSArray
     <
     NSString
     *
     >
     const
     *
     const __nonnull
     )
    val2
    mt
    :
     (
      id
      <
      MyPro_3
      >
      (
      ^
      )
      (
       MYClass_3
       *
       ,
       int
       ,
       NSArray
       <
       NSString
       *
       >
       *
       ,
       id
       <
       MyPro_3
       >
       )
      )
    block NS_AVAILABLE_IOS(9_0)
{
    return nil;
}

// 随便一个系统方法，参数带block
- (instancetype)initWithTitle:(nullable NSString *)title image:(UIImage *)image style:(UIAlertActionStyle)style handler:(void (^ __nullable)(UIAlertAction *action))handler {
    if (self = [super init]) {

    }
    return self;
}

// 没名字的方法，可以直接调用，但是头上系统方法列表没显示
+ (id):(NSString *)val :(NSArray *)sdf {
    [self :@"" sdf:nil];
    return nil;
}

+ (id):(NSString *)val sdf:(NSArray *)sdf {
    [self :@"" :nil];
    return nil;
}
@end
