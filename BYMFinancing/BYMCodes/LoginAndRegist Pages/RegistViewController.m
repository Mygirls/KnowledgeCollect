//
//  RegistViewController.m
//  BYMFinancing
//
//  Created by Administrator on 2016/11/8.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "RegistViewController.h"
#import "LastRegisterViewController.h"

@interface RegistViewController ()<UITextFieldDelegate>

@property(nonatomic, strong)NSTimer *timer;
@property(nonatomic,assign)NSInteger i;
@property(nonatomic,strong)NSString *type;
@property(nonatomic,assign)BOOL isFromNew;
@property(nonatomic,strong)UITextField *phoneNumfield;              // 手机号码
@property(nonatomic,strong)UITextField *codeOfMessagerTextfield;    //短信验证码
@property(nonatomic,strong)UIButton *getCodeMessagerButton;         //获取验证码按钮
@property(nonatomic,strong)UIButton *nextStepButton;                //下一步按钮
@property(nonatomic,strong)UILabel *noticeLabel;                    //提醒
@property(nonatomic,strong)UITextField *inviteTextField;         //邀请码
@end

@implementation RegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [super _initViewBackItem];
    
    self.title = @"注册";
    self.view.backgroundColor = HMColor(240, 244, 245);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeAuthKeyboard:)];
    [self.view addGestureRecognizer:tap];                                    //2.收起键盘
    
    [self initSubViews];                                                     //3.创建subViews
    
}

#pragma mark - setUp subViews
- (void)initSubViews
{
    [self.view addSubview:self.phoneNumfield];
    [self.view addSubview:self.codeOfMessagerTextfield];
    [self.view addSubview:self.getCodeMessagerButton];
    [self.view addSubview:self.nextStepButton];
    
    [_phoneNumfield mas_makeConstraints:^(MASConstraintMaker *make) {
        if (IS_IPHONE_6PLUS) {
            make.top.mas_equalTo(99);
            make.left.mas_equalTo(30);
            make.right.mas_equalTo(-30);
            make.height.mas_equalTo(48);
        }else{
            make.top.mas_equalTo(99);
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(-20);
            make.height.mas_equalTo(46);
        }
    }];
    
    [_codeOfMessagerTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        if (IS_IPHONE_6PLUS) {
            make.top.mas_equalTo(_phoneNumfield.mas_bottom).offset(8);
            make.left.mas_equalTo(30);
            make.right.mas_equalTo(-120);
            make.height.mas_equalTo(48);
        }else{
            make.top.mas_equalTo(_phoneNumfield.mas_bottom).offset(8);
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(-110);
            make.height.mas_equalTo(46);
        }
    }];
    
    [_getCodeMessagerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        if (IS_IPHONE_6PLUS) {
            make.top.mas_equalTo(_phoneNumfield.mas_bottom).offset(8);
            make.left.mas_equalTo(_codeOfMessagerTextfield.mas_right).offset(-2);
            make.right.mas_equalTo(-30);
            make.height.mas_equalTo(48);
        } else {
            make.top.mas_equalTo(_phoneNumfield.mas_bottom).offset(8);
            make.left.mas_equalTo(_codeOfMessagerTextfield.mas_right).offset(-2);
            make.right.mas_equalTo(-20);
            make.height.mas_equalTo(46);
        }
    }];
    
    [_nextStepButton mas_makeConstraints:^(MASConstraintMaker *make) {
        if (IS_IPHONE_6PLUS) {
            make.top.mas_equalTo(_codeOfMessagerTextfield.mas_bottom).offset(25);
            make.left.mas_equalTo(30);
            make.right.mas_equalTo(-30);
            make.height.mas_equalTo(50);
        } else {
            make.top.mas_equalTo(_codeOfMessagerTextfield.mas_bottom).offset(25);
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(-20);
            make.height.mas_equalTo(45);
        }
    }];
    
}


- (UITextField *)phoneNumfield                                  //电话号码
{
    if (!_phoneNumfield) {
        _phoneNumfield = [UITextField new];
        [self initTextField:_phoneNumfield withTag:1 placeholderString:@"请输入手机号码" leftViewImage:@"dl_user-icon-copy.png" andsecureTextEntry:NO];
    }
    return _phoneNumfield;
}

- (UITextField *)codeOfMessagerTextfield                        //验证码
{
    if (!_codeOfMessagerTextfield) {
        _codeOfMessagerTextfield = [UITextField new];
        [self initTextField:_codeOfMessagerTextfield withTag:2 placeholderString:@"请输入短信验证码" leftViewImage:@"dl_lockbubble.png" andsecureTextEntry:NO];
    }
    return _codeOfMessagerTextfield;
}

- (UITextField *)inviteTextField                                //邀请码《目前版本取消了》
{
    if (!_inviteTextField) {
        _inviteTextField = [UITextField new];
        _inviteTextField.layer.borderWidth = 0.5;
        _inviteTextField.layer.cornerRadius = 2.5;
        _inviteTextField.layer.borderColor = HMColor(183, 186, 191).CGColor;
        _inviteTextField.keyboardType =UIKeyboardTypeNumberPad;
        _inviteTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _inviteTextField.tag = 3;
        _inviteTextField.textAlignment = NSTextAlignmentCenter;
        _inviteTextField.placeholder = @"如您有邀请码,请输入（选填）";
        _inviteTextField.backgroundColor = HMColor(240, 242, 245);
        _inviteTextField.delegate = self;
        _inviteTextField.font = [UIFont systemFontOfSize:15];
        _inviteTextField.textColor= HMColor(51, 51, 51);
        [_inviteTextField setValue:HMColor(204, 204, 204) forKeyPath:@"_placeholderLabel.textColor"];
        [_inviteTextField setValue:BYM_LabelFont(15) forKeyPath:@"_placeholderLabel.font"];
        [_inviteTextField addTarget:self action:@selector(TextFieldDidBeginChange:) forControlEvents:UIControlEventEditingDidBegin];
    }
    return _inviteTextField;
}

- (void)initTextField:(UITextField *)textField withTag:(NSInteger)tag placeholderString:(NSString *)str leftViewImage:(NSString *)imageStr andsecureTextEntry:(BOOL)isSecure
{
    textField.tag = tag;
    textField.font = [UIFont systemFontOfSize:15];
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.secureTextEntry = isSecure;
    textField.backgroundColor = [UIColor whiteColor];
    textField.keyboardType = UIKeyboardTypeNumberPad;
    textField.placeholder =str;
    [textField setValue:holderColor forKeyPath:@"_placeholderLabel.textColor"];
    [textField setValue:BYM_LabelFont(15) forKeyPath:@"_placeholderLabel.font"];
    textField.delegate = self;
    textField.layer.borderColor = HMColor(183, 186, 191).CGColor;
    textField.layer.borderWidth = 0.5;
    textField.layer.cornerRadius = 2.5;
    
    UIImageView *leftImageView = [[UIImageView alloc] init];
    leftImageView.size = CGSizeMake(43, 46);
    leftImageView.image =[UIImage imageNamed:imageStr];//dl_lock.png
    textField.leftView = leftImageView;
    textField.leftViewMode = UITextFieldViewModeAlways;
    [textField addTarget:self action:@selector(TextFieldDidBeginChange:) forControlEvents:UIControlEventEditingDidBegin];
    
    [textField addTarget:self action:@selector(codeOfMessagerTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];                           //监听密码
}


- (UIButton *)getCodeMessagerButton                             //获取验证码
{
    if (!_getCodeMessagerButton) {
        _getCodeMessagerButton = [UIButton new];
        
        [self initButton:_getCodeMessagerButton WithTitleColor:HMColor(128, 128, 128) TitleFont:[UIFont systemFontOfSize:13] BackgroundColor:[UIColor whiteColor] title:@"获取验证码" Enabled:YES cornerRadius:1.5 borderColor:HMColor(183, 186, 191) borderWidth:0.5];
        
        [_getCodeMessagerButton addTarget:self action:@selector(registGetCodeMessagerButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _getCodeMessagerButton;
}

- (UIButton *)nextStepButton                                    //下一步
{
    [TalkingData trackEvent:@"注册" label:@"下一步"];
    if (!_nextStepButton) {
        _nextStepButton = [UIButton new];
        
        [self initButton:_nextStepButton WithTitleColor:buttonFontColor1 TitleFont:[UIFont systemFontOfSize:15] BackgroundColor:buttonColor1 title:@"下一步" Enabled:YES cornerRadius:2.5 borderColor:buttonColor1 borderWidth:0];
        
        [_nextStepButton addTarget:self action:@selector(nextStepButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextStepButton;
}


- (void)initButton:(UIButton *)button WithTitleColor:(UIColor *)titleColor TitleFont:(UIFont *)font BackgroundColor:(UIColor *)backgroundColor title:(NSString *)title Enabled:(BOOL)isEnabled cornerRadius:(CGFloat)radius borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth
{
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.titleLabel.font = font;
    [button setBackgroundColor:backgroundColor];
    [button setTitle:title forState:UIControlStateNormal];
    button.enabled = isEnabled;
    button.layer.cornerRadius = radius;
    button.layer.borderColor = borderColor.CGColor;
    button.layer.borderWidth = borderWidth;
}

#pragma mark - 返回按钮 & 关闭键盘
- (void)backItemAction:(UIButton *)backButton
{
    if (self.isFromNew) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        self.isFromNew = NO;
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)closeAuthKeyboard:(UITapGestureRecognizer *)closeAuthKeyboard
{
    [_phoneNumfield resignFirstResponder];
    [_codeOfMessagerTextfield resignFirstResponder];
    [_inviteTextField resignFirstResponder];
}

#pragma mark - 实施监听textField
- (void)TextFieldDidBeginChange:(BYMBaseTextField *)textField
{
    if (textField.tag == 3) {
        _inviteTextField.layer.borderColor = borderColor2.CGColor;
        _inviteTextField.backgroundColor = [UIColor whiteColor];
    }else if (textField.tag == 2){
        _codeOfMessagerTextfield.layer.borderColor = borderColor2.CGColor;
        _getCodeMessagerButton.layer.borderColor = borderColor2.CGColor;
    }else if (textField.tag == 1){
        _phoneNumfield.layer.borderColor = borderColor2.CGColor;
        
    }
}

- (void)textFieldDidEndEditing:(BYMBaseTextField *)textField
{
    [self codeOfMessagerTextFieldDidChange:textField];
    if (textField.tag == 3) {
        _inviteTextField.layer.borderColor = borderColor1.CGColor;
        if (_inviteTextField.text.length == 0) {
            _inviteTextField.backgroundColor = HMColor(240, 242, 245);
        }else{
        }
    }else if (textField.tag == 2){
        _codeOfMessagerTextfield.layer.borderColor = borderColor1.CGColor;
        _getCodeMessagerButton.layer.borderColor = borderColor1.CGColor;
    }else if (textField.tag == 1){
        _phoneNumfield.layer.borderColor = borderColor1.CGColor;
        
    }
    if (textField.tag == 1) {
        if (_phoneNumfield.text.length == 0) {
//            [self showHUD:@"请输入手机号码"];
//            [self hideHUD:@"请输入手机号码"];
            return;
            
        }  else if (![_phoneNumfield.text isValidateMobile:_phoneNumfield.text]) {
//            [self showHUD:@"手机号码输入有误"];
//            [self hideHUD:@"手机号码输入有误"];
            return;
        }
    }
}


/**
 *  监听密码以保证button
 */
- (void)codeOfMessagerTextFieldDidChange:(BYMBaseTextField *)textField
{
    if (_phoneNumfield.text.length == 0 || _codeOfMessagerTextfield.text.length== 0) {
        _nextStepButton.enabled = NO;
        [_nextStepButton setTitle:@"下一步" forState:UIControlStateNormal];
        _nextStepButton.backgroundColor = buttonColor1;
        [_nextStepButton setTitleColor:buttonFontColor1 forState:UIControlStateNormal];
    }else{
        _nextStepButton.enabled = YES;
        [_nextStepButton setTitle:@"下一步" forState:UIControlStateNormal];
        _nextStepButton.backgroundColor =buttonColor2;
        [_nextStepButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    
}

#pragma mark - MyTextField delegate
- (BOOL)textField:(BYMBaseTextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.tag == 2) {
        int count = 6;
        NSMutableString *newtxt = [NSMutableString stringWithString:textField.text];
        [newtxt replaceCharactersInRange:range withString:string];
        return ([newtxt length] <= count);
        
    } else {
        int count = 11;
        NSMutableString *newtxt = [NSMutableString stringWithString:textField.text];
        [newtxt replaceCharactersInRange:range withString:string];
        return ([newtxt length] <= count);
    }
}


#pragma mark - 下一步按钮事件
- (void)nextStepButtonAction:(UIButton *)nextStepButtonAction
{
    if (_phoneNumfield.text.length == 0) {
//        [self showHUD:@"请输入手机号码"];
//        [self hideHUD:@"请输入手机号码"];
        return;
    }
    
    else if (_codeOfMessagerTextfield.text.length == 0) {
//        [self showHUD:@"请输入验证码"];
//        [self hideHUD:@"请输入验证码"];
        return;
        
    } else {
        //sessionToken 在mainTabBar保存 保存在本地 用于注册登录，《在启动画面SplashScreenDataManager 保存的》
        NSUserDefaults *sessionTokenDefaults = [NSUserDefaults standardUserDefaults];
        NSString *sessionToken = [sessionTokenDefaults objectForKey:@"sessionToken"];
        [sessionTokenDefaults synchronize];
        
        NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
        NSString *adId =[[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
        NSString *str = [NSString stringWithFormat:  @"{\"type\":\"%@\",\"phoneId\":\"%@\",\"yzm\":\"%@\",\"username\":\"%@\",\"sessionToken\":\"%@\"}",self.type,adId,_codeOfMessagerTextfield.text,_phoneNumfield.text,sessionToken];
        [params setObject:str forKey:@"parameters"];
        _nextStepButton.enabled = NO;
        
        [BYMBaseRequest requestWithURL:@"findPwdYzmIsRight" params:params httpMethod:@"POST" blockSuccess:^(id result) {
            _nextStepButton.enabled = YES;
            if ([result isKindOfClass:[NSError class]]) {
                [_getCodeMessagerButton setTitleColor:HMColor(51, 51, 51) forState:UIControlStateNormal];
                [_getCodeMessagerButton setTitle:[NSString stringWithFormat:@"获取验证码"] forState:UIControlStateNormal];
                //                [self showHUD:@"网络或服务器异常"];
                //                [self hideHUD:@"网络或服务器异常"];
                
            } else if ([[result objectForKey:@"end"] isEqualToString:@"ok"]) {
                LastRegisterViewController *lastRVC = [[LastRegisterViewController alloc] init];
                lastRVC.userName = _phoneNumfield.text;
                lastRVC.titleName = @"设置登录密码";
                lastRVC.inviteId = _inviteTextField.text;
                lastRVC.yzm = _codeOfMessagerTextfield.text;
                [self.navigationController pushViewController:lastRVC animated:YES];
                
            } else if ([[result objectForKey:@"end"] isEqualToString:@"error"]) {
                //                [self showHUD:[result objectForKey:@"message"]];
                //                [self hideHUD:[result objectForKey:@"message"]];
                //
            } else if ([[result objectForKey:@"end"] isEqualToString:@"paramError"]) {
                //                [self showHUD:[result objectForKey:@"message"]];
                //                [self hideHUD:[result objectForKey:@"message"]];
                
            }else if ([[result objectForKey:@"end"] isEqualToString:@"noData"]) {
                //                [self showHUD:[result objectForKey:@"message"]];
                //                [self hideHUD:[result objectForKey:@"message"]];
                
            } else {
                //                [self showHUD:[result objectForKey:@"message"]];
                //                [self hideHUD:[result objectForKey:@"message"]];
            }

        } blockFailure:^(id result) {
    
                    }];
    }
}

#pragma mark - 获取验证码按钮
- (void)registGetCodeMessagerButton:(UIButton *)getCodeMessagerButton
{
    [TalkingData trackEvent:@"注册" label:@"获取验证码"];
    
    if (_phoneNumfield.text.length == 0) {
//        [self showHUD:@"请输入手机号码"];
//        [self hideHUD:@"请输入手机号码"];
        return;
        
    }  else if (![_phoneNumfield.text isValidateMobile:_phoneNumfield.text]) {
//        [self showHUD:@"电话号码错误"];
//        [self hideHUD:@"电话号码错误"];
        return;
    }
    [self getDataOfCode];
    
}

- (void)getDataOfCode
{
    if (_i  != 0) {
        _getCodeMessagerButton.enabled = NO;
        return ;
    }
    
    //sessionToken 在mainTabBar保存 保存在本地 用于注册登录
    NSUserDefaults *sessionTokenDefaults = [NSUserDefaults standardUserDefaults];
    NSString *sessionToken = [sessionTokenDefaults objectForKey:@"sessionToken"];
    [sessionTokenDefaults synchronize];
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];//phoneId
    NSString *adId =[[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    NSString *str = [NSString stringWithFormat:  @"{\"type\":\"%@\",\"phoneId\":\"%@\",\"username\":\"%@\",\"sessionToken\":\"%@\"}",self.type,adId,_phoneNumfield.text,sessionToken];
    [params setObject:str forKey:@"parameters"];
//    [self showHUD:@"正在获取验证码。。。"];
    
    [BYMBaseRequest requestWithURL:@"findPwdSendYzm" params:params httpMethod:@"POST" blockSuccess:^(id result) {
        if ([result isKindOfClass:[NSError class]]) {
//            [self hideHUD:@"网络或服务器异常"];
            
        } else if ([[result objectForKey:@"end"] isEqualToString:@"ok"]) {
            [self countStart:120];
//            [self hideHUD:@"验证码发送成功"];
            [BYM_UserDefulats setObject:_phoneNumfield.text forKey:@"userNum"];     /*此处保存电话号码用于注册*/
            [BYM_UserDefulats synchronize];
            
        } else if ([[result objectForKey:@"end"] isEqualToString:@"error"]) {
            _getCodeMessagerButton.enabled = YES;
            [_getCodeMessagerButton setTitleColor:HMColor(51, 51, 51) forState:UIControlStateNormal];
            [_getCodeMessagerButton setTitle:[NSString stringWithFormat:@"获取验证码"] forState:UIControlStateNormal];
//            [self hideHUD:[result objectForKey:@"message"]];
            
        } else if ([[result objectForKey:@"end"] isEqualToString:@"paramError"]) {
//            [self hideHUD:[result objectForKey:@"电话号码不正确"]];
        } else {
//            [self hideHUD:@"获取验证码失败"];
        }

    } blockFailure:^(id result) {
 
            }];
}

#pragma mark - 计时器 － 开始计时
- (void)countStart:(NSInteger)s
{
    [_timer setFireDate:[NSDate distantPast]];              // 开启定时器
    _getCodeMessagerButton.enabled = NO;
    _i = s;
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerActionGetCode:) userInfo:nil repeats:YES];
    }
}

- (void)timerActionGetCode:(NSTimer *)tiemr
{
    if (_i == 0) {
        [_getCodeMessagerButton setTitleColor:HMColor(51, 51, 51) forState:UIControlStateNormal];
        [_getCodeMessagerButton setTitle:[NSString stringWithFormat:@"重新发送"] forState:UIControlStateNormal];
        _getCodeMessagerButton.enabled = YES;
        _noticeLabel.hidden = YES;
        //关闭定时器
        [_timer setFireDate:[NSDate distantFuture]];
        
    } else {
        _i --;
        [_getCodeMessagerButton setTitleColor:HMColor(128, 128, 128) forState:UIControlStateNormal];
        [_getCodeMessagerButton setTitle:[NSString stringWithFormat:@"已发送%lds",(long)_i] forState:UIControlStateNormal];
        _getCodeMessagerButton.enabled = NO;
        _noticeLabel.hidden = NO;
        NSString *str = [BYM_UserDefulats objectForKey:@"userNum"];
        _noticeLabel.text = [NSString stringWithFormat:@"已发送验证码短信至%@，请稍后",str];
    }
    NSString *str = [NSString stringWithFormat:@"%ld",(long)_i];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"regist" object:str userInfo:nil];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [TalkingData trackPageBegin:@"注册界面"];
    self.tabBarController.tabBar.hidden = YES;
    if (_i == 0) {
        _getCodeMessagerButton.enabled = YES;
        [_getCodeMessagerButton setTitleColor:HMColor(51, 51, 51) forState:UIControlStateNormal];
        [_getCodeMessagerButton setTitle:[NSString stringWithFormat:@"获取验证码"] forState:UIControlStateNormal];
        _noticeLabel.hidden = YES;
    }
    else{
        _getCodeMessagerButton.enabled = NO;
        [_getCodeMessagerButton setTitle:[NSString stringWithFormat:@"已发送%lds",_i] forState:UIControlStateNormal];
        [_getCodeMessagerButton setTitleColor:HMColor(128, 128, 128) forState:UIControlStateNormal];
        _noticeLabel.hidden = NO;
        NSString *str = [BYM_UserDefulats objectForKey:@"userNum"];
        _noticeLabel.text = [NSString stringWithFormat:@"已发送验证码短信至%@，请稍后",str];
    }
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [TalkingData trackPageEnd:@"注册界面"];
}


@end
