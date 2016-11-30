//
//  ForgetTradePasswordViewController.m
//  BYMFinancing
//
//  Created by Administrator on 2016/11/8.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ForgetTradePasswordViewController.h"
#import "FindTrendPassWordController.h"



@interface ForgetTradePasswordViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) BYMBaseTextField *phoneNumTextField;
@property (nonatomic, strong) BYMBaseTextField *codeNumTextField;
@property (nonatomic, strong) UIButton *nextStepButton;
@property (nonatomic, strong) UIButton *getCodeNumButton;

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger i;

@end

@implementation ForgetTradePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [super _initViewBackItem];
    
    
    self.view.backgroundColor = HMColor(240, 244, 245);
    [self addAllChildViews];                   //初始化视图
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeAuthKeyboard:)];
    [self.view addGestureRecognizer:tap];

}

- (void)closeAuthKeyboard:(UITapGestureRecognizer *)closeAuthKeyboard
{
    [_phoneNumTextField resignFirstResponder];
    [ _codeNumTextField resignFirstResponder];
}

- (void)addAllChildViews
{
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 70, 100, 15)];
    titleLabel.font = BYM_LabelFont(13);
    titleLabel.text =@"忘记交易密码";
    titleLabel.textColor = [UIColor grayColor];
    [self.view addSubview:titleLabel];
    
    UIView *phoneNumBgView = [[UIView alloc]initWithFrame:CGRectMake(0, titleLabel.bottom+3, KScreen_Width, 45)];
    phoneNumBgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:phoneNumBgView];
    
    UILabel *phoneTextLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 15, 60, 15)];
    phoneTextLabel.text = @"手机";
    phoneTextLabel.font = BYM_LabelFont(15);
    [phoneNumBgView addSubview:phoneTextLabel];
    
    _phoneNumTextField = [[BYMBaseTextField alloc]initWithFrame:CGRectMake(phoneTextLabel.right+10, 8, KScreen_Width-110, 30)];
    _phoneNumTextField.keyboardType = UIKeyboardTypeNumberPad;
    _phoneNumTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _phoneNumTextField.tag = 1;
    _phoneNumTextField.delegate =self;
    _phoneNumTextField.font = BYM_LabelFont(15);
    _phoneNumTextField.placeholder = @"请输入预留手机号码";
    [_phoneNumTextField setValue:HMColor(204, 204, 204) forKeyPath:@"_placeholderLabel.textColor"];
    //监听手机号码
    [_phoneNumTextField addTarget:self action:@selector(forgetPWDPhoneNumTextFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    [phoneNumBgView addSubview:_phoneNumTextField];
    
    
    
    UIView *codeNumBgView = [[UIView alloc]initWithFrame:CGRectMake(0, phoneNumBgView.bottom+1, KScreen_Width, 45)];
    codeNumBgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:codeNumBgView];
    
    UILabel *codeTextLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 15, 60, 15)];
    codeTextLabel.text = @"验证码";
    codeTextLabel.font = BYM_LabelFont(15);
    [codeNumBgView addSubview:codeTextLabel];
    UIView  *defaultLabel4 = [[UIView alloc]initWithFrame:CGRectMake(KScreen_Width-100,0, 0.5, 45)];
    defaultLabel4.backgroundColor = HMColor(229, 229, 229);
    [codeNumBgView addSubview:defaultLabel4];
    
    _codeNumTextField = [[BYMBaseTextField alloc]initWithFrame:CGRectMake(phoneTextLabel.right+10, 8, KScreen_Width-190, 30)];
    _codeNumTextField.keyboardType = UIKeyboardTypeNumberPad;
    _codeNumTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _codeNumTextField.tag = 2;
    _codeNumTextField.delegate = self;
    _codeNumTextField.font = BYM_LabelFont(15);
    _codeNumTextField.placeholder = @"请输入验证码";
    [_codeNumTextField setValue:HMColor(204, 204, 204) forKeyPath:@"_placeholderLabel.textColor"];
    //监听手机号码
    [_codeNumTextField addTarget:self action:@selector(forgetPWDCodeNumTextFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    [codeNumBgView addSubview:_codeNumTextField];
    
    _getCodeNumButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _getCodeNumButton.frame = CGRectMake(KScreen_Width-100, 5, 100, 35);
    _getCodeNumButton.titleLabel.font = BYM_LabelFont(13);
    _getCodeNumButton.enabled = NO;
    [_getCodeNumButton setTitle:[NSString stringWithFormat:@"获取验证码"] forState:UIControlStateNormal];
    [_getCodeNumButton setTitleColor:HMColor(51, 51, 51) forState:UIControlStateNormal];
    [_getCodeNumButton addTarget:self action:@selector(getCodeNumButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [codeNumBgView addSubview:_getCodeNumButton];
    
    
    _nextStepButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _nextStepButton.frame = CGRectMake(20, codeNumBgView.bottom+50, KScreen_Width-40, 45);
    _nextStepButton.layer.cornerRadius = 2.5;
    _nextStepButton.titleLabel.textColor = [UIColor whiteColor];
    _nextStepButton.enabled = NO;
    _nextStepButton.backgroundColor = HMColor(221, 222, 223);
    [_nextStepButton setTitle:@"下一步" forState:UIControlStateNormal];
    [_nextStepButton addTarget:self action:@selector(nextStepButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_nextStepButton];
    
}
- (void)forgetPWDPhoneNumTextFieldDidChange
{
    if (_i  != 0) return;
    if (_phoneNumTextField.text.length == 0 ) {
        _getCodeNumButton.enabled = NO;
        [_getCodeNumButton setTitle:[NSString stringWithFormat:@"获取验证码"] forState:UIControlStateNormal];
    }else{
        _getCodeNumButton.enabled = YES;
        [_getCodeNumButton setTitle:[NSString stringWithFormat:@"获取验证码"] forState:UIControlStateNormal];
    }
}
- (void)forgetPWDCodeNumTextFieldDidChange
{
    if (_phoneNumTextField.text.length == 0 || _codeNumTextField.text.length== 0) {
        _nextStepButton.enabled = NO;
        _nextStepButton.backgroundColor = HMColor(221, 222, 223);
    }else{
        _nextStepButton.enabled = YES;
        _nextStepButton.backgroundColor = HMColor(247, 69, 69);
    }
    
}

/**
 *  获取验证码
 */
- (void)getCodeNumButtonClick
{
    if (_phoneNumTextField.text.length == 0) {
//        [self showHUD:@"请输入手机号码"];
//        [self hideHUD:@"请输入手机号码"];
        return;
        
    }  else if (![_phoneNumTextField.text isValidateMobile:_phoneNumTextField.text]) {
//        [self showHUD:@"手机号码错误"];
//        [self hideHUD:@"手机号码错误"];
        return;
    }
    
    [self getDataOfCode];
}

- (void)getDataOfCode
{
    if (_i != 0) {
        _getCodeNumButton.enabled = NO;
        return ;
    }
    
    if (_phoneNumTextField.text.length == 0) {
//        [self showHUD:@"请输入手机号码"];
//        [self hideHUD:@"请输入手机号码"];
        return;
        
    }  else if (![_phoneNumTextField.text isValidateMobile:_phoneNumTextField.text]) {
//        [self showHUD:@"电话号码错误"];
//        [self hideHUD:@"电话号码错误"];
        return;
        
    } else {
//        [self showHUD:@"处理中..."];
        
        //sessionToken 在mainTabBar保存 保存在本地 用于注册登录
        NSUserDefaults *sessionTokenDefaults = [NSUserDefaults standardUserDefaults];
        NSString *sessionToken = [sessionTokenDefaults objectForKey:@"sessionToken"];
        [sessionTokenDefaults synchronize];
        
        NSMutableDictionary * params = [[NSMutableDictionary alloc] init];//phoneId
        NSString *adId =[[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
        NSString *str = [NSString stringWithFormat:  @"{\"type\":\"%@\",\"phoneId\":\"%@\",\"username\":\"%@\",\"sessionToken\":\"%@\"}",@"3",adId,_phoneNumTextField.text,sessionToken];
        [params setObject:str forKey:@"parameters"];
        
        [BYMBaseRequest requestWithURL:@"findPwdSendYzm" params:params httpMethod:@"POST" blockSuccess:^(id result) {
            if ([result isKindOfClass:[NSError class]]) {
                [_getCodeNumButton setTitle:[NSString stringWithFormat:@"获取验证码"] forState:UIControlStateNormal];
//                [self hideHUD:@"网络或服务器异常"];
                
            } else if ([[result objectForKey:@"end"] isEqualToString:@"ok"]) {
                if (_i > 0){
                    [self countStart:_i];
                }else{
                    [self countStart:120];
                }
                
//                [self hideHUD:@"验证码发送成功"];
                
            } else if ([[result objectForKey:@"end"] isEqualToString:@"error"]) {
                _getCodeNumButton.enabled = YES;
                [_getCodeNumButton setTitle:[NSString stringWithFormat:@"获取验证码"] forState:UIControlStateNormal];
//                [self hideHUD:[result objectForKey:@"message"]];
                
            } else if ([[result objectForKey:@"end"] isEqualToString:@"paramError"]) {
//                [self hideHUD:[result objectForKey:@"电话号码不正确"]];
                
            } else {
//                [self hideHUD:@"获取验证码失败"];
            }

        } blockFailure:^(id result) {
            
         }];
    }
}


/**
 *  计时器  开始计时
 */
- (void)countStart:(NSInteger)s
{
    [_timer setFireDate:[NSDate distantPast]];      // 开启定时器
    _getCodeNumButton.enabled = NO;
    _i = s;
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerActionGetCode:) userInfo:nil repeats:YES];
    }
}

- (void)timerActionGetCode:(NSTimer *)tiemr
{
    if (_i == 0) {
        
        //关闭定时器
        [_timer setFireDate:[NSDate distantFuture]];
    } else {
        _i --;
    }
    
    [self showLabel];
}

- (void)showLabel
{
    NSString *str = [NSString stringWithFormat:@"%ld",(long)_i];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"forgetTradePassword" object:str userInfo:nil];
    if (_i == 0) {
        if (_phoneNumTextField.text.length == 0) {
            _getCodeNumButton.enabled = NO;
            [_getCodeNumButton setTitle:[NSString stringWithFormat:@"获取验证码"] forState:UIControlStateNormal];
            
        }else{
            _getCodeNumButton.enabled = YES;
            [_getCodeNumButton setTitle:[NSString stringWithFormat:@"获取验证码"] forState:UIControlStateNormal];
        }
        
        [_timer setFireDate:[NSDate distantFuture]];        //关闭定时器
    }else{
        _getCodeNumButton.enabled = NO;
        [_getCodeNumButton setTitle:[NSString stringWithFormat:@"重新发送(%lds)",_i] forState:UIControlStateNormal];
    }
}

/**
 *  下一步按钮
 */
- (void)nextStepButtonClick
{
    if (_phoneNumTextField.text.length == 0) {
//        [self showHUD:@"请输入手机号码"];
//        [self hideHUD:@"请输入手机号码"];
        return;
        
    }else if (![_phoneNumTextField.text isValidateMobile:_phoneNumTextField.text]) {
//        [self showHUD:@"手机号码错误"];
//        [self hideHUD:@"手机号码错误"];
        return;
    }
    else if (_codeNumTextField.text.length == 0) {
//        [self showHUD:@"请输入验证码"];
//        [self hideHUD:@"请输入验证码"];
        return;
        
    } else {
        _nextStepButton.enabled = NO;
        
        //sessionToken 在mainTabBar保存 保存在本地 用于注册登录
        NSUserDefaults *sessionTokenDefaults = [NSUserDefaults standardUserDefaults];
        NSString *sessionToken = [sessionTokenDefaults objectForKey:@"sessionToken"];
        [sessionTokenDefaults synchronize];
        NSMutableDictionary * params = [[NSMutableDictionary alloc] init];//phoneId
        NSString *adId =[[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
        NSString *str = [NSString stringWithFormat:  @"{\"type\":\"%@\",\"phoneId\":\"%@\",\"yzm\":\"%@\",\"username\":\"%@\",\"sessionToken\":\"%@\"}",@"3",adId,_codeNumTextField.text,_phoneNumTextField.text,sessionToken];
        [params setObject:str forKey:@"parameters"];
        [BYMBaseRequest requestWithURL:@"findPwdYzmIsRight" params:params httpMethod:@"POST" blockSuccess:^(id result) {
            _nextStepButton.enabled = YES;
            if ([result isKindOfClass:[NSError class]]) {
                [_getCodeNumButton setTitle:[NSString stringWithFormat:@"获取验证码"] forState:UIControlStateNormal];
                //                [self showHUD:@"网络或服务器异常"];
                //                [self hideHUD:@"网络或服务器异常"];
                
            } else if ([[result objectForKey:@"end"] isEqualToString:@"ok"]) {
                FindTrendPassWordController *findTradeVC = [[FindTrendPassWordController alloc] init];
                findTradeVC.userName = _phoneNumTextField.text;
                findTradeVC.isFindPWD = NO;
                [self.navigationController pushViewController:findTradeVC animated:YES];
                
            } else if ([[result objectForKey:@"end"] isEqualToString:@"error"]) {
                //                [self showHUD:[result objectForKey:@"message"]];
                //                [self hideHUD:[result objectForKey:@"message"]];
                
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



#pragma mark - UITextField delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
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
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    if (_i == 0) {
        if (_phoneNumTextField.text.length == 0 ) {
            _getCodeNumButton.enabled = NO;
            [_getCodeNumButton setTitle:[NSString stringWithFormat:@"获取验证码"] forState:UIControlStateNormal];
        }else{
            _getCodeNumButton.enabled = YES;
            [_getCodeNumButton setTitle:[NSString stringWithFormat:@"获取验证码"] forState:UIControlStateNormal];
        }
    }
    else{
        _getCodeNumButton.enabled = NO;
        [_getCodeNumButton setTitle:[NSString stringWithFormat:@"重新发送(%lds)",_i] forState:UIControlStateNormal];
    }
}


- (void)backItemAction:(UIButton *)backButton
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
