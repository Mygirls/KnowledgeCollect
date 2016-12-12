//
//  JQKLinePartLineView.m
//  BYMFinancing
//
//  Created by administrator on 2016/12/2.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JQKLinePartLineView.h"
#import "JQKTimeLineModel.h"
#define YYStockLineMainViewMinY 2

@implementation JQKLinePartLineView




- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    if (!self.drawPositionModels) {
        return;
    }
    
    
    CGContextSetLineWidth(ctx, 1);
    CGPoint firstPoint = [self.drawPositionModels.firstObject CGPointValue];
    
    if (isnan(firstPoint.x) || isnan(firstPoint.y)) {
        return;
    }
    NSAssert(!isnan(firstPoint.x) && !isnan(firstPoint.y), @"出现NAN值：MA画线");
    
    //画分时线
    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextMoveToPoint(ctx, firstPoint.x, firstPoint.y);
    for (NSInteger idx = 1; idx < self.drawPositionModels.count ; idx++)
    {
        CGPoint point = [self.drawPositionModels[idx] CGPointValue];
        CGContextAddLineToPoint(ctx, point.x, point.y);
    }
    CGContextStrokePath(ctx);
    
    
    CGContextSetFillColorWithColor(ctx, [UIColor grayColor].CGColor);
    CGPoint lastPoint = [self.drawPositionModels.lastObject CGPointValue];
    
    //画背景色
    CGContextMoveToPoint(ctx, firstPoint.x, firstPoint.y);
    for (NSInteger idx = 1; idx < self.drawPositionModels.count ; idx++)
    {
        CGPoint point = [self.drawPositionModels[idx] CGPointValue];
        CGContextAddLineToPoint(ctx, point.x, point.y);
    }
    CGContextAddLineToPoint(ctx, lastPoint.x, CGRectGetMaxY(self.frame));
    CGContextAddLineToPoint(ctx, firstPoint.x, CGRectGetMaxY(self.frame));
    CGContextClosePath(ctx);
    CGContextFillPath(ctx);
}


//TODO:  返回坐标数组
- (NSArray *)drawViewWithXPosition:(CGFloat)xPosition drawModels:(NSArray *)drawLineModels  maxValue:(CGFloat)maxValue minValue:(CGFloat)minValue {
    NSAssert(drawLineModels, @"数据源不能为空");
    
    //转换为实际坐标
    [self convertToPositionModelsWithXPosition:xPosition drawLineModels:drawLineModels maxValue:maxValue minValue:minValue];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setNeedsDisplay];
    });
    return [self.drawPositionModels copy];
}

- (NSArray *)convertToPositionModelsWithXPosition:(CGFloat)startX
                                   drawLineModels:(NSArray *)drawLineModels
                                         maxValue:(CGFloat)maxOfValue
                                         minValue:(CGFloat)minOfValue {
    if (!drawLineModels) return nil;
    
    [self.drawPositionModels removeAllObjects];
    
    CGFloat minY = YYStockLineMainViewMinY;
    CGFloat maxY = self.frame.size.height - YYStockLineMainViewMinY;
    CGFloat unitValue = (maxOfValue - minOfValue)/(maxY - minY);
    
    [drawLineModels enumerateObjectsUsingBlock:^(JQKTimeLineModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat xPosition = startX + idx * (2.5 + 0.1);
        CGPoint pricePoint = CGPointMake(xPosition, ABS(maxY - (model.Price.floatValue - minOfValue)/unitValue));
        [self.drawPositionModels addObject:[NSValue valueWithCGPoint:pricePoint]];
        //NSLog(@"index = %ld --xPosition = %f,pricePointY = %f",idx,xPosition,pricePoint.y);

    }];
    
    return self.drawPositionModels ;
}

- (NSMutableArray *)drawPositionModels {
    if (!_drawPositionModels) {
        _drawPositionModels = [NSMutableArray array];
    }
    return _drawPositionModels;
}



@end
