//
//  LastRegisterViewController.m
//  BYMFinancing
//
//  Created by Administrator on 2016/11/8.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "LastRegisterViewController.h"

@interface LastRegisterViewController ()<UITextFieldDelegate>

@property(nonatomic,strong)UITextField *registerPassword;
@property(nonatomic,strong)UITextField *registerAgainPassword;
@property(nonatomic,strong)UIButton *registerButton;
@property(nonatomic,strong)UILabel *protocalLabel;
@property (nonatomic,strong) UIView *coverView;
@end

@implementation LastRegisterViewController
/**
 *  用于设置密码和召回密码
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    [super _initViewBackItem];
    
    
    self.title = self.titleName;
    self.view.backgroundColor = HMColor(240, 244, 245);
    
    [self initSubviews];
    
    [self addLabel];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyBoard:)];
    [self.view addGestureRecognizer:tap1];
    
}

/**
 *  setUp Views
 */
- (void)initSubviews
{
    [self.view addSubview:self.registerPassword];
    [self.view addSubview:self.registerAgainPassword];
    [self.view addSubview:self.registerButton];
    [self.view addSubview:self.protocalLabel];
    
    [_registerPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        if (IS_IPHONE_6PLUS) {
            make.top.mas_equalTo(99);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(50);
        }else{
            make.top.mas_equalTo(99);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(46);
        }
    }];
    
    [_registerAgainPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        if (IS_IPHONE_6PLUS) {
            make.top.mas_equalTo(_registerPassword.mas_bottom).offset(8);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(50);
        }else{
            make.top.mas_equalTo(_registerPassword.mas_bottom).offset(8);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(46);
        }
    }];
    
    [_registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        if (IS_IPHONE_6PLUS) {
            make.top.mas_equalTo(_registerAgainPassword.mas_bottom).offset(25);
            make.left.mas_equalTo(30);
            make.right.mas_equalTo(-30);
            make.height.mas_equalTo(50);
        } else {
            make.top.mas_equalTo(_registerAgainPassword.mas_bottom).offset(25);
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(-20);
            make.height.mas_equalTo(45);
        }
    }];
    
    [_protocalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_registerButton.mas_bottom).offset(8);
        make.width.mas_equalTo(250);
        make.height.mas_equalTo(15);
        make.centerX.mas_equalTo(self.view.mas_centerX).offset(0);
    }];
    
}

- (UITextField *)registerPassword
{
    if (!_registerPassword) {
        _registerPassword = [UITextField new];
        [self initTextField:_registerPassword withTag:0 placeholderString:@"请设置登录密码" leftViewImage:nil andsecureTextEntry:YES];
    }
    return _registerPassword;
}

- (UITextField *)registerAgainPassword
{
    if (!_registerAgainPassword) {
        _registerAgainPassword = [UITextField new];
        [self initTextField:_registerAgainPassword withTag:1 placeholderString:@"请再次输入登录密码" leftViewImage:nil andsecureTextEntry:YES];
    }
    return _registerAgainPassword;
}

- (void)initTextField:(UITextField *)textField withTag:(NSInteger)tag placeholderString:(NSString *)str leftViewImage:(NSString *)imageStr andsecureTextEntry:(BOOL)isSecure
{
    textField.tag = tag;
    textField.font = BYM_LabelFont(15);
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.secureTextEntry = isSecure;
    textField.placeholder =str;
    [textField setValue:holderColor forKeyPath:@"_placeholderLabel.textColor"];
    [textField setValue:BYM_LabelFont(15) forKeyPath:@"_placeholderLabel.font"];
    textField.delegate = self;
    textField.layer.borderColor = HMColor(183, 186, 191).CGColor;
    textField.layer.borderWidth = 0.5;
    textField.backgroundColor = [UIColor whiteColor];
    
    UIImageView *leftImageView = [[UIImageView alloc] init];
    leftImageView.size = CGSizeMake(43, 20);
    leftImageView.image =[UIImage imageNamed:imageStr];//dl_lock.png
    textField.leftView = leftImageView;
    textField.leftViewMode = UITextFieldViewModeAlways;
    
    //监听密码
    [textField addTarget:self action:@selector(passwordTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [textField addTarget:self action:@selector(passwordTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
}

//完成按钮
- (UIButton *)registerButton
{
    if (!_registerButton) {
        _registerButton = [UIButton new];
        [self initButton:_registerButton WithTitleColor:buttonFontColor1 TitleFont:BYM_LabelFont(15) BackgroundColor:buttonColor1 title:@"完成" Enabled:NO cornerRadius:2.5];
    }
    return _registerButton;
}

- (void)initButton:(UIButton *)button WithTitleColor:(UIColor *)titleColor TitleFont:(UIFont *)font BackgroundColor:(UIColor *)backgroundColor title:(NSString *)title Enabled:(BOOL)isEnabled cornerRadius:(CGFloat)radius
{
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.titleLabel.font = font;
    [button setBackgroundColor:backgroundColor];
    [button setTitle:title forState:UIControlStateNormal];
    button.enabled = isEnabled;
    button.layer.cornerRadius = radius;
    [button addTarget:self action:@selector(registerAndChangePassword:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)addLabel
{
    if (self.isChangePassword == YES) { //修改密码的时候隐藏注册协议
        _protocalLabel.hidden = YES;
        
    } else {
        _protocalLabel.hidden = NO;
    }
    
}

#pragma mark - 佰亿猫用户协议
- (UILabel *)protocalLabel
{
    if (!_protocalLabel) {
        //协议
        _protocalLabel = [UILabel new];
        _protocalLabel.userInteractionEnabled = YES;
        _protocalLabel.text = @"注册即同意《佰亿猫用户协议》";
        _protocalLabel.font = BYM_LabelFont(15);
        _protocalLabel.textAlignment = NSTextAlignmentCenter;
        _protocalLabel.textColor = HMColor(165, 165, 165);
        [_protocalLabel settingLabelTextColor:HMColor(51 , 51, 51) withStr:@"《佰亿猫用户协议》"];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(protocalTapAction:)];
        [_protocalLabel addGestureRecognizer:tap];
        
    }
    return _protocalLabel;
}

- (void)protocalTapAction:(UITapGestureRecognizer *)protocalTapAction
{
//    zhucexieyiViewController *registerProtocalVC = [[zhucexieyiViewController alloc] init];
//    [self.navigationController pushViewController:registerProtocalVC animated:YES];
}


//监听密码以保证button
- (void)passwordTextFieldDidChange:(UITextField *)textField
{
    if (_registerPassword.text.length == 0 || _registerAgainPassword.text.length== 0) {
        _registerButton.enabled = NO;
        [_registerButton setBackgroundColor:buttonColor1];
        [_registerButton setTitleColor:buttonFontColor1 forState:UIControlStateNormal];
    }else{
        _registerButton.enabled = YES;
        [_registerButton setBackgroundColor:buttonColor2];
        [_registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    
}

#pragma mark -- 返回按钮 & 关闭键盘
- (void)backItemAction:(UIButton *)backButton
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)closeKeyBoard:(UITapGestureRecognizer *)tap
{
    [_registerPassword resignFirstResponder];
    [_registerAgainPassword resignFirstResponder];
}

#pragma mark - 设置和修改密码
- (void)registerAndChangePassword:(UIButton *)buttton {
    
    if (![_registerPassword.text isEqualToString:_registerAgainPassword.text]) {
//        [self showHUD:@"密码不一致"];
//        [self hideHUD:@"密码不一致"];
        return;
        
    } else if (_registerPassword.text.length == 0 || _registerAgainPassword.text.length == 0) {
//        [self showHUD:@"密码不能为空"];
//        [self hideHUD:@"密码不能为空"];
        return;
        
    }else {
        if (self.isChangePassword == YES) {        //修改密码
            [self changePassword];
            
        } else {
//            [self showHUD:@"正在注册"];             //注册时设置密码
            [self registPassword];
        }
    }
}

- (void)changePassword                            //type 0为登录密码，1为交易密码
{
    //sessionToken 在mainTabBar保存 保存在本地 用于注册登录《在启动画面SplashScreenDataManager 保存的》

    NSString *sessionToken = [BYM_UserDefulats objectForKey:@"sessionToken"];
    [BYM_UserDefulats synchronize];
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];//phoneId
    NSString *adId =[[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    NSString *str = [NSString stringWithFormat:
                     @"{\"password\":\"%@\",\"pwd\":\"%@\",\"username\":\"%@\",\"type\":\"%@\",\"phoneId\":\"%@\",\"sessionToken\":\"%@\",\"yzm\":\"%@\"}",_registerPassword.text,_registerAgainPassword.text,self.userName,@"0",adId,sessionToken,self.yzm];
    
    [params setObject:str forKey:@"parameters"];
    _registerButton.enabled = NO;
    [BYMBaseRequest requestWithURL:@"findPwdUpdatePwd" params:params httpMethod:@"POST" blockSuccess:^(id result) {
        _registerButton.enabled = YES;
        if ([result isKindOfClass:[NSError class]]) {
//            [self showHUD:@"网络或服务器异常"];
//            [self hideHUD:@"网络或服务器异常"];
            
        } else if ([[result objectForKey:@"end"] isEqualToString:@"ok"]) {
//            [self showHUD:@"修改成功"];
//            [self hideHUD:@"修改成功"];
            [BYM_UserDefulats setObject:result forKey:@"userDefulats"];
            [BYM_UserDefulats synchronize];
            
            [self performSelector:@selector(successfulOfChange) withObject:nil afterDelay:1];
            
        } else if ([[result objectForKey:@"end"] isEqualToString:@"error"]) {
//            [self showHUD:[result objectForKey:@"message"]];
//            [self hideHUD:[result objectForKey:@"message"]];
//            
        } else if ([[result objectForKey:@"end"] isEqualToString:@"paramError"]) {
//            [self showHUD:[result objectForKey:@"修改失败"]];
//            [self hideHUD:[result objectForKey:@"修改失败"]];
            
        } else {
//            [self showHUD:@"修改失败"];
//            [self hideHUD:@"修改失败"];
        }

    } blockFailure:^(id result) {
  
            }];
    
}

- (void)registPassword
{
    [self.view endEditing:YES];
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    //sessionToken 在mainTabBar保存 保存在本地 用于注册登录《在启动画面SplashScreenDataManager 保存的》
    NSUserDefaults *sessionTokenDefaults = [NSUserDefaults standardUserDefaults];
    NSString *sessionToken = [sessionTokenDefaults objectForKey:@"sessionToken"];
    [sessionTokenDefaults synchronize];
    NSString *adId =[[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    NSString *str = [NSString stringWithFormat:
                     @"{\"password\":\"%@\",\"pwd\":\"%@\",\"username\":\"%@\",\"registPlatform\":\"%@\",\"phoneId\":\"%@\",\"inviteId\":\"%@\",\"yzm\":\"%@\",\"sessionToken\":\"%@\"}",_registerPassword.text,_registerAgainPassword.text,self.userName,@"2",adId,self.inviteId,self.yzm,sessionToken];
    [params setObject:str forKey:@"parameters"];
    _registerButton.enabled = NO;
    
    [BYMBaseRequest requestWithURL:@"phoneRegisterUser" params:params httpMethod:@"POST" blockSuccess:^(id result) {
        _registerButton.enabled = YES;
        if ([result isKindOfClass:[NSError class]]) {
//            [self showHUD:@"网络或服务器异常"];
//            [self hideHUD:@"网络或服务器异常"];
            
        } else if ([[result objectForKey:@"end"] isEqualToString:@"ok"]) {
            [BYM_UserDefulats setObject:result forKey:@"userDefulats"];
            [BYM_UserDefulats synchronize];
            
            //该通知在首页中监听
            [[NSNotificationCenter defaultCenter] postNotificationName:@"registPasswordSuccess" object:nil];
            
            [self performSelector:@selector(successfulOfRegister) withObject:nil afterDelay:0];
            
        } else if ([[result objectForKey:@"end"] isEqualToString:@"error"]) {
//            [self showHUD:[result objectForKey:@"message"]];
//            [self hideHUD:[result objectForKey:@"message"]];
            
        } else if ([[result objectForKey:@"end"] isEqualToString:@"paramError"]) {
//            [self showHUD:[result objectForKey:@"设置密码失败"]];
//            [self hideHUD:[result objectForKey:@"设置密码失败"]];
//            
        } else {
            
//            [self hideHUD:@"设置密码失败"];
//            [self hideHUD:@"设置密码失败"];
        }

    } blockFailure:^(id result) {
  
        
    }];
}

- (void)successfulOfChange                      // 修改成功
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)successfulOfRegister                    // 注册成功跳转到首页
{
//    MainTabBarViewController *mainTBC = [MainTabBarViewController shareMainTabBarViewControler];
//    mainTBC.selectedIndex = 0;
//    
//    //为甚么是 ：dismissViewControllerAnimated  因为：弹出登陆页面是 presentViewController
//    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITextField delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    int count = 16;
    NSMutableString *newtxt = [NSMutableString stringWithString:textField.text];
    [newtxt replaceCharactersInRange:range withString:string];
    return ([newtxt length] <= count);
    
}

    
@end
