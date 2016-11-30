//
//  BYMBaseViewController.h
//  BYMFinancing
//
//  Created by Administrator on 2016/11/2.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BYMBaseViewController : UIViewController

@property (nonatomic, strong)NSMutableArray *refreshImages;//刷新动画的图片数组
@property (nonatomic, strong)NSMutableArray *normalImages; //普通状态下的图片数组

@property (nonatomic, assign)BOOL            lineHad;      //导航栏下是否含有一条横线 默认NO

/**
 *  定义父类：返回按钮
 */
-(void)_initViewBackItem;

@end
