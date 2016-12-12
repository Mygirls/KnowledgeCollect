//
//  TestView.m
//  BYMFinancing
//
//  Created by administrator on 2016/12/7.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "TestView.h"

@implementation TestView

- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();

    //设置部分的背景颜色
    CGContextSetFillColorWithColor(ctx, [UIColor orangeColor].CGColor);
    CGContextFillRect(ctx, CGRectMake(0, 0, 50, 50));
    
    

//    //绘制背景色
//    CGContextSetFillColorWithColor(ctx, [UIColor orangeColor].CGColor);
//    CGContextFillRect(ctx, CGRectMake(10, 10, 20, 100));
    
//    //绘制成交量线
//    CGContextSetStrokeColorWithColor(ctx, [UIColor blueColor].CGColor);
//    CGContextSetLineWidth(ctx, 2.5);
//    const CGPoint solidPoints[] = {20, 100};
//    CGContextStrokeLineSegments(ctx, solidPoints, 2);

    
    //绘制成交量线
//    CGContextSetStrokeColorWithColor(ctx, [UIColor blueColor].CGColor);
//    CGContextSetLineWidth(ctx, 2.5);
//    const CGPoint solidPoints1[] = {30, 50};
//    CGContextStrokeLineSegments(ctx, solidPoints1, 2);
    
    
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    UIColor *strokeColor =  [UIColor orangeColor];
    CGContextSetStrokeColorWithColor(ctx, strokeColor.CGColor);
    
    
    CGContextSetLineWidth(ctx, 2);
    const CGPoint shadowPoints[] = {CGPointMake(64 + 10, 64 + 63), CGPointMake(74, 84 + 70)};
    CGContextStrokeLineSegments(ctx, shadowPoints, 2);

    
    
    CGContextSetLineWidth(ctx, 12);
    const CGPoint solidPoints[] = {CGPointMake(100, 100),CGPointMake(100, 120)};
    CGContextStrokeLineSegments(ctx, solidPoints, 2);
    
    /**     const CGPoint solidPoints[] = {CGPointMake(100, 100),CGPointMake(100, 120)};
            CGContextStrokeLineSegments(ctx, shadowPoints, 2);
     等价：
       CGContextBeginPath（context）;
           for（k = 0; k <count; k + = 2）{
                CGContextMoveToPoint（context，s [k] .x，s [k] .y）;
                CGContextAddLineToPoint（context，s [k + 1] .x，s [k + 1] .y）;
           }}
       CGContextStrokePath（context）
     
         CGContextBeginPath(ctx);
         for (int i = 0; i < 2; i ++) {
             CGContextMoveToPoint(ctx, 100, 100);
             CGContextAddLineToPoint(ctx, 100, 120);
         }
     
     */
    
    CGContextBeginPath(ctx);
    for (int i = 0; i < 2; i ++) {
        CGContextMoveToPoint(ctx, 100, 100);
        CGContextAddLineToPoint(ctx, 100, 120);
    }

    
    CGContextStrokePath(ctx);
}

@end
