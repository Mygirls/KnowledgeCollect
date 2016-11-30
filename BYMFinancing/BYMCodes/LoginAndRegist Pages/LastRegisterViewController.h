//
//  LastRegisterViewController.h
//  BYMFinancing
//
//  Created by Administrator on 2016/11/8.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "BYMBaseViewController.h"

@interface LastRegisterViewController : BYMBaseViewController

@property(nonatomic,strong)NSString *userName;              //上个页面传递的电话号码
@property(nonatomic,strong)NSString *titleName;             //设置self.title
@property(nonatomic,assign)BOOL isChangePassword;           //判断是否是修改密码还是注册时设置密码
@property(nonatomic,strong)NSString *inviteId;              //邀请id
@property(nonatomic,copy)NSString *yzm;
@end
