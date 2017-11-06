//
//  HiddenTouchEventView.m
//  EventHandlingDemo
//
//  Created by 讯心科技 on 2017/11/6.
//  Copyright © 2017年 讯心科技. All rights reserved.
//

#import "HiddenTouchEventView.h"

@implementation HiddenTouchEventView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    return nil;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"点了我");
}


@end
