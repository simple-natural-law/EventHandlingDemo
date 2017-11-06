//
//  ResponderChainViewController.m
//  EventHandlingDemo
//
//  Created by 讯心科技 on 2017/10/9.
//  Copyright © 2017年 讯心科技. All rights reserved.
//

#import "ResponderChainViewController.h"

@interface ResponderChainViewController ()

@end



@implementation ResponderChainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


#warning - 如果点击A视图(触摸点在A视图且不在A视图的子视图上)，A视图不处理这个触摸事件，且A视图的父视图也不处理这个事件，那么触摸事件将传递给本视图控制器处理。
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesBegan -> %@ \n touch view -> %@",self.class, [touches allObjects].lastObject.view.class);
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesMoved -> %@ \n touch view -> %@",self.class, [touches allObjects].lastObject.view.class);
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesEnded -> %@ \n touch view -> %@",self.class, [touches allObjects].lastObject.view.class);
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesCancelled -> %@ \n touch view -> %@",self.class, [touches allObjects].lastObject.view.class);
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
