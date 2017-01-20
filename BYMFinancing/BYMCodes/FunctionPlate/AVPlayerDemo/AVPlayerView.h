//
//  AVPlayerView.h
//  BYMFinancing
//
//  Created by administrator on 2017/1/16.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
//相关博客 http://www.2cto.com/kf/201609/544576.html
@interface AVPlayerView : UIView

@property (nonatomic,strong) UIView *containSuperView;  //AVPlayerView 所添加的父视图
@property (nonatomic,copy) NSString *titleStr;          //设置 video title
@property (nonatomic,assign)UIInterfaceOrientation interfaceOrientation; //设置横屏显示的方向 默认向右
@property(nonatomic,copy)void(^hiddenStateBarBlock)(BOOL isFullScreen ); //点击全屏按钮调用

- (void)loadVideoURLStr:(NSString *)videoStr;
/**;
 *  传递一个Url 地址
 */
- (instancetype)initWithFrame:(CGRect)frame WithVideoURLStr:(NSString *)videoStr;

/**
 *  功能： 播放单一的视频，实现全屏显示功能
 *
 */


/**
 * 注意：
 当项目打全局断点的时候 会遇到异常如下：
 libc++abi.dylib`__cxa_throw: 使用[AVAudioPlayer play]会产生__cxa_throw异常
 
 开发中遇到一个奇怪的异常。我调用AVAudioPlayer play方法，会莫名的产生__cxa_throw异常， 只是简单的调用系统的api，有时候可以，有时候会异常。
 
 * 解决方案：
    编辑全局断点，设置 exception: 把 all 改成 obejct -c 即可 
    参考博客 http://blog.csdn.net/yancechen2013/article/details/52622447
 */
@end
