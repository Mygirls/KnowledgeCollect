//
//  JQKLineVolumePositionModel.h
//  BYMFinancing
//
//  Created by administrator on 2016/12/3.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JQKLineVolumePositionModel : NSObject
/**
 *  开始点
 */
@property (nonatomic, assign) CGPoint StartPoint;

/**
 *  结束点
 */
@property (nonatomic, assign) CGPoint EndPoint;

/**
 *  日期
 */
@property (nonatomic, copy) NSString *DayDesc;

/**
 *  工厂方法
 */
+ (instancetype) modelWithStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint dayDesc:(NSString *)dayDesc;
@end
