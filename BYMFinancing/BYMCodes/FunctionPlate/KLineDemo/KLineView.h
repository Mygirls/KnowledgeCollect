//
//  KLineView.h
//  BYMFinancing
//
//  Created by administrator on 2016/11/30.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KLineView : UIView


//画柱状图
- (void)drawZhuZhuangTu:(NSArray *)x_itemArr and:(NSArray *)y_itemArr;

//画饼形图
- (void)drawBingZhuangTu:(NSArray *)x_itemArr and:(NSArray *)y_itemArr;

//画折线图
- (void)drawZheXianTu:(NSArray *)x_itemArr and:(NSArray *)y_itemArr;


//画一根柱形测试
- (void)drawOneZhuxing;

//画椭圆 测试用的
- (void)drawTuoYuan;

//画K线图 阴线 阳线
- (void)drawKlineTest;


@end
