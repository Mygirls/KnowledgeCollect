//
//  JQKLinePartVolumeView.m
//  BYMFinancing
//
//  Created by administrator on 2016/12/3.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JQKLinePartVolumeView.h"
#import "JQKLineVolumePositionModel.h"
#define YYStockLineVolumeViewMinY 2
#define YYStockLineDayHeight 20
#define YYStockTimeLineViewVolumeGap 0.1

@interface JQKLinePartVolumeView ()
@property (nonatomic, strong) NSMutableArray *drawPositionModels;

@end

@implementation JQKLinePartVolumeView


- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    if (!self.drawPositionModels) {
        return;
    }
    
    CGFloat lineMaxY = self.frame.size.height - YYStockLineDayHeight - YYStockLineVolumeViewMinY;
    
    //绘制背景色
    JQKLineVolumePositionModel *lastModel = self.drawPositionModels.lastObject;
    CGContextSetFillColorWithColor(ctx, [UIColor whiteColor].CGColor);
    CGContextFillRect(ctx, CGRectMake(0, 0, lastModel.EndPoint.x, lineMaxY));
    
    [self.drawPositionModels enumerateObjectsUsingBlock:^(JQKLineVolumePositionModel  *_Nonnull pModel, NSUInteger idx, BOOL * _Nonnull stop) {
        
        //NSLog(@"%f %f %f %f",pModel.StartPoint.x,pModel.StartPoint.y,pModel.EndPoint.x,pModel.EndPoint.y);
        //绘制成交量线
        CGContextSetStrokeColorWithColor(ctx, [UIColor blueColor].CGColor);
        CGContextSetLineWidth(ctx, 2.5);
        const CGPoint solidPoints[] = {pModel.StartPoint, pModel.EndPoint};
        CGContextStrokeLineSegments(ctx, solidPoints, 2);
        
        //绘制日期
        if (pModel.DayDesc.length > 0) {
            NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:10],NSForegroundColorAttributeName:[UIColor orangeColor]};
            CGRect rect = [pModel.DayDesc boundingRectWithSize:CGSizeMake(MAXFLOAT, 0)
                                                       options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin |
                           NSStringDrawingUsesFontLeading
                                                    attributes:attribute
                                                       context:nil];
            
            CGFloat width = rect.size.width;
            if (pModel.StartPoint.x - width/2.f < 0) {
                //最左边判断
                [pModel.DayDesc drawAtPoint:CGPointMake(pModel.StartPoint.x, pModel.EndPoint.y) withAttributes:attribute];
            } else if(pModel.StartPoint.x + width/2.f > self.bounds.size.width) {
                //最右边判断
                [pModel.DayDesc drawAtPoint:CGPointMake(pModel.StartPoint.x - width, pModel.EndPoint.y) withAttributes:attribute];
            } else {
                [pModel.DayDesc drawAtPoint:CGPointMake(pModel.StartPoint.x - width/2.f, pModel.EndPoint.y) withAttributes:attribute];
            }
        }
    }];
    
}

- (void)drawViewWithXPosition:(CGFloat)xPosition drawModels:(NSArray *)drawLineModels {
    NSAssert(drawLineModels, @"数据源不能为空");
    //转换为实际坐标
    [self convertToPositionModelsWithXPosition:xPosition drawLineModels:drawLineModels];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setNeedsDisplay];
    });
}

//
- (void)convertToPositionModelsWithXPosition:(CGFloat)startX drawLineModels:(NSArray *)drawLineModels  {
    if (!drawLineModels) return;
    
    [self.drawPositionModels removeAllObjects];

    CGFloat minValue =  [[drawLineModels valueForKeyPath:@"Volume.@min.floatValue"] floatValue];
    CGFloat maxValue =  [[drawLineModels valueForKeyPath:@"Volume.@max.floatValue"] floatValue];
    
    CGFloat minY = YYStockLineVolumeViewMinY;
    CGFloat maxY = self.frame.size.height - YYStockLineVolumeViewMinY - YYStockLineDayHeight;
    
    CGFloat unitValue = (maxValue - minValue)/(maxY - minY);
    
    [drawLineModels enumerateObjectsUsingBlock:^(JQKTimeLineModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CGFloat xPosition = startX + idx * (2.5 + 0.1);
        CGFloat yPosition = ABS(maxY - (model.Volume - minValue)/unitValue);
        
        CGPoint startPoint = CGPointMake(xPosition, ABS(yPosition - maxY) > 1 ? yPosition : maxY );
        CGPoint endPoint = CGPointMake(xPosition, maxY);
        
        NSString *dayDesc = model.isShowTimeDesc ? model.TimeDesc : @"";
        
        JQKLineVolumePositionModel *positionModel = [JQKLineVolumePositionModel modelWithStartPoint:startPoint endPoint:endPoint dayDesc:dayDesc];
        [self.drawPositionModels addObject:positionModel];
        
    }];
}
- (NSMutableArray *)drawPositionModels {
    if (!_drawPositionModels) {
        _drawPositionModels = [NSMutableArray array];
    }
    return _drawPositionModels;
}

@end
