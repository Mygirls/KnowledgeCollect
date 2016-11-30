//
//  LoadAnimationView.m
//  Demo
//
//  Created by mjq on 15/8/6.
//  Copyright (c) 2015年 baiyimao. All rights reserved.
//

#import "BYMAnimationView.h"

/**
 *  黑色的弹框
 */

@implementation BYMAnimationView

- (instancetype)initWithFrame:(CGRect)frame

{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)hiddenHudAnimation
{
    UIImageView *imageView = (UIImageView *)[self viewWithTag:100];
    [imageView performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:1];
}

- (void)showHudAnimation
{
    UIImageView *fishAni=[[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - 53)/2.0, ([UIScreen mainScreen].bounds.size.height - 53)/2.0, 50, 50)];
    fishAni.tag = 100;
    [self addSubview:fishAni];
    fishAni.animationImages=[NSArray arrayWithObjects:
                             [UIImage imageNamed:@"progress_1"],
                             [UIImage imageNamed:@"progress_2"],
                             [UIImage imageNamed:@"progress_3"],
                             [UIImage imageNamed:@"progress_4"],
                             [UIImage imageNamed:@"progress_5"],
                             [UIImage imageNamed:@"progress_6"],
                             [UIImage imageNamed:@"progress_7"],
                             [UIImage imageNamed:@"progress_8"],nil ];
    
    
    fishAni.animationDuration=1.0;
    fishAni.animationRepeatCount=100;
    [fishAni startAnimating];

}

- (void)creactViewWithString:(NSString *)title
{
    
    if ( _imageView == nil) {
        _imageView = [[UIImageView alloc]init];
    }
    _imageView.tag = 98;
    [self addSubview:_imageView];
    
    
    if (_waitLabel == nil) {
        _waitLabel = [[UILabel alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - 200)/2.0, ([UIScreen mainScreen].bounds.size.height - 60)/2.0 - 30, 200, 60)];
    }
    [_waitLabel setText:title];
    _waitLabel.backgroundColor = [UIColor clearColor];
    _waitLabel.tag = 99;
    _waitLabel.textAlignment = NSTextAlignmentCenter;
    _waitLabel.font = [UIFont systemFontOfSize:16];
    _waitLabel.textColor = [UIColor whiteColor];
    
    _waitLabel.numberOfLines = 1;
    if (_waitLabel.width > 200) {
        
        _waitLabel.numberOfLines = 0;

    }
    
    [_waitLabel sizeToFit];
    _waitLabel.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - _waitLabel.bounds.size.width)/2.0, _waitLabel.top, _waitLabel.width, _waitLabel.height);
    [self addSubview:_waitLabel];
    if (_waitLabel.width < 80) {
        
        _imageView.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - 100)/2.0 ,_waitLabel.top - (30 - _waitLabel.height/2.0) , 100, 60);
        UIImage *image = [UIImage imageNamed:@"WaitBGGray@2x.png"];
        image =  [image stretchableImageWithLeftCapWidth:50 topCapHeight:40];
        _imageView.image = image;
        
    }else {
        
        if (_waitLabel.width > 300) {
            _waitLabel.frame = CGRectMake(20, _waitLabel.top, self.width - 40, _waitLabel.height);
            _waitLabel.text = title;
            _waitLabel.font = [UIFont systemFontOfSize:12];
            
        }
        
        _imageView.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - _waitLabel.bounds.size.width)/2.0 - 10, _waitLabel.top - 20, _waitLabel.width + 20, _waitLabel.height + 40);
        UIImage *image = [UIImage imageNamed:@"WaitBGGray@2x.png"];
        image =  [image stretchableImageWithLeftCapWidth:50 topCapHeight:40];
        _imageView.image = image;
    }
}

@end
