//
//  JQKLineVolumePositionModel.m
//  BYMFinancing
//
//  Created by administrator on 2016/12/3.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JQKLineVolumePositionModel.h"

@implementation JQKLineVolumePositionModel
+ (instancetype) modelWithStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint dayDesc:(NSString *)dayDesc;
{
    JQKLineVolumePositionModel *volumePositionModel = [JQKLineVolumePositionModel new];
    volumePositionModel.StartPoint = startPoint;
    volumePositionModel.EndPoint = endPoint;
    volumePositionModel.DayDesc = dayDesc;
    return volumePositionModel;
}
@end
