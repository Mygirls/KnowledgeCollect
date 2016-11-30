//
//  NSString+BYM.h
//  BYMFinancing
//
//  Created by administrator on 2016/11/3.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import<CommonCrypto/CommonDigest.h>    //md5

@interface NSString (BYM)


/**
 *  给数字加上,分隔符
 */
+(NSString *)countNumAndChangeformat:(NSString *)num;


+(NSString *)substringWithTwoPoint:(NSString *)OriginalString;

// 判断手机号码
-(BOOL) isValidateMobile:(NSString *)mobile;

// 判断是否为整数 并且 >= 1
- (BOOL)judegementVidateFigures:(NSString *)figures;

// 密码设置不能有特殊字符
- (BOOL)passwordCheck:(NSString *)checkPassword;

//验证银行卡
- (BOOL)isRightBank:(NSString *)isRightBank;

//验证身份证
- (BOOL)isCurrentID:(NSString *)isCurrentID;

// 判断是否为50的整数倍
- (BOOL)moneyIsHundredMultiple:(NSString *)str;

// 判断是否为100的整数倍
- (BOOL)moneyIsHundredMultipleFund:(NSString *)str;

//首字母大写判断
- (BOOL)judegeFirstLetterCapital:(NSString *)str;

/*
 *字符串转化成double类型
 */
+ (double)StringChangeToDoubleForJingdu:(NSString *)textString;

/**
 *  md5加密
 */
+ (NSString *)md5:(NSString*)origString;

@end
