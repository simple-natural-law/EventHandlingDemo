//
//  ViewBBB.m
//  EventHandlingDemo
//
//  Created by 讯心科技 on 2017/11/3.
//  Copyright © 2017年 讯心科技. All rights reserved.
//

#import "ViewBBB.h"

@implementation ViewBBB

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@ -> touchesBegan",self.class);
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@ -> touchesMoved",self.class);
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@ -> touchesEnded",self.class);
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@ -> touchesCancelled",self.class);
}

@end
