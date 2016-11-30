//
//  BYMTabBar.m
//  BYMFinancing
//
//  Created by Administrator on 2016/11/1.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "BYMTabBar.h"

@implementation BYMTabBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat offset = 6.0;
    for (UITabBarItem *item in self.items) {
        item.imageInsets = UIEdgeInsetsMake(offset, 0, -offset, 0);
        item.titlePositionAdjustment = UIOffsetMake(0, -6);
    }
}
@end
