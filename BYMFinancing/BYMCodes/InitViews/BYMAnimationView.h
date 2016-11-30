//
//  LoadAnimationView.h
//  Demo
//
//  Created by mjq on 15/8/6.
//  Copyright (c) 2015年 baiyimao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BYMAnimationView : UIView

{
    UILabel *_waitLabel;
    UIImageView *_imageView;
}



- (void)showHudAnimation;

- (void)hiddenHudAnimation;

- (void)creactViewWithString:(NSString *)title;

@end
