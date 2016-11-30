//
//  UtilityClass.h
//  custormProject
//
//  Created by ShenChunXing on 16/8/17.
//  Copyright © 2016年 NB_killer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UtilityClass : NSObject

+ (NSDateFormatter *)dateFormatter;

/**
 *  时间戳转日期
 *
 *  @param timestamp 时间戳
 *
 *  @return 日期
 */
+ (NSString *)stringWithTimestamp:(double)timestamp;

/**
 *  详细的年月日 星期
 */
+ (NSString *)dateStringWithstring:(NSString *)dateString;

/**
 *  详细的年月日 时分秒格式
 */
+ (NSString *)detailDateStringWithTimestamp:(double)timestamp;

/**
 *  自定义输出格式
 *
 *  @param timestamp  时间戳
 *  @param dateFormat 输出形式
 *
 *  @return 日期字符串
 */
+ (NSString *)stringWithTimestamp:(double)timestamp dateFormat:(NSString *)dateFormat;

/**
 *  日期转字符串
 */
+ (NSString *)stringWithDate:(NSDate *)date;

/**
 *  字符串形式的日期转换成日期格式
 */
+ (NSDate *)dateFromString:(NSString *)dateString;

+ (NSString *)stringFromHexString:(NSString *)hexString;
+ (NSString *)convertHexStrToString:(NSString *)str;

+ (BOOL)isPureInt:(NSString *)string;




@end
