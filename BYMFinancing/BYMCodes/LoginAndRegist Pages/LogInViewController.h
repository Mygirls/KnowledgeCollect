//
//  LogInViewController.h
//  BYMFinancing
//
//  Created by Administrator on 2016/11/4.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "BYMBaseViewController.h"

@protocol sendTotalMiaoInfo <NSObject>

- (void)senddic:(NSDictionary *)dic;                                    /*登录成功回调block,传递登录成功后返回的数据*/

@end

@interface LogInViewController : BYMBaseViewController

@property(nonatomic,copy)NSString *isChangeUser;
@property(nonatomic,copy)void(^myReloadDataBlock)(NSDictionary *dic);   /*登录成功回调block,传递登录成功后返回的数据*/
@property(nonatomic,assign)id <sendTotalMiaoInfo>delegate;
@property(nonatomic,assign)BOOL isFrameDuiHuanCommitVC;                 /*  是否从兑换页面跳转到此页面*/

@end
