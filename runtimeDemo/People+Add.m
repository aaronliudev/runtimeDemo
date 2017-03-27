//
//  People+Add.m
//  runtimeDemo
//
//  Created by Alan on 2017/3/19.
//  Copyright © 2017年 Alan. All rights reserved.
//

#import "People+Add.h"
#import <objc/runtime.h>

static char *PeopleName;

@implementation People (Add)

- (void)setName:(NSString *)name
{
    objc_setAssociatedObject(self, PeopleName, name, OBJC_ASSOCIATION_COPY);
}

- (NSString *)name
{
    return objc_getAssociatedObject(self, PeopleName);
}

@end
