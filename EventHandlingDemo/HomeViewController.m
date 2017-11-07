//
//  HomeViewController.m
//  EventHandlingDemo
//
//  Created by 讯心科技 on 2017/10/9.
//  Copyright © 2017年 讯心科技. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@property (nonatomic, strong) NSArray *dataArray;

@end



@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray = @[@{@"title":@"触摸事件响应链",@"target":@"ResponderChainViewController"},
                       @{@"title":@"不规则视图点击",@"target":@"IrregularViewController"},
                       @{@"title":@"隐藏子视图触摸事件",@"target":@"HiddenTouchEventViewController"},
                       @{@"title":@"摇晃-运动事件",@"target":@"MotionEventViewController"}];
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.dataArray[indexPath.row][@"title"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:self.dataArray[indexPath.row][@"target"]];
    
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
