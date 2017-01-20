//
//  AVPlayerViewController.m
//  BYMFinancing
//
//  Created by administrator on 2017/1/16.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "AVPlayerViewController.h"
// http://flv2.bn.netease.com/videolib3/1608/23/nuWHV2742/SD/nuWHV2742-mobile.mp4
#import "AVPlayerView.h"
@interface AVPlayerViewController ()
{

}
@property (strong, nonatomic) AVPlayerView *backView;       // 底部View
@property (assign, nonatomic) BOOL          isFullScreen;   // is ？ 全屏

@end

@implementation AVPlayerViewController


//TODO: 播放单一的视频
/**
 *  全屏显示时候，隐藏导航栏、状态栏
 */
- (BOOL)prefersStatusBarHidden {
    
    if (_isFullScreen == 0) {
        return NO;
    }
    return YES;//隐藏为YES，显示为NO
}

- (void)functionOfAVPlayerWithOnlyoneVedio {
    self.backView = [[AVPlayerView alloc] initWithFrame:CGRectMake(0, 80, KScreen_Width, KScreen_Height / 2.5) WithVideoURLStr:@"http://flv2.bn.netease.com/videolib3/1608/30/zPuaL7429/SD/zPuaL7429-mobile.mp4"];
    self.backView.backgroundColor = [UIColor blackColor];
    self.backView.titleStr = @"我是超人我是超人我是超人我是超人";
    self.backView.containSuperView = self.view;
    
    BYM_WeakSelf(vcSelf);
    self.backView.hiddenStateBarBlock = ^(BOOL isFullScreen) {
        
        _isFullScreen = isFullScreen;      //isFullScreen  YES：全屏  NO：小屏 <导航栏设置>
        if (isFullScreen == YES) {
            [vcSelf.navigationController setNavigationBarHidden:YES animated:YES];
        }else {
            [vcSelf.navigationController setNavigationBarHidden:NO animated:YES];
        }
        
        if ([vcSelf respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
            [vcSelf prefersStatusBarHidden];// iOS 7
            [vcSelf performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
        }
    };
    
    [self.view addSubview:self.backView];


}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    [self functionOfAVPlayerWithOnlyoneVedio];  //播放单一的视频
  
}



@end
