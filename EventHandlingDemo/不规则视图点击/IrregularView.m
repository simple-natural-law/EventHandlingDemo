//
//  IrregularView.m
//  EventHandlingDemo
//
//  Created by 讯心科技 on 2017/11/6.
//  Copyright © 2017年 讯心科技. All rights reserved.
//

#import "IrregularView.h"

@implementation IrregularView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.layer.cornerRadius  = 100.0;
    self.layer.masksToBounds = YES;
}


- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    CGFloat xOffset = point.x - 100;
    CGFloat yOffset = point.y - 100;
    CGFloat radius = sqrt(xOffset * xOffset + yOffset * yOffset);
    return radius <= 100.0;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"点击了圆形视图");
}

@end

