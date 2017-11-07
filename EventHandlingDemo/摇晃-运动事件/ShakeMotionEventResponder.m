//
//  ShakeMotionEventResponder.m
//  EventHandlingDemo
//
//  Created by 讯心科技 on 2017/11/7.
//  Copyright © 2017年 讯心科技. All rights reserved.
//

#import "ShakeMotionEventResponder.h"

@implementation ShakeMotionEventResponder

//#pragma mark- 处理摇晃-运动事件
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake) // 摇晃-运动事件
    {
        NSLog(@"开始摇晃...");
    }
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake) // 摇晃-运动事件
    {
        NSLog(@"摇晃结束...");
    }
}

@end
