//
//  LogInViewController.m
//  BYMFinancing
//
//  Created by Administrator on 2016/11/4.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "LogInViewController.h"
#import "ForgetLoginViewController.h"
#import "RegistViewController.h"

@interface LogInViewController ()<UITextFieldDelegate>
/**
 *接收注册页面的定时数字
 */
@property(nonatomic,assign)NSInteger i;
@property(nonatomic,copy ) NSString *textName;

@property(nonatomic,strong)BYMBaseTextField *phoneNumTextfield;
@property(nonatomic,strong)BYMBaseTextField *passwordTextField;
@property(nonatomic,strong)UIButton *loginButton;
@property(nonatomic,strong)UIButton *forgetPasswordButton;
@property(nonatomic,strong)UIView *bigBackView;
@property(nonatomic,strong)UIView *phoneView;
@property(nonatomic,strong)UIView *passwordView;
@property(nonatomic,strong)UIImageView *imageView;

@end

@implementation LogInViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"登录";
    
    [super _initViewBackItem];                           //1.返回按钮
    
    [self _initNacvgationWithItem];                     //2.右边注册按钮
    
    [self initSubviews];                                //3.初始化视图
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyBoard:)];
    [self.view addGestureRecognizer:tap];               //4.监听键盘退出
}
#pragma mark - 初始化视图
- (void)initSubviews
{
    [self.view        addSubview:self.bigBackView];
    [self.bigBackView addSubview:self.phoneNumTextfield];
    [self.bigBackView addSubview:self.passwordTextField];
    [self.bigBackView addSubview:self.phoneView];
    [self.bigBackView addSubview:self.passwordView];
    [self.bigBackView addSubview:self.loginButton];
    [self.bigBackView addSubview:self.forgetPasswordButton];
    
    UIView *view =[[UILabel alloc]initWithFrame:CGRectMake(0, 63.5, KScreen_Width, .5)];
    view.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:.1];
    [self.view addSubview:view];
    
}

- (UIView *)bigBackView
{
    if (!_bigBackView) {
        _bigBackView = [UIView new];
        _bigBackView.frame = CGRectMake(0, 0, KScreen_Width, KScreen_Height);
        _bigBackView.backgroundColor =  [UIColor whiteColor];
        
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake((KScreen_Width-85)/2.0, (KScreen_Width/2.0-85)/2.0 +64, 85, 85)];
        _imageView.image = [UIImage imageNamed:@"loginpicture.png"];
        [_bigBackView addSubview:_imageView];
    }
    return _bigBackView;
}

- (UIView *)phoneView
{
    if (!_phoneView) {
        _phoneView = [[UIView alloc] initWithFrame:CGRectMake(20, self.phoneNumTextfield.y +44, KScreen_Width-40, 0.5)];
        _phoneView.backgroundColor = HMColor(229, 229, 229);
    }
    return _phoneView;
}

- (UIView *)passwordView
{
    if (!_passwordView) {
        _passwordView = [[UIView alloc] initWithFrame:CGRectMake(20, self.passwordTextField.y +44, KScreen_Width-40, 0.5)];
        _passwordView.backgroundColor = HMColor(229, 229, 229);
    }
    return _passwordView;
}


//电话号码
- (BYMBaseTextField *)phoneNumTextfield {
    if (!_phoneNumTextfield) {
        _phoneNumTextfield = [BYMBaseTextField new];
        _phoneNumTextfield.frame = CGRectMake(20,64+KScreen_Width/2.0+8, KScreen_Width-40, 44);
        [self initTextField:_phoneNumTextfield withTag:11 placeholderString:@"请输入您的用户名" leftViewImage:@"" andsecureTextEntry:NO backgroundColor:[UIColor clearColor] keyboardType:UIKeyboardTypeNumberPad];
    }
    return _phoneNumTextfield;
}

- (void)initTextField:(BYMBaseTextField *)textField withTag:(NSInteger)tag placeholderString:(NSString *)str leftViewImage:(NSString *)imageStr andsecureTextEntry:(BOOL)isSecure backgroundColor:(UIColor *)backgroundColor keyboardType:(UIKeyboardType)keyboardType
{
    textField.tag = tag;
    textField.font = [UIFont systemFontOfSize:15];
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.secureTextEntry = isSecure;
    textField.keyboardType = keyboardType;
    textField.placeholder =str;
    [textField setValue:holderColor forKeyPath:@"_placeholderLabel.textColor"];
    [textField setValue:BYM_LabelFont(15) forKeyPath:@"_placeholderLabel.font"];
    textField.delegate = self;
    
    textField.backgroundColor = [UIColor clearColor];
    textField.textAlignment = NSTextAlignmentCenter;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    [textField addTarget:self action:@selector(TextFieldDidBeginChange:) forControlEvents:UIControlEventEditingDidBegin];
    //监听密码
    [textField addTarget:self action:@selector(passwordTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

//密码
- (BYMBaseTextField *)passwordTextField
{
    if (!_passwordTextField) {
        _passwordTextField = [[BYMBaseTextField alloc]init];
        _passwordTextField.frame = CGRectMake(20,64+KScreen_Width/2.0+8+44, KScreen_Width-40, 44);
        [self initTextField:_passwordTextField withTag:10 placeholderString:@"请输入您的用户密码" leftViewImage:@"" andsecureTextEntry:YES backgroundColor:[UIColor clearColor] keyboardType:UIKeyboardTypeDefault];
    }
    return _passwordTextField;
}

//登陆按钮
- (UIButton *)loginButton
{
    if (!_loginButton) {
        _loginButton = [UIButton new];
        _loginButton.frame = CGRectMake(20, _passwordView.y +32, KScreen_Width-40, 44) ;
        [self initButton:_loginButton WithTitleColor:buttonFontColor1 TitleFont:BYM_LabelFont(15) BackgroundColor:buttonColor1 title:@"立即登录" Enabled:NO cornerRadius:2.5];
        
        [_loginButton addTarget:self action:@selector(loginButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}

//忘记密码按钮
- (UIButton *)forgetPasswordButton
{
    if (!_forgetPasswordButton) {
        _forgetPasswordButton = [UIButton new];
        _forgetPasswordButton.size = CGSizeMake(150, 24);
        _forgetPasswordButton.center = CGPointMake(KScreen_Width/2.0, self.loginButton.y +44+16+5);
        [self initButton:_forgetPasswordButton WithTitleColor:HMColor(128, 128, 128) TitleFont:[UIFont systemFontOfSize:13] BackgroundColor:[UIColor clearColor] title:@"忘记密码？点击找回密码" Enabled:YES cornerRadius:0];
        
        [_forgetPasswordButton addTarget:self action:@selector(forgetPasswordButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _forgetPasswordButton;
    
}

- (void)initButton:(UIButton *)button WithTitleColor:(UIColor *)titleColor TitleFont:(UIFont *)font BackgroundColor:(UIColor *)backgroundColor title:(NSString *)title Enabled:(BOOL)isEnabled cornerRadius:(CGFloat)radius
{
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:title];
    if (title.length > 5) {
        [AttributedStr addAttribute:NSForegroundColorAttributeName
                              value:HMColor(111, 111, 111)
                              range:NSMakeRange(0, AttributedStr.length-4)];
        
        [AttributedStr addAttribute:NSForegroundColorAttributeName
                              value:HMColor(247, 69, 69)
                              range:NSMakeRange(AttributedStr.length-4, 4)];
    }else{
        [AttributedStr addAttribute:NSForegroundColorAttributeName
                              value:titleColor
                              range:NSMakeRange(0, AttributedStr.length)];
        
    }
    
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.titleLabel.font = font;
    [button setBackgroundColor:backgroundColor];
    [button setAttributedTitle:AttributedStr forState:UIControlStateNormal];
    button.enabled = isEnabled;
    button.layer.cornerRadius = radius;
}


- (void)TextFieldDidBeginChange:(BYMBaseTextField *)textField
{
    [UIView animateWithDuration:0.5 animations:^{
        self.bigBackView.y = -KScreen_Width/2.0;
        self.imageView.alpha = 0;
    }];
    if (textField.tag == 11) {
        _phoneView.backgroundColor = HMColor(247, 69, 69);
    }else{
        _passwordView.backgroundColor = HMColor(247, 69, 69);
    }
}

#pragma mark - MyTextField delegate
- (BOOL)textField:(BYMBaseTextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.tag == 11) {
        int count = 11;
        NSMutableString *newtxt = [NSMutableString stringWithString:textField.text];
        [newtxt replaceCharactersInRange:range withString:string];
        return ([newtxt length] <= count);
    } else {
        
        int count = 16;
        
        NSMutableString *newtxt = [NSMutableString stringWithString:textField.text];
        [newtxt replaceCharactersInRange:range withString:string];
        return ([newtxt length] <= count);
        
    }
}

- (void)textFieldDidEndEditing:(BYMBaseTextField *)textField
{
    [self passwordTextFieldDidChange:textField];
    
    if (textField.tag == 10) {
        
        _passwordView.backgroundColor = HMColor(229, 229, 229);
    }else{
        _phoneView.backgroundColor = HMColor(229, 229, 229);
    }
    
    if (textField.tag == 11) {
        if (_phoneNumTextfield.text.length == 0) {
            
//            [self showHUD:@"请输入手机号码"];
//            [self hideHUD:@"请输入手机号码"];
            return;
            
        }  else if (![_phoneNumTextfield.text isValidateMobile:_phoneNumTextfield.text]) {
            
//            [self showHUD:@"手机号码输入有误"];
//            [self hideHUD:@"手机号码输入有误"];
            return;
        }
    }
}


//监听密码以保证button
- (void)passwordTextFieldDidChange:(BYMBaseTextField *)textField
{
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:@"立即登录"];
    
    if (_phoneNumTextfield.text.length == 0 || _passwordTextField.text.length== 0) {
        _loginButton.enabled = NO;
        [_loginButton setBackgroundColor:buttonColor1];
        [AttributedStr addAttribute:NSForegroundColorAttributeName
                              value:buttonFontColor1
                              range:NSMakeRange(0, AttributedStr.length)];
        
    }else{
        _loginButton.enabled = YES;
        [_loginButton setBackgroundColor:buttonColor2];
        [AttributedStr addAttribute:NSForegroundColorAttributeName
                              value:[UIColor whiteColor]
                              range:NSMakeRange(0, AttributedStr.length)];
        
    }
    [_loginButton setAttributedTitle:AttributedStr forState:UIControlStateNormal];
}


#pragma mark - 返回按钮 & 监听键盘退出
- (void)backItemAction:(UIButton *)backButton
{
    [_passwordTextField resignFirstResponder];
    [_phoneNumTextfield resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)closeKeyBoard:(UITapGestureRecognizer *)tap
{
    [_passwordTextField resignFirstResponder];
    [_phoneNumTextfield resignFirstResponder];
    [UIView animateWithDuration:0.5 animations:^{
        self.bigBackView.y = 0;
        self.imageView.alpha = 1;
        
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - 注册右侧导航按钮
- (void)_initNacvgationWithItem
{
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 40, 16);
    [rightButton setTitle:@"注册" forState:UIControlStateNormal];
    rightButton.backgroundColor = [UIColor clearColor];
    [rightButton setTitleColor:HMColor(51, 51, 51) forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [rightButton addTarget:self action:@selector(registerButton:)
          forControlEvents:UIControlEventTouchUpInside];
    rightButton.backgroundColor = [UIColor clearColor];
    
    UIBarButtonItem *menuButton = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = menuButton;
    
}

- (void)registerButton:(UIButton *)registerButton
{
    RegistViewController *registerVC = [[RegistViewController alloc] init];
    if(_i > 0){
        [registerVC countStart:_i];
    }
    _passwordTextField.text = nil;
    [self.navigationController pushViewController:registerVC animated:YES];
}

#pragma mark - 登陆
- (void)loginButtonAction:(UIButton *)loginButtonAction
{
    if (_phoneNumTextfield.text.length == 0 || _passwordTextField.text.length == 0) {
        return;
        
    } else if (![_phoneNumTextfield.text isValidateMobile:_phoneNumTextfield.text]) {
//        [self showHUD:@"手机号码输入有误"];
//        [self hideHUD:@"手机号码输入有误"];
        return;
        
    } else {
//        [self showHUD:@"登录中..."];
        NSString *adId =[[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
        NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
        NSString * str = [NSString stringWithFormat:@"{\"phoneId\":\"%@\",\"password\":\"%@\",\"username\":\"%@\"}",adId,_passwordTextField.text,_phoneNumTextfield.text];
        [dic setObject:str forKey:@"parameters"];
        [BYMBaseRequest requestWithURL:@"login" params:dic httpMethod:@"POST" blockSuccess:^(id result) {
//            [self hideHUD:@"登录成功"];
            [_passwordTextField resignFirstResponder];
            [_phoneNumTextfield resignFirstResponder];
            _loginButton.enabled = YES;
            NSDictionary * dic = (NSDictionary *)result;
            NSDictionary *objDic = [dic objectForKey:@"obj"];
            NSString *levelDic = [objDic objectForKey:@"level"];
            [BYM_UserDefulats setObject:levelDic forKey:@"resultLevel"];            //计数器用到vip加息
            [BYM_UserDefulats setObject:dic forKey:@"userDefulats"];
            [BYM_UserDefulats setObject:_phoneNumTextfield.text forKey:@"saveName"];//保存账号
            [BYM_UserDefulats synchronize];
            
            //要保存用户信息后才能发通知更新《我也不知道在哪里用到了》
            [[NSNotificationCenter defaultCenter] postNotificationName:@"LoadData" object:self userInfo:nil];
            if (self.myReloadDataBlock) {                                       //刷新数据时用到
                self.myReloadDataBlock(dic);
            }
            [self performSelector:@selector(viewCtrolPresentVC:) withObject:dic afterDelay:1];

        } blockFailure:^(id result) {
            
        }];
    }
}

- (void)viewCtrolPresentVC:(NSDictionary *)dic
{
    if (self.isFrameDuiHuanCommitVC == YES) {
        [self.delegate senddic:dic];
    }
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 忘记密码->push
- (void)forgetPasswordButtonAction:(UIButton *)forgetPasswordButtonAction
{
    // phoneId为IMEI码;username是需要找回密码的账号;type是类型1为注册，2为找回登录密码, 3找回交易密码
    ForgetLoginViewController *forgetVC = [[ForgetLoginViewController alloc] init];
    _passwordTextField.text = nil;
    [self.navigationController pushViewController:forgetVC animated:YES];
}

#pragma mark - 接收注册页面的定时数字
- (void)saveTheCount:(NSNotification *)notification
{
    NSString *str =  notification.object;
    _i = [str floatValue];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [TalkingData trackPageBegin:@"登录界面"];
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBarHidden = NO;
    
    _textName = [BYM_UserDefulats objectForKey:@"saveName"];
    _phoneNumTextfield.text = _textName;
    if ([self.isChangeUser isEqualToString:@"1"]) {
        _phoneNumTextfield.text = nil;
    }
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [TalkingData trackPageEnd:@"登录界面"];
}

@end
