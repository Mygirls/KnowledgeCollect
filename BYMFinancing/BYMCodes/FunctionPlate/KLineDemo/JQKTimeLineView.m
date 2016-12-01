//
//  JQKTimeLineView.m
//  BYMFinancing
//
//  Created by administrator on 2016/12/1.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JQKTimeLineView.h"

@implementation JQKTimeLineView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //self.backgroundColor = [UIColor grayColor];

    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self aa ];
}

- (void)bb {
    CGContextRef ctx = UIGraphicsGetCurrentContext();

    UIColor *strokeColor =  [UIColor orangeColor];
    CGContextSetStrokeColorWithColor(ctx, strokeColor.CGColor);

    CGContextSetLineWidth(ctx, 12);
    const CGPoint solidPoints[] = {CGPointMake(64 + 10, 64 + 64),CGPointMake(64 + 10, 84 + 64)};
    //一些直线
    CGContextStrokeLineSegments(ctx, solidPoints, 12);

    CGContextSetLineWidth(ctx, 1.2);
    const CGPoint shadowPoints[] = {CGPointMake(64 + 10, 64 + 63), CGPointMake(74, 84 + 90)};
    CGContextStrokeLineSegments(ctx, shadowPoints, 12);


}

- (void)aa {
    //获得处理的上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //设置线的颜色
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    //起始点设置为(0,0):注意这是上下文对应区域中的相对坐标，
    CGContextMoveToPoint(context, 64 + 10, 64 + 64);
    //设置下一个坐标点
    CGContextAddLineToPoint(context, 64 + 10, 84 + 64);
    //设置下一个坐标点
//    CGContextAddLineToPoint(context, 0, 150);
//    //设置下一个坐标点
//    CGContextAddLineToPoint(context, 50, 180);
//    //设置下一个坐标点
//    CGContextAddLineToPoint(context, 10, 18);

    //设置线条样式
    CGContextSetLineCap(context, kCGLineCapSquare);//kCGLineCapRound    kCGLineCapSquare
    //设置线条粗细宽度，默认为1.0
    CGContextSetLineWidth(context, 12);

    //连接上面定义的坐标点，也就是开始绘图
    CGContextStrokePath(context);




}


@end
