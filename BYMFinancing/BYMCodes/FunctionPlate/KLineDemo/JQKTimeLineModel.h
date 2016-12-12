//
//  JQKTimeLineModel.h
//  BYMFinancing
//
//  Created by administrator on 2016/12/2.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JQKTimeLineModel : NSObject
{
    NSDictionary * _dict;
    NSString *Price;
    NSString *Volume;
}

//@property(nonatomic,assign)CGFloat AvgPrice;
//@property(nonatomic,strong)NSNumber *Price ;

- (CGFloat )AvgPrice;
- (NSNumber *)Price;
- (CGFloat)Volume;
- (BOOL)isShowTimeDesc;
- (NSString *)TimeDesc;
- (NSString *)DayDatail;

- (instancetype)initWithDict:(NSDictionary *)dict;
@end
