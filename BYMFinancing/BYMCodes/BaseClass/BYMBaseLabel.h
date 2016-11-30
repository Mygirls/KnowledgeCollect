//
//  BYMBaseLabel.h
//  BYMFinancing
//
//  Created by Administrator on 2016/11/2.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BYMBaseLabel : UILabel

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


- (void)mySettingMoreAttrsOfLabelOfMoreSameTextKitWithText:(NSString *)text
                                             withLabelFont:(UIFont *)font textColor:(UIColor *)textColor
                                           backgroundColor:(UIColor *)backgroundColor;


@end
