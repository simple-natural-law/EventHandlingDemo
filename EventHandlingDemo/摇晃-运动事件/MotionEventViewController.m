//
//  MotionEventViewController.m
//  EventHandlingDemo
//
//  Created by 讯心科技 on 2017/11/7.
//  Copyright © 2017年 讯心科技. All rights reserved.
//

#import "MotionEventViewController.h"
#import "ShakeMotionEventResponder.h"

@interface MotionEventViewController ()

@property (nonatomic, strong)  ShakeMotionEventResponder *firstResponder;

@end


@implementation MotionEventViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.firstResponder = [[ShakeMotionEventResponder alloc] initWithFrame:self.view.bounds];

    [self.view addSubview:self.firstResponder];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}


- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

#pragma mark- 处理摇晃-运动事件
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
