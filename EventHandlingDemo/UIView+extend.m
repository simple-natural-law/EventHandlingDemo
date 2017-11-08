//
//  UIView+extend.m
//  EventHandlingDemo
//
//  Created by 讯心科技 on 2017/11/3.
//  Copyright © 2017年 讯心科技. All rights reserved.
//

#import "UIView+extend.h"
#import <objc/runtime.h>

@implementation UIView (extend)

+ (void)load
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        SEL originalSelector = @selector(hitTest:withEvent:);

        SEL currentSelector = NSSelectorFromString(@"z_hitTest:withEvent:");

        Method original = class_getInstanceMethod([self class], originalSelector);

        Method current  = class_getInstanceMethod([self class], currentSelector);

        method_exchangeImplementations(original, current);
    });
}

- (UIView *)z_hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    NSLog(@"hitTest: %@",NSStringFromClass(self.class));
    
    return [self z_hitTest:point withEvent:event];
}


@end
