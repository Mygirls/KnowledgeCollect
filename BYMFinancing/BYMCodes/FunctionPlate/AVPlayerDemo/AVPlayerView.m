//
//  AVPlayerView.m
//  BYMFinancing
//
//  Created by administrator on 2017/1/16.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "AVPlayerView.h"
#import <Masonry.h>
#import <AVFoundation/AVFoundation.h>

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface AVPlayerView ()

@property (nonatomic,strong) AVPlayer *player; // 播放器
@property (nonatomic,strong) AVPlayerItem *playerItem; // 播放器属性对象
@property (nonatomic,strong) AVPlayerLayer *playerLayer; // 播放器需要的layer
@property (nonatomic,assign) BOOL isDragSlider; // 是否拖动Slider

// 顶部View （close button  和  title）
@property (nonatomic,strong) UIView *topView;
@property (nonatomic,strong) UIButton *closeButton;
@property (nonatomic,strong) UILabel *titleLabel;

// 底部BottmView
@property (nonatomic,strong) UIView *bottomView;
@property (nonatomic,strong) UIButton *playButton;
@property (nonatomic,strong) UIButton *fullScreenButton;
@property (nonatomic,strong) UIProgressView *progressView;
@property (nonatomic,strong) UISlider *slider;
@property (nonatomic,strong) UILabel *nowLabel;
@property (nonatomic,strong) UILabel *remainLabel;

// 是否全屏
@property (nonatomic,assign) BOOL isFullScreen;
// 定时器 自动消失View
@property (nonatomic,strong) NSTimer *autoDismissTimer;

@end

@implementation AVPlayerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.isFullScreen = NO;
        self.interfaceOrientation =UIInterfaceOrientationLandscapeRight;    //默认向右
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
        [self addGestureRecognizer:tap];
        
        [self initUI];

    }
    return self;
}

- (void)loadVideoURLStr:(NSString *)videoStr {
    [self initAVPlayerWithVideoURLStr:videoStr];
}

- (instancetype)initWithFrame:(CGRect)frame WithVideoURLStr:(NSString *)videoStr
{
    self = [super initWithFrame:frame];
    if (self) {
        self.isFullScreen = NO;
        self.interfaceOrientation =UIInterfaceOrientationLandscapeRight;    //默认向右
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
        [self addGestureRecognizer:tap];
        
        [self initUI];
        
        [self initAVPlayerWithVideoURLStr:videoStr];
    }
    return self;
}

//TODO: 第一部分： 创建UI、AVPlayer 相关对象
- (void)initUI
{
    self.topView = [[UIView alloc] init]; // 顶部栏
    self.topView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    [self addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).with.offset(0);
        make.right.equalTo(self).with.offset(0);
        make.top.equalTo(self).with.offset(0);
        make.height.mas_equalTo(50);
        
    }];
    
    // 顶部删除按钮
    self.closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.closeButton setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    self.closeButton.showsTouchWhenHighlighted = YES;
    [self.closeButton addTarget:self action:@selector(closeButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:self.closeButton];
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topView).with.offset(5);
        make.centerY.equalTo(self.topView);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    // 顶部Label
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    self.titleLabel.text = @"";
    [self.topView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.closeButton).with.offset(10);
        make.centerY.equalTo(self.topView);
        make.right.equalTo(self.topView).with.offset(-20);
        make.height.mas_equalTo(30);
    }];
    
    // 底部栏
    self.bottomView = [[UIView alloc] init];
    self.bottomView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    [self addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(0);
        make.right.equalTo(self).with.offset(0);
        make.bottom.equalTo(self).with.offset(0);
        make.height.mas_equalTo(50);
    }];
    
    // 底部pause或者play
    self.playButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.playButton setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    self.playButton.showsTouchWhenHighlighted = YES;
    [self.playButton addTarget:self action:@selector(pauseOrPlay:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:self.playButton];
    [self.playButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bottomView).with.offset(5);
        make.centerY.equalTo(self.bottomView);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    // 底部全屏按钮
    self.fullScreenButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.fullScreenButton setImage:[UIImage imageNamed:@"fullscreen"] forState:UIControlStateNormal];
    self.fullScreenButton.showsTouchWhenHighlighted = YES;
    [self.fullScreenButton addTarget:self action:@selector(clickFullScreen:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:self.fullScreenButton];
    [self.fullScreenButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bottomView).with.offset(-5);
        make.centerY.equalTo(self.bottomView);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    // 底部进度条
    self.slider = [[UISlider alloc] init];
    self.slider.minimumValue = 0.0;
    self.slider.minimumTrackTintColor = [UIColor greenColor];
    self.slider.maximumTrackTintColor = [UIColor clearColor];
    self.slider.value = 0.0;
    [self.slider setThumbImage:[UIImage imageNamed:@"dot"] forState:UIControlStateNormal];
    
    [self.slider addTarget:self action:@selector(sliderDragValueChange:) forControlEvents:UIControlEventValueChanged];
    
    [self.slider addTarget:self action:@selector(sliderTapValueChange:) forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer *tapSlider = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchSlider:)];
    [self.slider addGestureRecognizer:tapSlider];
    [self.bottomView addSubview:self.slider];
    [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.bottomView).with.offset(45);
        make.right.equalTo(self.bottomView).with.offset(-45);
        make.centerY.equalTo(self.bottomView);
        
    }];
    
    // 底部缓存进度条
    self.progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    self.progressView.progressTintColor = [UIColor blueColor];
    self.progressView.trackTintColor = [UIColor lightGrayColor];
    [self.bottomView addSubview:self.progressView];
    [self.progressView setProgress:0.0 animated:NO];
    
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.slider).with.offset(0);
        make.right.equalTo(self.slider);
        make.height.mas_equalTo(2);
        make.centerY.equalTo(self.slider).with.offset(1);
    }];
    [self.bottomView sendSubviewToBack:self.progressView];
    
    // 底部左侧时间轴
    self.nowLabel = [[UILabel alloc] init];
    self.nowLabel.textColor = [UIColor whiteColor];
    self.nowLabel.font = [UIFont systemFontOfSize:13];
    self.nowLabel.textAlignment = NSTextAlignmentLeft;
    [self.bottomView addSubview:self.nowLabel];
    [self.nowLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.slider.mas_left).with.offset(0);
        make.top.equalTo(self.slider.mas_bottom).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    
    // 底部右侧时间轴
    self.remainLabel = [[UILabel alloc] init];
    self.remainLabel.textColor = [UIColor whiteColor];
    self.remainLabel.font = [UIFont systemFontOfSize:13];
    self.remainLabel.textAlignment = NSTextAlignmentRight;
    [self.bottomView addSubview:self.remainLabel];
    [self.remainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.slider.mas_right).with.offset(0);
        make.top.equalTo(self.slider.mas_bottom).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    

}

- (void)initAVPlayerWithVideoURLStr:(NSString *)videoStr {
    // 初始化播放器item
    self.playerItem = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:videoStr]];
    self.player = [[AVPlayer alloc] initWithPlayerItem:self.playerItem];
    
    // 初始化播放器的Layer
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    
    self.playerLayer.frame = self.bounds;// layer的frame
    
    // layer的填充属性 和UIImageView的填充属性类似
    // AVLayerVideoGravityResizeAspect 等比例拉伸，会留白
    // AVLayerVideoGravityResizeAspectFill // 等比例拉伸，会裁剪
    // AVLayerVideoGravityResize // 保持原有大小拉伸
    self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    [self.layer insertSublayer:self.playerLayer atIndex:0];// 把Layer加到底部View上
    
    // 监听播放器状态变化 、 监听缓存大小 、 旋转屏幕通知
    [self.playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    
    [self.playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onDeviceOrientationChange)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil
     ];

}


//TODO: 第二部分： 监听播放器状态变化 、 监听缓存大小 、 旋转屏幕通知

// 监听播放器的变化属性
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    NSLog(@"key = %@",keyPath);
    if ([keyPath isEqualToString:@"status"])
    {
        AVPlayerItemStatus statues = [change[NSKeyValueChangeNewKey] integerValue];
        switch (statues) {
            case AVPlayerItemStatusReadyToPlay:
                
                // 最大值直接用sec，以前都是
                // CMTimeMake(帧数（slider.value * timeScale）, 帧/sec)
                self.slider.maximumValue = CMTimeGetSeconds(self.playerItem.duration);
                [self initTimer];
                
                // 启动定时器 5秒自动隐藏
                if (!self.autoDismissTimer){
                    self.autoDismissTimer = [NSTimer timerWithTimeInterval:8.0 target:self selector:@selector(autoDismissView:) userInfo:nil repeats:YES];
                    [[NSRunLoop currentRunLoop] addTimer:self.autoDismissTimer forMode:NSDefaultRunLoopMode];
                }
                break;
            case AVPlayerItemStatusUnknown:

                break;
            case AVPlayerItemStatusFailed:

                break;
            default:
                break;
        }
    }
    else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {// 监听缓存进度的属性
        
        // 计算缓存进度
        NSTimeInterval timeInterval = [self availableDuration];
        // 获取总长度
        CMTime duration = self.playerItem.duration;
        
        CGFloat durationTime = CMTimeGetSeconds(duration);
        // 监听到了给进度条赋值
        [self.progressView setProgress:timeInterval / durationTime animated:NO];
    }
    
}

// 调用plaer的对象进行UI更新
- (void)initTimer
{
    // player的定时器
    __weak typeof(self)weakSelf = self;
    // 每秒更新一次UI Slider
    [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        
        // 当前时间
        CGFloat nowTime = CMTimeGetSeconds(weakSelf.playerItem.currentTime);
        // 总时间
        CGFloat duration = CMTimeGetSeconds(weakSelf.playerItem.duration);
        // sec 转换成时间点
        weakSelf.nowLabel.text = [weakSelf convertToTime:nowTime];
        weakSelf.remainLabel.text = [weakSelf convertToTime:(duration - nowTime)];
        
        // 不是拖拽中的话更新UI
        if (!weakSelf.isDragSlider)
        {
            weakSelf.slider.value = CMTimeGetSeconds(weakSelf.playerItem.currentTime);
        }
        
    }];
}

/**
 *  计算缓冲进度
 *
 *  @return 缓冲进度
 */
- (NSTimeInterval)availableDuration {
    NSArray *loadedTimeRanges = [self.playerItem loadedTimeRanges];
    CMTimeRange timeRange     = [loadedTimeRanges.firstObject CMTimeRangeValue];// 获取缓冲区域
    float startSeconds        = CMTimeGetSeconds(timeRange.start); // 开始的点
    float durationSeconds     = CMTimeGetSeconds(timeRange.duration); // 已缓存的时间点
    NSTimeInterval result     = startSeconds + durationSeconds;// 计算缓冲总进度
    return result;
}

- (void)onDeviceOrientationChange   //旋转屏幕通知
{
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)orientation;
    switch (interfaceOrientation) {
        case UIInterfaceOrientationPortraitUpsideDown:{
            NSLog(@"第3个旋转方向---电池栏在下");
        }
            break;
        case UIInterfaceOrientationPortrait:{
            NSLog(@"第0个旋转方向---电池栏在上");
            [self toCell];
        }
            break;
        case UIInterfaceOrientationLandscapeLeft:{
            NSLog(@"第2个旋转方向---电池栏在右");
            [self toFullScreenWithInterfaceOrientation:interfaceOrientation];
        }
            break;
        case UIInterfaceOrientationLandscapeRight:{
            NSLog(@"第1个旋转方向---电池栏在左");
            [self toFullScreenWithInterfaceOrientation:interfaceOrientation];
        }
            break;
        default:
            break;
    }
}


//TODO: 第三部分： UI 上的相关 事件（单击手势、全屏显示、缩小显示）
- (void)singleTap:(UITapGestureRecognizer *)tap
{
    // 和即时搜索一样，删除之前未执行的操作
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(autoDismissView:) object:nil];
    
    // 这里点击会隐藏对应的View，那么之前的定时还开着，如果不关掉，就会可能重复
    [self.autoDismissTimer invalidate];
    self.autoDismissTimer = nil;
    self.autoDismissTimer = [NSTimer timerWithTimeInterval:8.0 target:self selector:@selector(autoDismissView:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.autoDismissTimer forMode:NSDefaultRunLoopMode];
    
    [UIView animateWithDuration:1.0 animations:^{
        if (self.bottomView.alpha == 1){
            self.bottomView.alpha = 0;
            self.topView.alpha = 0;
        }else if (self.bottomView.alpha == 0) {
            self.bottomView.alpha = 1.0f;
            self.topView.alpha = 1.0f;
        }
    }];
}

//自动隐藏bottom和top
- (void)autoDismissView:(NSTimer *)timer
{
    if (self.player.rate == 0){
        // 暂停状态就不隐藏
    }
    else if (self.player.rate == 1) {
        if (self.bottomView.alpha == 1) {
            [UIView animateWithDuration:1.0 animations:^{
                
                self.bottomView.alpha = 0;
                self.topView.alpha = 0;
                
            }];
        }
    }
}

//点击全屏
- (void)clickFullScreen:(UIButton *)button
{
    if (!self.isFullScreen){
        [self toFullScreenWithInterfaceOrientation:self.interfaceOrientation];
        [self.fullScreenButton setImage:[UIImage imageNamed:@"nonfullscreen@3x"] forState:UIControlStateNormal];
    }else{
        [self toCell];
        [self.fullScreenButton setImage:[UIImage imageNamed:@"fullscreen@3x"] forState:UIControlStateNormal];
    }
    self.isFullScreen = !self.isFullScreen;
    
    if (self.hiddenStateBarBlock) {
        self.hiddenStateBarBlock(_isFullScreen);
    }

}

// 全屏显示
-(void)toFullScreenWithInterfaceOrientation:(UIInterfaceOrientation )interfaceOrientation{
    
    [self removeFromSuperview];                 // 先移除之前的
    
    self.transform = CGAffineTransformIdentity; // 初始化
    if (interfaceOrientation==UIInterfaceOrientationLandscapeLeft) {
        self.transform = CGAffineTransformMakeRotation(-M_PI_2);
    }else if(interfaceOrientation==UIInterfaceOrientationLandscapeRight){
        self.transform = CGAffineTransformMakeRotation(M_PI_2);
    }
    // BackView的frame能全屏
    self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    // layer的方向宽和高对调
    self.playerLayer.frame = CGRectMake(0, 0, kScreenHeight, kScreenWidth);
    
    // remark 约束
    [self.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(50);
        make.top.mas_equalTo(kScreenWidth-50);
        make.left.equalTo(self).with.offset(0);
        make.width.mas_equalTo(kScreenHeight);
    }];
    
    [self.topView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(50);
        make.left.equalTo(self).with.offset(0);
        make.width.mas_equalTo(kScreenHeight);
    }];
    
    [self.closeButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(5);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(30);
        make.top.equalTo(self).with.offset(10);
        
    }];
    
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topView).with.offset(45);
        make.right.equalTo(self.topView).with.offset(-45);
        make.center.equalTo(self.topView);
        make.top.equalTo(self.topView).with.offset(0);
    }];
    
    [self.nowLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.slider.mas_left).with.offset(0);
        make.top.equalTo(self.slider.mas_bottom).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    
    [self.remainLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.slider.mas_right).with.offset(0);
        make.top.equalTo(self.slider.mas_bottom).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    
    // 加到window上面
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
}


// 缩小到cell
-(void)toCell{
    // 先移除
    [self removeFromSuperview];
    
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.5f animations:^{
        weakSelf.transform = CGAffineTransformIdentity;
        weakSelf.frame = CGRectMake(0, 80, kScreenWidth, kScreenHeight / 2.5);
        weakSelf.playerLayer.frame =  weakSelf.bounds;
        // 再添加到View上
        [weakSelf.containSuperView addSubview:weakSelf];
        
        // remark约束
        [self.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf).with.offset(0);
            make.right.equalTo(weakSelf).with.offset(0);
            make.height.mas_equalTo(50);
            make.bottom.equalTo(weakSelf).with.offset(0);
        }];
        [self.topView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf).with.offset(0);
            make.right.equalTo(weakSelf).with.offset(0);
            make.height.mas_equalTo(50);
            make.top.equalTo(weakSelf).with.offset(0);
        }];
        
        [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf).with.offset(5);
            make.centerY.equalTo(weakSelf.topView);
            make.size.mas_equalTo(CGSizeMake(30, 30));
        }];
    }completion:^(BOOL finished) {
        
    }];
    
}

//TODO: 第四部分： UI 上的相关 事件（close全屏、暂停或者播放、slider的更改）
- (void)closeButton:(UIButton *)button
{
    if (self.isFullScreen)
    {
        [self clickFullScreen:nil];
    }
}

// 暂停或者播放
- (void)pauseOrPlay:(UIButton *)sender
{
    if (self.player.rate != 1.0f){
        [sender setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
        [self.player play];
    }else{
        [sender setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
        [self.player pause];
    }
}

// slider的更改
// 拖拽的时候调用  这个时候不更新视频进度
- (void)sliderDragValueChange:(UISlider *)slider
{
    self.isDragSlider = YES;
}

// 点击调用  或者 拖拽完毕的时候调用
- (void)sliderTapValueChange:(UISlider *)slider
{
    self.isDragSlider = NO;
    // CMTimeMake(帧数（slider.value * timeScale）, 帧/sec)
    // 直接用秒来获取CMTime
    [self.player seekToTime:CMTimeMakeWithSeconds(slider.value, self.playerItem.currentTime.timescale)];
}

// 点击事件的Slider
- (void)touchSlider:(UITapGestureRecognizer *)tap
{
    // 根据点击的坐标计算对应的比例
    CGPoint touch = [tap locationInView:self.slider];
    CGFloat scale = touch.x / self.slider.bounds.size.width;
    self.slider.value = CMTimeGetSeconds(self.playerItem.duration) * scale;
    [self.player seekToTime:CMTimeMakeWithSeconds(self.slider.value, self.playerItem.currentTime.timescale)];
    /* indicates the current rate of playback; 0.0 means "stopped", 1.0 means "play at the natural rate of the current item" */
    if (self.player.rate != 1){
        [self.playButton setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
        [self.player play];
    }
}

// sec 转换成指定的格式<时：分：秒>
- (NSString *)convertToTime:(CGFloat)time
{
    NSDateFormatter *fotmmatter = [[NSDateFormatter alloc] init];
    if (time >= 3600){// 根据是否大于1H，进行格式赋值
        [fotmmatter setDateFormat:@"HH:mm:ss"];
    }else {
        [fotmmatter setDateFormat:@"mm:ss"];
    }
    // 秒数转换成NSDate类型
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    return [fotmmatter stringFromDate:date];// date转字符串
}

- (void)dealloc
{
    //移除观察者
    [self.playerItem removeObserver:self forKeyPath:@"status"];
    [self.playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
    
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];

}

//TODO: 第五部分： 更新相关设置
- (void)setTitleStr:(NSString *)titleStr
{
    _titleLabel.text = titleStr;
}

- (void)setInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    _interfaceOrientation = interfaceOrientation;
}
@end
