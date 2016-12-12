//
//  JQKTimeLineView.m
//  BYMFinancing
//
//  Created by administrator on 2016/12/1.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JQKTimeLineView.h"
#import "JQKTimeLineModel.h"
#import "JQKLinePartLineView.h"
#import "JQKLinePartVolumeView.h"
@interface JQKTimeLineView ()

/**
 当前绘制在屏幕上的数据源数组
 */
@property (nonatomic, strong) NSArray *drawLineModels;

@property (nonatomic, copy) NSArray *drawLinePositionModels;//位置数组
@property (nonatomic, strong) JQKLinePartLineView *timeLineView;//分时


@property (nonatomic, strong) JQKLinePartVolumeView *volumeView;//成交量

@end

@implementation JQKTimeLineView
{
#pragma mark - 页面上显示的数据
    //图表最大的价格
    CGFloat maxValue;
    //图表最小的价格
    CGFloat minValue;
    //图表最大的成交量
    CGFloat volumeValue;
    
    //当前长按选中的model
    JQKTimeLineModel *selectedModel;
}

- (instancetype)initWithTimeLineModels:(NSArray *)models
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor orangeColor];
        _drawLineModels = models;

        [self setUpInit];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    [self updateDrawModels];
    
    //分时
    self.drawLinePositionModels = [self.timeLineView drawViewWithXPosition:0 drawModels:self.drawLineModels maxValue:maxValue minValue:minValue];
    
    
    //成交量
    [self.volumeView drawViewWithXPosition:0 drawModels:self.drawLineModels ];

}
- (void)setUpInit {
    
    //加载TimeLineView
    _timeLineView = [JQKLinePartLineView new];
    _timeLineView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_timeLineView];
    [_timeLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(self.mas_bottom).with.offset(-300);
        make.top.equalTo(self.mas_top).with.offset(100);

    }];


    _volumeView = [JQKLinePartVolumeView new];
    _volumeView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_volumeView];
    [_volumeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(self.mas_bottom).with.offset(-30);
        make.top.equalTo(self.mas_top).with.offset(400);
    }];
    
}


/**
 更新需要绘制的数据源：Price   最大值最小值-价格
 */
- (void)updateDrawModels {
    
    //KVO 更新最大值最小值-价格
    JQKTimeLineModel *model = (JQKTimeLineModel *)self.drawLineModels.firstObject;
    CGFloat average = [model AvgPrice];
    maxValue = [[self.drawLineModels valueForKeyPath:@"Price.@max.floatValue"] floatValue];
    minValue = [[self.drawLineModels valueForKeyPath:@"Price.@min.floatValue"] floatValue];
    if (ABS(maxValue - average) > ABS(average - minValue)) {
        minValue = 2 * average - maxValue;
    } else {
        maxValue = 2 * average - minValue;
    }
}





@end
