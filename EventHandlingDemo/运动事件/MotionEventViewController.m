//
//  MotionEventViewController.m
//  EventHandlingDemo
//
//  Created by 讯心科技 on 2017/11/7.
//  Copyright © 2017年 讯心科技. All rights reserved.
//

#import "MotionEventViewController.h"

@interface MotionEventViewController ()

@end

@implementation MotionEventViewController

#pragma mark- 允许被指定为第一响应者
- (BOOL)canBecomeFirstResponder
{
    return YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // 指定为第一响应者
    [self becomeFirstResponder];
}

- (void)viewDidDisappear:(BOOL)animated
{
    // 注销第一响应者身份
    [self resignFirstResponder];
}

#pragma mark- 处理运动事件
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
