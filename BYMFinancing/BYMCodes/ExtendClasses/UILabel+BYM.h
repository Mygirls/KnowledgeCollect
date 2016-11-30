//
//  UILabel+BYM.h
//  BYMFinancing
//
//  Created by administrator on 2016/11/3.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (BYM)


/**
 *  全能初始化
 */
+ (UILabel *)labelWithText:(NSString *)text
                     color:(UIColor *)color
                     align:(NSTextAlignment)align
                      font:(UIFont *)font
                background:(UIColor *)backgroundColor
                     frame:(CGRect)frame;

/**
 *  左边距对齐，背景为clearcolor
 */
+ (UILabel *)labelWithText:(NSString *)text
                     color:(UIColor *)color
                      font:(UIFont *)font
                     frame:(CGRect)frame;

/**
 *  计算label宽度
 *
 *  @param title 文字
 *  @param font  字体大小
 *  @param size  尺寸大小设置
 *
 *  @return label
 */

+ (CGFloat)widthWithTitle:(NSString *)title
                     Font:(UIFont *)font
                     Size:(CGSize)size;
/**
 *  计算label高度
 *
 *  @param title 文字
 *  @param font  字体大小
 *  @param size  尺寸大小设置
 *
 *  @return label
 */

+ (CGFloat)heightWithTitle:(NSString *)title
                      Font:(UIFont *)font
                      Size:(CGSize)size;


//带圆角的label，圆角半径为高度一半
+ (UILabel *)cornerlabelWithText:(NSString *)text
                           color:(UIColor *)color
                           align:(NSTextAlignment )align
                            font:(UIFont *)font
                 backgroundColor:(UIColor *)backgroundColor
                           frame:(CGRect )frame;

/**
 *  知道特殊位置坐标的label分段显示
 *  @param beginlocation   特殊位置开始坐标
 *  @param endlocation     特殊位置结束坐标
 *  @param rangFont        特殊位置字体大小
 *  @param rangColor       特殊位置字体颜色
 */
+ (UILabel *)sectionlabelWithText:(NSString *)text
                            color:(UIColor *)color
                            align:(NSTextAlignment )align
                             font:(UIFont *)font
                  backgroundColor:(UIColor *)backgroundColor
                            frame:(CGRect )frame
                    beginlocation:(CGFloat)beginlocation
                      endlocation:(CGFloat)endlocation
                         rangFont:(UIFont *)rangFont
                        rangColor:(UIColor *)rangColor;

/**
 *  特殊位置到label结束
 */
+ (UILabel *)sectionlabelWithText:(NSString *)text
                            color:(UIColor *)color
                            align:(NSTextAlignment )align
                             font:(UIFont *)font
                  backgroundColor:(UIColor *)backgroundColor
                            frame:(CGRect )frame
                    beginlocation:(CGFloat)beginlocation
                         rangFont:(UIFont *)rangFont
                        rangColor:(UIColor *)rangColor;

/**
 *  两种特殊位置的label
 *  @param beginlocation   开始位置1
 *  @param endlocation     结束位置1
 *  @param rangFont        字体1
 *  @param rangColor       字体颜色1
 *  @param beginlocation2  开始位置2
 *  @param endlocation2    结束位置2
 *  @param rangFont2       字体2
 *  @param rangColor2      字体颜色2
 */
+ (UILabel *)sectionlabelWithText:(NSString *)text
                            color:(UIColor *)color
                            align:(NSTextAlignment )align
                             font:(UIFont *)font
                  backgroundColor:(UIColor *)backgroundColor
                            frame:(CGRect )frame
                    beginlocation:(CGFloat)beginlocation
                      endlocation:(CGFloat)endlocation
                         rangFont:(UIFont *)rangFont
                        rangColor:(UIColor *)rangColor
                   beginlocation2:(CGFloat)beginlocation2
                     endlocation2:(CGFloat)endlocation2
                        rangFont2:(UIFont *)rangFont2
                        rangColor:(UIColor *)rangColor2;


//——————————————————————富文本编辑——————————————————————————

/*
 *设置字体大小
 */
- (void)settingLabelTextKitWithText:(NSString *)text withLabelFont:(UIFont *)font;

/*
 *设置字体颜色
 */
- (void)settingLabelTextColor:(UIColor *)textColor withStr:(NSString *)text;
/*
 *设置字体的背景颜色
 */
- (void)settingLabelBackgroundColor:(UIColor *)backgroundColor withStr:(NSString *)text;


/*
 *设置字体的背景颜色、字体大小、选中颜色
 */
- (void)settingMoreAttrsOfLabelTextKitWithText:(NSString *)text
                                 withLabelFont:(UIFont *)font
                                     textColor:(UIColor *)textColor
                               backgroundColor:(UIColor *)backgroundColor;


- (void)settingMoreAttrsOfLabelTextKitWithText:(NSString *)text
                                 withLabelFont:(UIFont *)font
                                     textColor:(UIColor *)textColor
                               backgroundColor:(UIColor *)backgroundColor
                                    secondText:(NSString *)secondText
                                    secondFont:(UIFont *)secondFont
                               secondTextColor:(UIColor *)secondTextColor;


- (void)settingMoreAttrsOfLabelTextKitWithText:(NSString *)text
                                 withLabelFont:(UIFont *)font
                                     textColor:(UIColor *)textColor
                               backgroundColor:(UIColor *)backgroundColor
                                    secondText:(NSString *)secondText
                                    secondFont:(UIFont *)secondFont
                               secondTextColor:(UIColor *)secondTextColor
                         secondBackgroundColor:(UIColor *)secondBackgroundColor;




@end
