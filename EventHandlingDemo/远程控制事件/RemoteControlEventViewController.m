//
//  RemoteControlEventViewController.m
//  EventHandlingDemo
//
//  Created by 讯心科技 on 2017/11/8.
//  Copyright © 2017年 讯心科技. All rights reserved.
//

#import "RemoteControlEventViewController.h"
#import <AVFoundation/AVFoundation.h>


@interface RemoteControlEventViewController ()

@property (weak, nonatomic) IBOutlet UIButton *playOrPauseButton;

@property (strong, nonatomic) AVPlayer *player;

@end


@implementation RemoteControlEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.player = [[AVPlayer alloc] initWithURL:[NSURL URLWithString:@"http://cdn.instapp.io/nat/samples/audio.mp3"]];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.player pause];
    
    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
}

- (IBAction)playOrPause:(id)sender
{
    self.playOrPauseButton.selected = !self.playOrPauseButton.selected;
    
    if (self.playOrPauseButton.selected)
    {
        [self.player play];
    }else
    {
        [self.player pause];
    }
}

#pragma mark- 处理远程控制事件
- (void)remoteControlReceivedWithEvent:(UIEvent *)event
{
    if (event.type == UIEventTypeRemoteControl)
    {
        switch (event.subtype)
        {
            case UIEventSubtypeRemoteControlPlay:

                [self.player play];

                self.playOrPauseButton.selected = YES;

                break;

            case UIEventSubtypeRemoteControlTogglePlayPause:

                if (self.playOrPauseButton.selected)
                {
                    [self.player pause];

                    self.playOrPauseButton.selected = NO;
                }else
                {
                    [self.player play];

                    self.playOrPauseButton.selected = YES;
                }

                break;

            case UIEventSubtypeRemoteControlNextTrack:

                NSLog(@"NextTrack...");

                break;

            case UIEventSubtypeRemoteControlPreviousTrack:

                NSLog(@"PreviousTrack...");

                break;

            case UIEventSubtypeRemoteControlBeginSeekingForward:

                NSLog(@"BeginSeekingForward...");

                break;

            case UIEventSubtypeRemoteControlEndSeekingForward:

                NSLog(@"EndSeekingForward...");

                break;

            case UIEventSubtypeRemoteControlBeginSeekingBackward:

                NSLog(@"BeginSeekingBackward...");

                break;

            case UIEventSubtypeRemoteControlEndSeekingBackward:

                NSLog(@"EndSeekingBackward...");

                break;

            default:
                break;
        }
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
