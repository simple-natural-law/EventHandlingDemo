//
//  UIResponder+FirstResponder.m
//  EventHandlingDemo
//
//  Created by 讯心科技 on 2017/11/8.
//  Copyright © 2017年 讯心科技. All rights reserved.
//

#import "UIResponder+FirstResponder.h"

static __weak id currentFirstResponder;

@implementation UIResponder (FirstResponder)

+(id)currentFirstResponder
{
    currentFirstResponder = nil;
    
    [[UIApplication sharedApplication] sendAction:@selector(findFirstResponder:) to:nil from:nil forEvent:nil];
    
    return currentFirstResponder;
}

-(void)findFirstResponder:(id)sender
{
    currentFirstResponder = self;
}

@end
