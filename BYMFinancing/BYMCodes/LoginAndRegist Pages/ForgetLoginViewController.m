//
//  ForgetLoginViewController.m
//  BYMFinancing
//
//  Created by Administrator on 2016/11/8.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ForgetLoginViewController.h"
#import "LastRegisterViewController.h"
@interface ForgetLoginViewController ()<UITextFieldDelegate>

{
    NSTimer *_timer;
    
}
@property (nonatomic, assign)  NSInteger j;
@property (strong, nonatomic)  UITextField *phoneNumField;          // 手机号码
@property (strong, nonatomic)  UILabel *noticeLabel;                //提示文本
@property (strong, nonatomic)  UITextField *forgetCodeTextField;
@property (strong, nonatomic)  UIButton *forgetGetCodeButton;
@property (strong, nonatomic)  UIButton *forgetNextStepButton;

@end

@implementation ForgetLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [super _initViewBackItem];
    
    
    self.title = @"忘记密码";
    self.view.backgroundColor = HMColor(240, 244, 245);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeAuthKeyboard:)];
    [self.view addGestureRecognizer:tap];
    
    [self initSubviews];
}

- (void)initSubviews
{
    [self.view addSubview:self.noticeLabel];
    [self.view addSubview:self.phoneNumField];
    [self.view addSubview:self.forgetCodeTextField];
    [self.view addSubview:self.forgetGetCodeButton];
    [self.view addSubview:self.forgetNextStepButton];
    
    [_noticeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        if (IS_IPHONE_6PLUS) {
            make.top.mas_equalTo(79);
            make.left.mas_equalTo(40);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(13);
        }else{
            make.top.mas_equalTo(79);
            make.left.mas_equalTo(40);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(13);
        }
    }];
    
    [_phoneNumField mas_makeConstraints:^(MASConstraintMaker *make) {
        if (IS_IPHONE_6PLUS) {
            make.top.mas_equalTo(_noticeLabel.mas_bottom).offset(8);
            make.left.mas_equalTo(-5);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(50);
        }else{
            make.top.mas_equalTo(_noticeLabel.mas_bottom).offset(8);
            make.left.mas_equalTo(-5);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(46);
        }
    }];
    
    
    [_forgetCodeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        if (IS_IPHONE_6PLUS) {
            make.top.mas_equalTo(_phoneNumField.mas_bottom).offset(0);
            make.left.mas_equalTo(-5);
            make.right.mas_equalTo(-120);
            make.height.mas_equalTo(50);
        }else{
            make.top.mas_equalTo(_phoneNumField.mas_bottom).offset(0);
            make.left.mas_equalTo(-5);
            make.right.mas_equalTo(-110);
            make.height.mas_equalTo(46);
        }
    }];
    
    [_forgetGetCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        if (IS_IPHONE_6PLUS) {
            make.top.mas_equalTo(_phoneNumField.mas_bottom).offset(0);
            make.left.mas_equalTo(_forgetCodeTextField.mas_right).offset(-2);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(50);
        } else {
            make.top.mas_equalTo(_phoneNumField.mas_bottom).offset(0);
            make.left.mas_equalTo(_forgetCodeTextField.mas_right).offset(-2);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(46);
        }
    }];
    
    
    [_forgetNextStepButton mas_makeConstraints:^(MASConstraintMaker *make) {
        if (IS_IPHONE_6PLUS) {
            make.top.mas_equalTo(_forgetCodeTextField.mas_bottom).offset(25);
            make.left.mas_equalTo(30);
            make.right.mas_equalTo(-30);
            make.height.mas_equalTo(50);
        } else {
            make.top.mas_equalTo(_forgetCodeTextField.mas_bottom).offset(25);
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(-20);
            make.height.mas_equalTo(45);
        }
    }];
    
    
}

#pragma mark -- 返回按钮 & 键盘隐藏
- (void)backItemAction:(UIButton *)backButton
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)closeAuthKeyboard:(UITapGestureRecognizer *)closeAuthKeyboard
{
    [_phoneNumField resignFirstResponder];
    [_forgetCodeTextField resignFirstResponder];
}


- (UILabel *)noticeLabel
{
    if (!_noticeLabel) {
        _noticeLabel = [UILabel new];
        _noticeLabel.text = @"请确保您的手机畅通,以接收验证码短信";
        _noticeLabel.font = BYM_LabelFont(13);
        _noticeLabel.textColor = HMColor(128, 128, 128);
    }
    return _noticeLabel;
}
//电话号码
- (UITextField *)phoneNumField {
    if (!_phoneNumField) {
        _phoneNumField = [UITextField new];
        [self initTextField:_phoneNumField withTag:0 placeholderString:@"请输入手机号码" leftViewImage:nil andsecureTextEntry:NO backgroundColor:[UIColor whiteColor]];
    }
    return _phoneNumField;
}
//电话号码
- (UITextField *)forgetCodeTextField {
    if (!_forgetCodeTextField) {
        _forgetCodeTextField = [UITextField new];
        [self initTextField:_forgetCodeTextField withTag:1 placeholderString:@"请输入短信验证码" leftViewImage:nil andsecureTextEntry:NO backgroundColor:[UIColor whiteColor]];
    }
    return _forgetCodeTextField;
}

- (void)initTextField:(UITextField *)textField withTag:(NSInteger)tag placeholderString:(NSString *)str leftViewImage:(NSString *)imageStr andsecureTextEntry:(BOOL)isSecure backgroundColor:(UIColor *)backgroundColor
{
    textField.tag = tag;
    textField.font = BYM_LabelFont(15);
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.secureTextEntry = isSecure;
    textField.keyboardType = UIKeyboardTypeNumberPad;
    textField.placeholder =str;
    [textField setValue:holderColor forKeyPath:@"_placeholderLabel.textColor"];
    [textField setValue:BYM_LabelFont(15) forKeyPath:@"_placeholderLabel.font"];
    textField.delegate = self;
    textField.layer.borderColor = HMColor(183, 186, 191).CGColor;
    textField.layer.borderWidth = 0.5;
    textField.backgroundColor = backgroundColor;
    
    UIImageView *leftImageView = [[UIImageView alloc] init];
    leftImageView.size = CGSizeMake(43, 44);
    leftImageView.image =[UIImage imageNamed:imageStr];//dl_lock.png
    textField.leftView = leftImageView;
    textField.leftViewMode = UITextFieldViewModeAlways;
    //监听密码
    [textField addTarget:self action:@selector(codeOfMessagerTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

//获取验证码
- (UIButton *)forgetGetCodeButton
{
    if (!_forgetGetCodeButton) {
        _forgetGetCodeButton = [UIButton new];
        
        [self initButton:_forgetGetCodeButton WithTitleColor:HMColor(128, 128, 128) TitleFont:BYM_LabelFont(13) BackgroundColor:[UIColor whiteColor] title:@"获取验证码" Enabled:NO cornerRadius:1.5 borderColor:HMColor(183, 186, 191) borderWidth:0.5];
        
        [_forgetGetCodeButton addTarget:self action:@selector(nextGetDataOfCode) forControlEvents:UIControlEventTouchUpInside];
    }
    return _forgetGetCodeButton;
}

//下一步
- (UIButton *)forgetNextStepButton
{
    if (!_forgetNextStepButton) {
        _forgetNextStepButton = [UIButton new];
        
        [self initButton:_forgetNextStepButton WithTitleColor:buttonFontColor1 TitleFont:BYM_LabelFont(15) BackgroundColor:buttonColor1 title:@"下一步" Enabled:NO cornerRadius:2.5 borderColor:buttonColor1 borderWidth:0];
        
        [_forgetNextStepButton addTarget:self action:@selector(nextStepButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _forgetNextStepButton;
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


#pragma mark -  下一步按钮事件
- (void)nextStepButtonAction:(UIButton *)nextStepButtonAction
{
    if (![_phoneNumField.text isValidateMobile:_phoneNumField.text]) { //判断一下
//        [self showHUD:@"手机号码输⼊有误"];
//        [self hideHUD:@"手机号码输入有误"];
        return;
        
    } else {
        //sessionToken 在mainTabBar保存 保存在本地 用于注册登录
        NSString *sessionToken = [BYM_UserDefulats objectForKey:@"sessionToken"];
        [BYM_UserDefulats synchronize];
        
        NSMutableDictionary * params = [[NSMutableDictionary alloc] init];//phoneId
        NSString *adId =[[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
        NSString *str = [NSString stringWithFormat:  @"{\"type\":\"%@\",\"phoneId\":\"%@\",\"yzm\":\"%@\",\"username\":\"%@\",\"sessionToken\":\"%@\"}",@"2",adId,_forgetCodeTextField.text,_phoneNumField.text,sessionToken];
        
        [params setObject:str forKey:@"parameters"];
        _forgetGetCodeButton.enabled = NO;
        _forgetNextStepButton.enabled = NO;
        [BYMBaseRequest requestWithURL:@"findPwdYzmIsRight" params:params httpMethod:@"POST" blockSuccess:^(id result) {
            _forgetGetCodeButton.enabled = YES;
            _forgetNextStepButton.enabled = YES;
            if ([result isKindOfClass:[NSError class]]) {
                [_forgetGetCodeButton setTitleColor:buttonColor1 forState:UIControlStateNormal];
                [_forgetGetCodeButton setTitle:[NSString stringWithFormat:@"获取验证码"] forState:UIControlStateNormal];
                //                [self showHUD:@"网络或服务器异常"];
                //                [self hideHUD:@"网络或服务器异常"];
                
            } else if ([[result objectForKey:@"end"] isEqualToString:@"ok"]) {
                    LastRegisterViewController *lastRVC = [[LastRegisterViewController alloc] init];
                    lastRVC.userName = _phoneNumField.text;
                    lastRVC.titleName = @"重置密码";
                    lastRVC.isChangePassword = YES;
                    lastRVC.yzm = _forgetCodeTextField.text;
                    [self.navigationController pushViewController:lastRVC animated:YES];
                
            } else if ([[result objectForKey:@"end"] isEqualToString:@"error"]) {
                //                [self showHUD:[result objectForKey:@"message"]];
                //                [self hideHUD:[result objectForKey:@"message"]];
                
            } else if ([[result objectForKey:@"end"] isEqualToString:@"paramError"]) {
                //                [self showHUD:[result objectForKey:@"message"]];
                //                [self hideHUD:[result objectForKey:@"message"]];
                //
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


- (void)nextGetDataOfCode
{
    if (![_phoneNumField.text isValidateMobile:_phoneNumField.text]) {
//        [self showHUD:@"手机号码输⼊有误"];
//        [self hideHUD:@"手机号码输入有误"];
        return;
        
    } else {
        
//        [self showHUD:@"处理中..."];
        _forgetGetCodeButton.enabled = NO;
    
        NSString *sionToken = [BYM_UserDefulats objectForKey:@"sessionToken"];
        [BYM_UserDefulats synchronize];
        
        NSMutableDictionary * params = [[NSMutableDictionary alloc] init];//phoneId
        NSString *adId =[[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
        NSString *str = [NSString stringWithFormat:  @"{\"type\":\"%@\",\"phoneId\":\"%@\",\"username\":\"%@\",\"sessionToken\":\"%@\"}",@"2",adId,_phoneNumField.text,sionToken];
        
        [params setObject:str forKey:@"parameters"];
        
        [BYMBaseRequest requestWithURL:@"findPwdSendYzm" params:params httpMethod:@"POST" blockSuccess:^(id result) {
            if ([result isKindOfClass:[NSError class]]) {
                _forgetGetCodeButton.enabled = YES;
                [_forgetGetCodeButton setTitleColor:buttonColor2 forState:UIControlStateNormal];
//                [self hideHUD:@"网络或服务器异常"];
                
            } else if ([[result objectForKey:@"end"] isEqualToString:@"ok"]) {
//                [self hideHUD:@"验证码发送成功"];
                [self countStart:120];
                
            } else if ([[result objectForKey:@"end"] isEqualToString:@"error"]) {
                _forgetGetCodeButton.enabled = YES;
                [_forgetGetCodeButton setTitleColor:buttonColor2 forState:UIControlStateNormal];
//                [self hideHUD:[result objectForKey:@"message"]];
                
            } else if ([[result objectForKey:@"end"] isEqualToString:@"paramError"]) {
//                [self hideHUD:[result objectForKey:@"message"]];
                
            } else {
//                [self hideHUD:@"message"];
            }

        } blockFailure:^(id result) {
            
    
                    }];
        
    }
}

#pragma mark - 计时器  开始计时
- (void)countStart:(NSInteger)s
{
    // 开启定时器
    [_timer setFireDate:[NSDate distantPast]];
    _forgetGetCodeButton.enabled = NO;
    _j = s;
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerActionGetCode:) userInfo:nil repeats:YES];
    }
}

- (void)timerActionGetCode:(NSTimer *)tiemr
{
    if (_j == 0) {
        [_forgetGetCodeButton setTitleColor:HMColor(51, 51, 51) forState:UIControlStateNormal];
        [_forgetGetCodeButton setTitle:[NSString stringWithFormat:@"重新发送"] forState:UIControlStateNormal];
        _forgetGetCodeButton.enabled = YES;
        //关闭定时器
        [_timer setFireDate:[NSDate distantFuture]];
        
    } else {
        _j --;
        [_forgetGetCodeButton setTitleColor:HMColor(128, 128, 128) forState:UIControlStateNormal];
        [_forgetGetCodeButton setTitle:[NSString stringWithFormat:@"已发送%lds",_j] forState:UIControlStateNormal];
        _forgetGetCodeButton.enabled = NO;
        
    }
}

//监听验证码以保证button
- (void)codeOfMessagerTextFieldDidChange:(UITextField *)textField
{
    
    if (_forgetCodeTextField.text.length != 0 &&_phoneNumField.text.length == 11 ) {
        _forgetNextStepButton.enabled = YES;
        _forgetNextStepButton.backgroundColor =buttonColor2;
        [_forgetNextStepButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else if((_forgetCodeTextField.text.length == 0 || _phoneNumField.text.length < 11 )){
        _forgetNextStepButton.enabled = NO;
        [_forgetNextStepButton setTitle:@"下一步" forState:UIControlStateNormal];
        [_forgetNextStepButton setTitle:@"下一步" forState:UIControlStateNormal];
        _forgetNextStepButton.backgroundColor = buttonColor1;
        [_forgetNextStepButton setTitleColor:buttonFontColor1 forState:UIControlStateNormal];
    }
    
    
    if (_phoneNumField.text.length < 11) {
        _forgetGetCodeButton.enabled = NO;
        [_forgetGetCodeButton setTitleColor:HMColor(128, 128, 128) forState:UIControlStateNormal];
        
    } else if(_phoneNumField.text.length == 11){
        _forgetGetCodeButton.enabled = YES;
        [_forgetGetCodeButton setTitleColor:buttonColor2 forState:UIControlStateNormal];
        
    }
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (_phoneNumField.text.length == 0 &&textField.tag ==1) {
//        [self showHUD:@"请输入手机号码"];
//        [self hideHUD:@"请输入手机号码"];
        return;
        
    }  else if (![_phoneNumField.text isValidateMobile:_phoneNumField.text]&&textField.tag ==1) {
//        [self showHUD:@"手机号码输入有误"];
//        [self hideHUD:@"手机号码输入有误"];
        return;
    }
}

#pragma mark - UITextField delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.tag == 1) {
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



@end
