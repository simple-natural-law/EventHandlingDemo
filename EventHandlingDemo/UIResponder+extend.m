//
//  UIResponder+extend.m
//  EventHandlingDemo
//
//  Created by 讯心科技 on 2017/11/3.
//  Copyright © 2017年 讯心科技. All rights reserved.
//

#import "UIResponder+extend.h"
#import <objc/runtime.h>


@implementation UIResponder (extend)

+ (void)swizzleOriginalSelector:(SEL)originalSelector withCurrentSelector:(SEL)currentSelector
{
    Class class = [self class];
    
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, currentSelector);
    
    BOOL didAddMethod =
    class_addMethod(class,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class,
                            currentSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

+ (void)load
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        if (self == [UIResponder class])
        {
            SEL originalSelector1 = @selector(touchesBegan:withEvent:);
            SEL currentSelector1  = NSSelectorFromString(@"z_touchesBegan:withEvent:");
            [self swizzleOriginalSelector:originalSelector1 withCurrentSelector:currentSelector1];
            
            SEL originalSelector2 = @selector(touchesMoved:withEvent:);
            SEL currentSelector2  = NSSelectorFromString(@"z_touchesMoved:withEvent:");
            [self swizzleOriginalSelector:originalSelector2 withCurrentSelector:currentSelector2];
            
            SEL originalSelector3 = @selector(touchesEnded:withEvent:);
            SEL currentSelector3  = NSSelectorFromString(@"z_touchesEnded:withEvent:");
            [self swizzleOriginalSelector:originalSelector3 withCurrentSelector:currentSelector3];
        }
    });
}


- (void)z_touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touch begin: ------%@",self.class);
    
    [self z_touchesBegan:touches withEvent:event];
}

- (void)z_touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touch moved: ------%@",self.class);
    
    [self z_touchesMoved:touches withEvent:event];
}

- (void)z_touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touch ended: ------%@",self.class);
    
    [self z_touchesEnded:touches withEvent:event];
}


@end
