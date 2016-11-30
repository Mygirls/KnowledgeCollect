//
//  UILabel+BYM.m
//  BYMFinancing
//
//  Created by administrator on 2016/11/3.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "UILabel+BYM.h"

@implementation UILabel (BYM)


/**
 *  全能初始化
 */
+ (UILabel *)labelWithText:(NSString *)text color:(UIColor *)color align:(NSTextAlignment)align font:(UIFont *)font background:(UIColor *)backgroundColor frame:(CGRect)frame{
    
    UILabel *label = [[UILabel alloc] init];
    if (!backgroundColor) {
        label.backgroundColor = [UIColor clearColor];
    } else {
        label.backgroundColor = backgroundColor;
    }
    label.text = text;
    label.textColor = color;
    label.font = font;
    label.frame = frame;
    label.textAlignment = align;
    return label;
}


+ (UILabel *)cornerlabelWithText:(NSString *)text color:(UIColor *)color align:(NSTextAlignment )align font:(UIFont *)font backgroundColor:(UIColor *)backgroundColor frame:(CGRect )frame
{
    UILabel *label = [[UILabel alloc] init];
    if (!backgroundColor) {
        label.backgroundColor = [UIColor clearColor];
    } else {
        label.backgroundColor = backgroundColor;
    }
    label.text = text;
    label.textColor = color;
    label.font = font;
    label.frame = frame;
    label.textAlignment = align;
    label.layer.cornerRadius = frame.size.height/2;
    label.layer.masksToBounds = YES;
    return label;
    
}



+ (UILabel *)sectionlabelWithText:(NSString *)text color:(UIColor *)color align:(NSTextAlignment )align font:(UIFont *)font backgroundColor:(UIColor *)backgroundColor frame:(CGRect )frame beginlocation:(CGFloat)beginlocation  endlocation:(CGFloat)endlocation rangFont:(UIFont *)rangFont rangColor:(UIColor *)rangColor
{
    UILabel *label = [[UILabel alloc] init];
    if (!backgroundColor) {
        label.backgroundColor = [UIColor clearColor];
    } else {
        label.backgroundColor = backgroundColor;
    }
    label.text = text;
    label.textColor = color;
    label.font = font;
    label.frame = frame;
    label.textAlignment = align;
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:label.text];
    [str addAttribute:NSFontAttributeName value:rangFont range:NSMakeRange(beginlocation,endlocation-beginlocation)];
    [str addAttribute:NSForegroundColorAttributeName value:rangColor range:NSMakeRange(beginlocation,endlocation-beginlocation)];
    label.attributedText = str;
    
    return label;
}



+ (UILabel *)sectionlabelWithText:(NSString *)text color:(UIColor *)color align:(NSTextAlignment )align font:(UIFont *)font backgroundColor:(UIColor *)backgroundColor frame:(CGRect )frame beginlocation:(CGFloat)beginlocation  rangFont:(UIFont *)rangFont rangColor:(UIColor *)rangColor
{
    UILabel *label = [[UILabel alloc] init];
    if (!backgroundColor) {
        label.backgroundColor = [UIColor clearColor];
    } else {
        label.backgroundColor = backgroundColor;
    }
    label.text = text;
    label.textColor = color;
    label.font = font;
    label.frame = frame;
    label.textAlignment = align;
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:label.text];
    [str addAttribute:NSFontAttributeName value:rangFont range:NSMakeRange(beginlocation,label.text.length-beginlocation)];
    [str addAttribute:NSForegroundColorAttributeName value:rangColor range:NSMakeRange(beginlocation,label.text.length-beginlocation)];
    label.attributedText = str;
    
    return label;
}


+ (UILabel *)sectionlabelWithText:(NSString *)text color:(UIColor *)color align:(NSTextAlignment )align font:(UIFont *)font backgroundColor:(UIColor *)backgroundColor frame:(CGRect )frame beginlocation:(CGFloat)beginlocation  endlocation:(CGFloat)endlocation rangFont:(UIFont *)rangFont rangColor:(UIColor *)rangColor beginlocation2:(CGFloat)beginlocation2 endlocation2:(CGFloat)endlocation2 rangFont2:(UIFont *)rangFont2 rangColor:(UIColor *)rangColor2
{
    UILabel *label = [[UILabel alloc] init];
    if (!backgroundColor) {
        label.backgroundColor = [UIColor clearColor];
    } else {
        label.backgroundColor = backgroundColor;
    }
    label.text = text;
    label.textColor = color;
    label.font = font;
    label.frame = frame;
    label.textAlignment = align;
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:label.text];
    [str addAttribute:NSFontAttributeName value:rangFont range:NSMakeRange(beginlocation,endlocation-beginlocation)];
    [str addAttribute:NSForegroundColorAttributeName value:rangColor range:NSMakeRange(beginlocation,endlocation-beginlocation)];
    [str addAttribute:NSFontAttributeName value:rangFont2 range:NSMakeRange(beginlocation2,endlocation2-beginlocation2)];
    [str addAttribute:NSForegroundColorAttributeName value:rangColor2 range:NSMakeRange(beginlocation2,endlocation2-beginlocation2)];
    label.attributedText = str;
    
    return label;
}



+ (UILabel *)labelWithText:(NSString *)text color:(UIColor *)color font:(UIFont *)font frame:(CGRect)frame
{
    return [self labelWithText:text color:color align:NSTextAlignmentLeft font:font background:nil frame:frame];
}

+ (CGFloat)widthWithTitle:(NSString *)title Font:(UIFont *)font Size:(CGSize)size{
    NSDictionary *dc=@{NSFontAttributeName:font};
    CGFloat W=[title boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dc context:nil].size.width;
    return W;
}

+ (CGFloat)heightWithTitle:(NSString *)title Font:(UIFont *)font Size:(CGSize)size{
    NSDictionary *dc=@{NSFontAttributeName:font};
    CGFloat H=[title boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dc context:nil].size.height;
    return H;
}


//富文本编辑

// 设置字体的大小
- (void)settingLabelTextKitWithText:(NSString *)text withLabelFont:(UIFont *)font
{
    
    if (text != nil) {
        NSMutableAttributedString *attrstring = [[NSMutableAttributedString alloc] initWithString:self.text];
        NSRange rg = [self.text rangeOfString:text];
        [attrstring addAttribute:NSFontAttributeName
                           value:font
                           range:rg];
        self.attributedText = attrstring;
    }
}

- (void)settingLabelTextColor:(UIColor *)textColor withStr:(NSString *)text
{
    if (text != nil) {
        NSMutableAttributedString *attrstring = [[NSMutableAttributedString alloc] initWithString:self.text];
        [attrstring addAttribute:NSForegroundColorAttributeName
                           value:textColor
                           range:[self.text rangeOfString:text]];
        self.attributedText = attrstring;
    }
}

- (void)settingLabelBackgroundColor:(UIColor *)backgroundColor withStr:(NSString *)text
{
    if (text != nil) {
        NSMutableAttributedString *attrstring = [[NSMutableAttributedString alloc] initWithString:self.text];
        [attrstring addAttribute:NSBackgroundColorAttributeName
                           value:backgroundColor
                           range:[self.text rangeOfString:text]];
        self.attributedText = attrstring;
    }
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

@end
