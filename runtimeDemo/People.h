//
//  People.h
//  runtimeDemo
//
//  Created by Alan on 2017/3/19.
//  Copyright © 2017年 Alan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface People : NSObject

- (void)saying;
- (void)running;

- (void)speak;

// 类方法的消息转发测试
+ (void)test2;


@end

@interface Father : NSObject

- (void)running;

@end
