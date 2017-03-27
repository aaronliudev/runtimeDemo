//
//  ViewController.m
//  runtimeDemo
//
//  Created by Alan on 2017/3/19.
//  Copyright © 2017年 Alan. All rights reserved.
//

#import "ViewController.h"
#import "People.h"
#import "People+Add.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    People *p = [[People alloc] init];
/*
    // 实力方法的消息转发
    [p running];
    // 类方法的消息转发
    [People test2];
 */
    
/*
    p.name = @"runtime";
    NSLog(@"name = %@", p.name);
 */
    
    // 第二题
/*
    BOOL res1 = [(id)[NSObject class] isKindOfClass:[NSObject class]];
    BOOL res2 = [(id)[NSObject class] isMemberOfClass:[NSObject class]];
    BOOL res3 = [(id)[People class] isKindOfClass:[People class]];
    BOOL res4 = [(id)[People class] isMemberOfClass:[People class]];
    NSLog(@" bool = %d, %d, %d, %d", res1, res2, res3, res4);
 */
    
    
    // 第四题
    id cls = [People class];
    void *obj = &cls;
    [(__bridge id)obj speak];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
