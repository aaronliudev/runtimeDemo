//
//  People.m
//  runtimeDemo
//
//  Created by Alan on 2017/3/19.
//  Copyright © 2017年 Alan. All rights reserved.
//

#import "People.h"
#import <objc/runtime.h>

@interface People()

@property (nonatomic, assign) NSInteger age;

@end

@implementation People

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)speak
{
    NSLog(@"age is %ld", self.age);
}

- (void)saying
{
    NSLog(@"I'm saying");
}

//MARK: - 消息转发 第一步，将调用的方法指定到另一个方法

+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    if (![NSStringFromSelector(sel) isEqualToString:@"running"]) {
        return [super forwardingTargetForSelector:sel];
    }
    Class class = [self class];
    SEL newSel = NSSelectorFromString(@"runningSay");
    Method newMethod = class_getInstanceMethod(class, newSel);
    IMP newImp = method_getImplementation(newMethod);
    // 调用时，需确定要添加的方法已经实现。
    class_addMethod(class, sel, newImp, method_getTypeEncoding(newMethod));
    
    // 当调用C的函数时这样用：
//    class_addMethod(class, sel, (IMP)runningSay2, "");
    
    // cls 需要动态决议的类
    // name 需要动态决议的方法
    // imp 需要执行的的方法的指针，（函数指针）
    // types 类型 函数类型（字符串） v:返回值void @:参数id类型 ":":SEL对象 i:int d:double
    
    return YES;
}

// 第一步中，函数的声明，可以时oc类型，也可以是c函数
- (void)runningSay {
    NSLog(@"now, I'm running");
}

void runningSay2() {
    printf("now, this is a c func");
}

+ (BOOL)resolveClassMethod:(SEL)sel
{
    IMP imp = [self methodForSelector:@selector(test)];
    // 添加类方法需要，之前说过类方法其实就是类对象调用的方法，在元类的方法列表中。以下两种方式获取元类，并添加类方法
    Class class1 = object_getClass([self class]);
    Class class2 = objc_getMetaClass([NSStringFromClass([self class]) cStringUsingEncoding:NSUTF8StringEncoding]);
    class_addMethod(class2 , sel, imp , "");
    
    return YES;
}

+ (void)test
{
    NSLog(@"class method test...");
}


//MARK: - 第二步
/*
+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    return NO;
}

// 第一步 返回NO，则第二步返回一个id，接收sel
- (id)forwardingTargetForSelector:(SEL)aSelector
{
    NSString *selectorStr = NSStringFromSelector(aSelector);
    if ([selectorStr isEqualToString:@"running"]) {
        Father *father = [Father new];
        return father;
    }
    return nil;
}
 */

//MARK: - 第三步
/*
+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    return NO;
}

// 第一步 返回NO，则第二步返回一个id，接收sel
- (id)forwardingTargetForSelector:(SEL)aSelector
{
    return nil;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    SEL sel = anInvocation.selector;
    if ([Father instancesRespondToSelector:sel]) {
        [anInvocation invokeWithTarget:[Father new]];
    }
    else {
        [super forwardInvocation:anInvocation];
    }
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    return [[Father class] instanceMethodSignatureForSelector:aSelector];
}
*/

@end


@implementation Father

- (void)running
{
    NSLog(@"father running....");
}

@end
