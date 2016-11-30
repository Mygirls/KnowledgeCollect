//
//  GradeProgressBar.h
//  BYMFinancing
//
//  Created by Administrator on 2016/11/8.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GradeProgressBar : UIView

@property (nonatomic, assign)CGFloat widthLine;//lineView的宽度

/**
 *  等级进度条
 *  @param aFrame      frame
 *  @param upColor  上半部分的color
 *  @param lowerColor   下半部分的color
 */
-(id)initWithFrame:(CGRect)aFrame upperPartColor:(UIColor*)upColor lowerPartColor:(UIColor*)lowerColor;

@end
