//
//  JQVolumeUtil.m
//  BYMFinancing
//
//  Created by administrator on 2016/12/22.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JQVolumeUtil.h"

//使用 MPVolumeView 需要导入头文件
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

#import "AppDelegate.h"


#define Volume_Change_Notification @"Volume_Change_Notification"

@interface JQVolumeUtil ()

@property (nonatomic, strong) MPVolumeView *volumeView;

@property (nonatomic, strong) UISlider *slider;

@property (nonatomic, strong) AVAudioPlayer *voiceNotiPlayer;

@end

@implementation JQVolumeUtil



+(JQVolumeUtil *) shareInstance
{
    static JQVolumeUtil *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once (&predicate, ^{
        instance = [[self alloc] init];
    });
    return instance;
}


//http://blog.csdn.net/lg_codemachine/article/details/51520418
//UIWindow *window = [UIApplication sharedApplication].keyWindow;
- (MPVolumeView *)volumeView
{
    if (!_volumeView) {
        _volumeView = [[MPVolumeView alloc] init];
        _volumeView.frame = CGRectMake(0, 50, 100, 100);
        _volumeView.showsVolumeSlider = NO;
        _volumeView.showsRouteButton = NO;
    }
    return _volumeView;
}


- (void) loadMPVolumeView
{
    NSError *error = nil;
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:NULL];
    [[AVAudioSession sharedInstance] setActive:NO error:&error];
}

#pragma mark - addObserver 系统通知
- (void)registerVolumeChangeEvent
{
    NSError *error;
    [[AVAudioSession sharedInstance] setActive:YES error:&error];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(volumeChangedNotification:) name:@"AVSystemController_SystemVolumeDidChangeNotification" object:nil];
}

#pragma mark notification
- (void)volumeChangedNotification:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    float value = [[userInfo objectForKey:@"AVSystemController_AudioVolumeNotificationParameter"] floatValue];
    self.slider.value = value;
    [[NSNotificationCenter defaultCenter] postNotificationName:Volume_Change_Notification object:nil];
}

- (void)unregisterVolumeChangeEvent
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"AVSystemController_SystemVolumeDidChangeNotification" object:nil];
}

#pragma mark private methods    获取系统音量滑块
-(void) generateMPVolumeSlider
{
    for (UIView *view in [self.volumeView subviews]){
        if ([view.class.description isEqualToString:@"MPVolumeSlider"]){
            self.slider = (UISlider*)view;
            break;
        }
    }
}

#pragma mark set 方法 设置系统音量
- (void)setSliderVolumeValue:(float)sliderVolumeValue
{
    _sliderVolumeValue = sliderVolumeValue;
    if (!self.slider) { //确保self.slider ！= nil
        [self generateMPVolumeSlider];
    }
    self.slider.value = sliderVolumeValue;
}

- (float)sliderVolumeValue
{
    if (!self.slider) { //确保self.slider ！= nil
        [self generateMPVolumeSlider];
    }
    return self.slider.value;
}










- (void)playVoiceWithNoti:(NSString *)notiName{
    
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);//震动
    // 1.初始化播放器需要指定音乐文件的路径
    NSString *path = [[NSBundle mainBundle]pathForResource:notiName ofType:@"mp3"];
    NSFileManager *fileManager = [[NSFileManager alloc]init];
    
    if ([fileManager fileExistsAtPath:path]) {
        // 2 将路径字符串转换成url，从本地读取文件，需要使用fileURL
        NSURL *url = [NSURL fileURLWithPath:path];
        // 3.初始化背景音乐播放器
        _voiceNotiPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
        // 4.准备播放
        [_voiceNotiPlayer prepareToPlay];
        [_voiceNotiPlayer setVolume:1.0];
        [_voiceNotiPlayer setNumberOfLoops:100];
        
        NSError *error = nil;
        [[AVAudioSession sharedInstance] setActive:NO error:&error];
        
        //不管当前 系统音量是多少 ，每次播放 我就把它设置为0.5
        self.slider.value = 0.5;
        // 5.开始播放
        [_voiceNotiPlayer play];
    }
}





@end
