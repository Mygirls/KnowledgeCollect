//
//  BYMBaseLabel.m
//  BYMFinancing
//
//  Created by Administrator on 2016/11/2.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "BYMBaseLabel.h"

@implementation BYMBaseLabel

/**
 *  自定义Lable：功能－ 富文本编辑，在一个label中，可以随意改变lable.text中某部分的字体的大小 颜色
 *
 */


// 设置字体的大小
- (void)settingLabelTextKitWithText:(NSString *)text withLabelFont:(UIFont *)font
{
    if (text == nil) {
        return;
    }
    NSMutableAttributedString *attrstring = [[NSMutableAttributedString alloc] initWithString:self.text];
    
    //1.设置字体
    NSRange rg = [self.text rangeOfString:text];
    [attrstring addAttribute:NSFontAttributeName
                       value:font
                       range:rg];
    
    self.attributedText = attrstring;
}

- (void)settingLabelTextColor:(UIColor *)textColor withStr:(NSString *)text
{
    if (text != nil) {
        NSMutableAttributedString *attrstring = [[NSMutableAttributedString alloc] initWithString:self.text];
        //2.设置字体颜色
        [attrstring addAttribute:NSForegroundColorAttributeName
                           value:textColor
                           range:[self.text rangeOfString:text]];
        
        self.attributedText = attrstring;
    }
}

- (void)settingLabelBackgroundColor:(UIColor *)backgroundColor withStr:(NSString *)text
{
    if (text == nil) {
        return;
    }
    NSMutableAttributedString *attrstring = [[NSMutableAttributedString alloc] initWithString:self.text];
    
    //3.设置字体的背景颜色
    [attrstring addAttribute:NSBackgroundColorAttributeName
                       value:backgroundColor
                       range:[self.text rangeOfString:text]];
    
    self.attributedText = attrstring;
}

- (void)settingMoreAttrsOfLabelTextKitWithText:(NSString *)text withLabelFont:(UIFont *)font textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor
{
    NSMutableAttributedString *attrstring = [[NSMutableAttributedString alloc] initWithString:self.text];
    NSRange range;
    if (text != nil && text.length > 0) {
        range = [self.text rangeOfString:text];
        [attrstring addAttribute:NSFontAttributeName
                           value:font
                           range:range];
        //2.设置字体颜色
        [attrstring addAttribute:NSForegroundColorAttributeName
                           value:textColor
                           range:range];
        
        //3.设置字体的背景颜色
        [attrstring addAttribute:NSBackgroundColorAttributeName
                           value:backgroundColor
                           range:range];
        
        self.attributedText = attrstring;
    }
}

- (void)settingMoreAttrsOfLabelTextKitWithText:(NSString *)text
                                 withLabelFont:(UIFont *)font
                                     textColor:(UIColor *)textColor
                               backgroundColor:(UIColor *)backgroundColor
                                    secondText:(NSString *)secondText
                                    secondFont:(UIFont *)secondFont
                               secondTextColor:(UIColor *)secondTextColor

{
    NSMutableAttributedString *attrstring = [[NSMutableAttributedString alloc] initWithString:self.text];
    NSRange range;
    NSRange range2;
    if (text != nil) {
        range = [self.text rangeOfString:text];
        [attrstring addAttribute:NSFontAttributeName
                           value:font
                           range:range];
        //2.设置字体颜色
        [attrstring addAttribute:NSForegroundColorAttributeName
                           value:textColor
                           range:range];
        //3.设置字体的背景颜色
        [attrstring addAttribute:NSBackgroundColorAttributeName
                           value:backgroundColor
                           range:range];
        
        range2 = [self.text rangeOfString:secondText];
        [attrstring addAttribute:NSFontAttributeName
                           value:secondFont
                           range:range2];
        [attrstring addAttribute:NSForegroundColorAttributeName
                           value:secondTextColor
                           range:range2];
        
        self.attributedText = attrstring;
    }
}

- (void)settingMoreAttrsOfLabelTextKitWithText:(NSString *)text
                                 withLabelFont:(UIFont *)font
                                     textColor:(UIColor *)textColor
                               backgroundColor:(UIColor *)backgroundColor
                                    secondText:(NSString *)secondText
                                    secondFont:(UIFont *)secondFont
                               secondTextColor:(UIColor *)secondTextColor
                         secondBackgroundColor:(UIColor *)secondBackgroundColor
{
    NSMutableAttributedString *attrstring = [[NSMutableAttributedString alloc] initWithString:self.text];
    NSRange range;
    NSRange range2;
    if (text != nil && secondText != nil) {
        range = [self.text rangeOfString:text];
        [attrstring addAttribute:NSFontAttributeName
                           value:font
                           range:range];
        //2.设置字体颜色
        [attrstring addAttribute:NSForegroundColorAttributeName
                           value:textColor
                           range:range];
        //3.设置字体的背景颜色
        [attrstring addAttribute:NSBackgroundColorAttributeName
                           value:backgroundColor
                           range:range];
        
        range2 = [self.text rangeOfString:secondText];
        [attrstring addAttribute:NSFontAttributeName
                           value:secondFont
                           range:range2];
        [attrstring addAttribute:NSForegroundColorAttributeName
                           value:secondTextColor
                           range:range2];
        [attrstring addAttribute:NSBackgroundColorAttributeName
                           value:secondBackgroundColor
                           range:range2];
        
        self.attributedText = attrstring;
    }
}

- (void)mySettingMoreAttrsOfLabelOfMoreSameTextKitWithText:(NSString *)text
                                             withLabelFont:(UIFont *)font
                                                 textColor:(UIColor *)textColor
                                           backgroundColor:(UIColor *)backgroundColor
{
    NSMutableAttributedString *attrstring = [[NSMutableAttributedString alloc] initWithString:self.text];
    if (text != nil && text.length > 0) {
        NSString *copyStr = self.text;
        while ([copyStr rangeOfString:text].location != NSNotFound){
            
            NSRange  range  = [copyStr rangeOfString:text];
            copyStr = [copyStr stringByReplacingCharactersInRange:NSMakeRange(range.location, range.length) withString:@" "];
            [attrstring addAttribute:NSFontAttributeName
                               value:font
                               range:range];
            
            //2.设置字体颜色
            [attrstring addAttribute:NSForegroundColorAttributeName
                               value:textColor
                               range:range];
            
            //3.设置字体的背景颜色
            [attrstring addAttribute:NSBackgroundColorAttributeName
                               value:backgroundColor
                               range:range];
        }
        NSRange range2;
        range2 = [self.text rangeOfString:@"+"];
        [attrstring addAttribute:NSFontAttributeName
                           value:[UIFont systemFontOfSize:13]
                           range:range2];
        
        //2.设置字体颜色
        [attrstring addAttribute:NSForegroundColorAttributeName
                           value:textColor
                           range:range2];
        
        //3.设置字体的背景颜色
        [attrstring addAttribute:NSBackgroundColorAttributeName
                           value:backgroundColor
                           range:range2];
        
        NSRange range3;
        NSInteger count = self.text.length - range2.location - 1 - 1 - 1 ;
        range3 =  NSMakeRange (range2.location + 2, count);
        [attrstring addAttribute:NSFontAttributeName
                           value:[UIFont systemFontOfSize:18]
                           range:range3];
        
        //2.设置字体颜色
        [attrstring addAttribute:NSForegroundColorAttributeName
                           value:HMColor(252,112,50)
                           range:range3];
        
        //3.设置字体的背景颜色
        [attrstring addAttribute:NSBackgroundColorAttributeName
                           value:backgroundColor
                           range:range3];
        
        self.attributedText = attrstring;
    }
}




@end
