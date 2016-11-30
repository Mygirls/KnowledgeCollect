//
//  PersonalCenterViewController.h
//  BYMFinancing
//
//  Created by Administrator on 2016/11/7.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "BYMBaseViewController.h"

@interface PersonalCenterViewController : BYMBaseViewController

@property(nonatomic,strong)NSDictionary *dataList;
@property(nonatomic,copy)void(^myBlock)();
@property(nonatomic,strong)NSString *leftMoney;//账户余额
@property(nonatomic,copy)NSString *userNum;
@property(nonatomic,copy)NSString *isUnbind;

@end
