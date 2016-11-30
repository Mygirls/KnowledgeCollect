//
//  SystemNoticeModel.m
//  BYMFinancing
//
//  Created by Administrator on 2016/11/2.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "SystemNoticeModel.h"

@implementation SystemNoticeModel


@end




@implementation ListModel
//重写以下方法,以对应服务器的key值
+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc]initWithModelToJSONDictionary:
            @{
              @"ID":@"id",
              @"titleDescription":@"description"
              }];
    
}


@end
