//
//  FindTrendPassWordController.h
//  BYMFinancing
//
//  Created by Administrator on 2016/11/8.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "BYMBaseViewController.h"

@protocol removeSubViewFramSuperView <NSObject>

- (void)delegateSubView;

@end

@interface FindTrendPassWordController : BYMBaseViewController

@property(nonatomic,strong)NSString *userName;
@property(nonatomic,assign)BOOL isFindPWD;

@property(nonatomic,assign)id<removeSubViewFramSuperView> removeDelegate;
@property(nonatomic,copy)void(^popMoneyBlock)();    //pop  重新刷新数据

@end
