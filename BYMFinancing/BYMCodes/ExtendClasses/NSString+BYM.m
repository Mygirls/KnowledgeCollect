//
//  NSString+BYM.m
//  BYMFinancing
//
//  Created by administrator on 2016/11/3.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "NSString+BYM.h"

@implementation NSString (BYM)

+(NSString *)countNumAndChangeformat:(NSString *)num
{
    int count = 0;
    long long int a = num.longLongValue;
    while (a != 0)
    {
        count++;
        a /= 10;
    }
    NSMutableString *string = [NSMutableString stringWithString:num];
    NSMutableString *newstring = [NSMutableString string];
    while (count > 3) {
        count -= 3;
        NSRange rang = NSMakeRange(string.length - 3, 3);
        NSString *str = [string substringWithRange:rang];
        [newstring insertString:str atIndex:0];
        [newstring insertString:@"," atIndex:0];
        [string deleteCharactersInRange:rang];
    }
    [newstring insertString:string atIndex:0];
    
    return newstring;
}

+(NSString *)substringWithTwoPoint:(NSString *)OriginalString
{
    NSString *dealString;
    NSRange range = [OriginalString rangeOfString:@"."];
    if (range.length != 0 &&(OriginalString.length - range.location > 3)) {
        dealString = [OriginalString substringToIndex:range.location + 3];
    }
    return dealString;
}


// 判断手机号码
-(BOOL) isValidateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符  ^[1][35789][0-9]{9}$
    //    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSString *phoneRegex = @"^[1][345789][0-9]{9}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

// 判断是否为100的整数倍
- (BOOL)moneyIsHundredMultipleFund:(NSString *)str
{
    if ([str judegementVidateFigures:str]) {
        int i = [str intValue] % 100;
        if (i == 0) {
            return YES;
        }
    }
    return NO;
}

// 判断是否为50的整数倍
- (BOOL)moneyIsHundredMultiple:(NSString *)str
{
    if ([str judegementVidateFigures:str]) {
        int i = [str intValue] % 50;
        if (i == 0) {
            return YES;
        }
    }
    return NO;
}

// 判断是否为整数 并且 >= 1
- (BOOL)judegementVidateFigures:(NSString *)figures
{
    NSString *phoneRegex = @"^[0-9]+(\\.[0-9]+)?$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:figures];
}

// 密码设置不能有特殊字符
- (BOOL)passwordCheck:(NSString *)checkPassword
{
    NSString *check = @"^\\w{6,16}$";
    NSPredicate *password = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",check];
    return [password evaluateWithObject:checkPassword];
}

//验证银行卡
- (BOOL)isRightBank:(NSString *)isRightBank
{
    NSString *phoneRegex = @"/^[0-9]{16,20}$/";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:isRightBank];
}

//验证身份证
- (BOOL)isCurrentID:(NSString *)isCurrentID
{
    BOOL flag;
    if (isCurrentID.length <= 0) {
        return flag;        flag = NO;
        
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:isCurrentID];
}

- (BOOL)judegeFirstLetterCapital:(NSString *)str
{
    // 判断字符串首字符是否为字母
    NSString *string = str;
    // 1、准备正则式
    NSString *regex = @"\\d{14}[[0-9],0-9xX]"; // 只能是字母，不区分大小写
    // 2、拼接谓词
    NSPredicate *predicateRe1 = [NSPredicate predicateWithFormat:@"self matches %@", regex];
    // 3、匹配字符串
    BOOL resualt = [predicateRe1 evaluateWithObject:string];
    
    return resualt;
    
}

/*
 *字符串转化成double类型
 */
+ (double)StringChangeToDoubleForJingdu:(NSString *)textString
{
    if (textString == nil || [textString isEqualToString:@""]) {
        return 0.0;
    }
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    
    return  [[formatter numberFromString:textString]doubleValue];
}

/**
 *  md5加密
 *
 */
+ (NSString *)md5:(NSString*)origString
{
    const char *original_str = [origString UTF8String];
    unsigned char result[32];
    CC_MD5(original_str, strlen(original_str), result);//调用md5
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++){
        [hash appendFormat:@"%02x", result[i]];
    }
    
    return hash;
}

@end
