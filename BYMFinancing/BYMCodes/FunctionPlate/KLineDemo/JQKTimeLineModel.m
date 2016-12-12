//
//  JQKTimeLineModel.m
//  BYMFinancing
//
//  Created by administrator on 2016/12/2.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JQKTimeLineModel.h"

@implementation JQKTimeLineModel


- (NSString *)TimeDesc {
    if ( [_dict[@"minute"] integerValue] == 780) {
        return @"11:30/13:00";//这期间停盘
    } else {
        return [NSString stringWithFormat:@"%02ld:%02ld",[_dict[@"minute"] integerValue]/60,[_dict[@"minute"] integerValue]%60];
    }
}

- (NSString *)DayDatail {
    return [NSString stringWithFormat:@"%02ld:%02ld",[_dict[@"minute"] integerValue]/60,[_dict[@"minute"] integerValue]%60];
}



//前一天的收盘价
- (CGFloat )AvgPrice {
    return [_dict[@"avgPrice"] floatValue];
}

- (NSNumber *)Price {
    return _dict[@"price"];
}

- (CGFloat)Volume {
    return [_dict[@"volume"] floatValue];
}

- (BOOL)isShowTimeDesc {
    //9:30-11:30,13:00-15:00
    //11:30和13:00挨在一起，显示一个就够了
    //最后一个服务器返回的minute不是960,故只能特殊处理
    return [_dict[@"minute"] integerValue] == 570 ||  [_dict[@"minute"] integerValue] == 780 ||  [_dict[@"index"] integerValue] == 240;
}

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        _dict = dict;
        Price = _dict[@"price"];
        Volume = _dict[@"volume"];
    }
    return self;
}

@end
