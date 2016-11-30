//
//  KACircleProgressView.m
//  BYMFinancing
//
//  Created by Administrator on 2016/11/8.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "KACircleProgressView.h"

@interface KACircleProgressView ()

@property (nonatomic, strong)CAShapeLayer *trackLayer;
@property (nonatomic, strong)UIBezierPath *trackPath;

@property (nonatomic, strong)CAShapeLayer *progressLayer;
@property (nonatomic, strong)UIBezierPath *progressPath;

@end
@implementation KACircleProgressView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _trackLayer = [CAShapeLayer layer];
        [self.layer addSublayer:_trackLayer];
        _trackLayer.fillColor = [UIColor clearColor].CGColor;
        _trackLayer.frame = CGRectMake(0, 0, self.width, self.height);
        
        _progressLayer = [CAShapeLayer layer];
        [self.layer addSublayer:_progressLayer];
        _progressLayer.fillColor = [UIColor clearColor].CGColor;
        _progressLayer.frame = CGRectMake(0, 0, self.width, self.height);
        
        //默认5
        self.progressWidth = 5.0f;
    }
    return self;
}

- (void)setTrack
{
    CGPoint centerPoint1 = CGPointMake(_trackLayer.frame.origin.x+self.width/2.0, _trackLayer.frame.origin.y+self.height/2.0);
    _trackPath = [UIBezierPath bezierPathWithArcCenter:centerPoint1 radius:(self.width - _progressWidth)/ 2 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    _trackLayer.path = _trackPath.CGPath;
}

- (void)setProgress
{
    CGPoint centerPoint2 = CGPointMake(_progressLayer.frame.origin.x+self.width/2.0, _progressLayer.frame.origin.y+self.height/2.0);
    _progressPath = [UIBezierPath bezierPathWithArcCenter:centerPoint2 radius:(self.width - _progressWidth)/ 2 startAngle:- M_PI_2 endAngle:(M_PI * 2) * _progress - M_PI_2 clockwise:YES];
    _progressLayer.path = _progressPath.CGPath;
    
    //给_progressLayer添加动画效果
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 1.0;
    pathAnimation.fromValue = @(0);
    pathAnimation.toValue = @(1);
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [_progressLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
}


- (void)setProgressWidth:(CGFloat)progressWidth
{
    _progressWidth = progressWidth;
    _trackLayer.lineWidth = _progressWidth;
    _progressLayer.lineWidth = _progressWidth;
    
    [self setTrack];
    [self setProgress];
}

- (void)setNextLevel:(CGFloat)nextLevel{
    
    _nextLevel = nextLevel;
    
    CGFloat width  = 109*KScreen_Width/320;
    UILabel *nextLevelLabel = [[UILabel alloc]initWithFrame:CGRectMake(8*KScreen_Width/320, (self.width-11)/2.0, width , 11)];
    nextLevelLabel.textAlignment = NSTextAlignmentCenter;
    nextLevelLabel.font = BYM_LabelFont(10);
    nextLevelLabel.textColor = HMColor(51, 51, 51);
    [self addSubview:nextLevelLabel];
    if (_nextLevel<7) {
        nextLevelLabel.text = [NSString stringWithFormat:@"距下一个等级：LV%.0f",_nextLevel+1];
    }else{
        nextLevelLabel.text =@"已达到最高等级";
        _progress = 1;
        [self setProgress];
    }
    
}

- (void)setTrackColor:(UIColor *)trackColor
{
    _trackLayer.strokeColor = trackColor.CGColor;
}

- (void)setProgressColor:(UIColor *)progressColor
{
    _progressLayer.strokeColor = progressColor.CGColor;
}

- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    //当_progress>＝0.97改变_progressLayer的lineCap
    if (_progress<0.97) {
        _progressLayer.lineCap = kCALineCapRound;
    }
    [self setProgress];
}

@end
