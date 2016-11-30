//
//  KACircleProgressView.h
//  BYMFinancing
//
//  Created by Administrator on 2016/11/8.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KACircleProgressView : UIView

@property (nonatomic, strong) UIColor *trackColor;
@property (nonatomic, strong) UIColor *progressColor;
@property (nonatomic, assign) CGFloat progress;//0~1之间的数
@property (nonatomic, assign) CGFloat progressWidth;
@property (nonatomic, assign) CGFloat nextLevel;//下一等级

@end
