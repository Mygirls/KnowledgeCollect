//
//  UtilityClass.m
//  custormProject
//
//  Created by ShenChunXing on 16/8/17.
//  Copyright © 2016年 NB_killer. All rights reserved.
//

#import "UtilityClass.h"

@implementation UtilityClass

+ (NSDateFormatter *)dateFormatter
{
    static NSDateFormatter *dateFormatter= nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
    });
    return dateFormatter;
}

/**
 *  时间戳转日期
 *
 *  @param timestamp 时间戳
 *
 *  @return 日期
 */
+ (NSString *)stringWithTimestamp:(double)timestamp
{
    NSString *str=[NSString stringWithFormat:@"%f",(double)timestamp];
    NSTimeInterval time=[str  doubleValue]/1000;
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [UtilityClass dateFormatter];
    [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
    return  [dateFormatter stringFromDate: detaildate];
}

+ (NSString *)stringWithTimestamp:(double)timestamp dateFormat:(NSString *)dateFormat
{
    NSString *str=[NSString stringWithFormat:@"%f",(double)timestamp];
    NSTimeInterval time= [str  doubleValue]/1000;
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [UtilityClass dateFormatter];
    [dateFormatter setDateFormat:dateFormat];
    return  [dateFormatter stringFromDate: detaildate];
}

+ (NSString *)stringWithDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [UtilityClass dateFormatter];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
   return [dateFormatter stringFromDate:date];
}

+ (NSString *)dateStringWithstring:(NSString *)dateString
{
    NSDateFormatter *formatter = [UtilityClass dateFormatter];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"beijing"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd EEE HH:mm"];
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[dateString doubleValue]/1000];
    return [formatter stringFromDate:date];
}

+ (NSString *)detailDateStringWithTimestamp:(double)timestamp
{
    NSString *str=[NSString stringWithFormat:@"%f",timestamp];
    NSTimeInterval time=[str  doubleValue]/1000;
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [UtilityClass dateFormatter];
    [dateFormatter setDateFormat:@"YYYY.MM.dd hh:mm:ss"];
    return  [dateFormatter stringFromDate: detaildate];
}

+ (NSDate *)dateFromString:(NSString *)dateString{
    NSDateFormatter *dateFormatter = [UtilityClass dateFormatter];
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    return destDate;
}

+ (NSString *)stringFromHexString:(NSString *)hexString {
    
    char *myBuffer = (char *)malloc((int)[hexString length] / 2 + 1);
    bzero(myBuffer, [hexString length] / 2 + 1);
    for (int i = 0; i < [hexString length] - 1; i += 2) {
        unsigned int anInt;
        NSString * hexCharStr = [hexString substringWithRange:NSMakeRange(i, 2)];
        NSScanner * scanner = [[NSScanner alloc] initWithString:hexCharStr];
        [scanner scanHexInt:&anInt];
        myBuffer[i / 2] = (char)anInt;
    }
    NSString *unicodeString = [NSString stringWithCString:myBuffer encoding:4];
    return unicodeString;
}

+ (NSString *)convertHexStrToString:(NSString *)str {
    if (!str || [str length] == 0) {
        return nil;
    }
    
    NSMutableData *hexData = [[NSMutableData alloc] initWithCapacity:8];
    NSRange range;
    if ([str length] % 2 == 0) {
        range = NSMakeRange(0, 2);
    } else {
        range = NSMakeRange(0, 1);
    }
    for (NSInteger i = range.location; i < [str length]; i += 2) {
        unsigned int anInt;
        NSString *hexCharStr = [str substringWithRange:range];
        NSScanner *scanner = [[NSScanner alloc] initWithString:hexCharStr];
        
        [scanner scanHexInt:&anInt];
        NSData *entity = [[NSData alloc] initWithBytes:&anInt length:1];
        [hexData appendData:entity];
        
        range.location += range.length;
        range.length = 2;
    }
    NSString *string = [[NSString alloc]initWithData:hexData encoding:NSUTF8StringEncoding];
    return string;
}

+ (BOOL)isPureInt:(NSString *)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}


@end
