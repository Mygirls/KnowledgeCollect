//
//  FindTrendPassWordController.m
//  BYMFinancing
//
//  Created by Administrator on 2016/11/8.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "FindTrendPassWordController.h"
#import "LogInViewController.h"

@interface FindTrendPassWordController ()<UITextFieldDelegate>

@property (nonatomic, strong) BYMBaseTextField *firstPassWord;
@property (nonatomic, strong) BYMBaseTextField *againPassWord;
@property (nonatomic, strong) UIButton *finishButton;

//@property(nonatomic,strong)NSString *idcardno;
//@property(nonatomic,strong)NSString *name;
//@property(nonatomic,strong)NSString *cardno;
//@property(nonatomic,strong)NSString *phone;
//@property(nonatomic,strong)NSString *userip;
//@property(nonatomic,strong)NSString *type;
//@property(nonatomic,strong)NSString *requestid;
//@property(nonatomic,strong)NSString *validatecode;

@end

@implementation FindTrendPassWordController

- (void)viewDidLoad {
    [super viewDidLoad];
    [super _initViewBackItem];
    
    self.title = @"设置交易密码";
    self.view.backgroundColor = HMColor(240, 244, 245);
    
   
    [self addAllChildViews];                        //初始化视图
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeAuthKeyboard:)];
    [self.view addGestureRecognizer:tap];
}

- (void)closeAuthKeyboard:(UITapGestureRecognizer *)closeAuthKeyboard
{
    [_firstPassWord resignFirstResponder];
    [ _againPassWord resignFirstResponder];
    
}

- (void)addAllChildViews
{
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 70, 100, 15)];
    titleLabel.text = @"交易密码";
    titleLabel.textColor = [UIColor grayColor];
    titleLabel.font = BYM_LabelFont(13);
    [self.view addSubview:titleLabel];
    
    UIView *firstView = [[UIView alloc]initWithFrame:CGRectMake(0, titleLabel.bottom+3, KScreen_Width, 45)];
    firstView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:firstView];
    UILabel *firstLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 15, 100, 15)];
    firstLabel.text = @"交易密码";
    firstLabel.font = BYM_LabelFont(15);
    [firstView addSubview:firstLabel];
    _firstPassWord = [[BYMBaseTextField alloc]initWithFrame:CGRectMake(firstLabel.right+5, 8, KScreen_Width-130, 30)];
    _firstPassWord.keyboardType = UIKeyboardTypeNumberPad;
    _firstPassWord.clearButtonMode = UITextFieldViewModeWhileEditing;
    _firstPassWord.secureTextEntry = YES;
    _firstPassWord.font = BYM_LabelFont(15);
    _firstPassWord.delegate = self;
    _firstPassWord.placeholder = @"请输入6位数密码";
    [_firstPassWord setValue:HMColor(204, 204, 204) forKeyPath:@"_placeholderLabel.textColor"];
    [firstView addSubview:_firstPassWord];
    
    UIView *againView = [[UIView alloc]initWithFrame:CGRectMake(0, firstView.bottom+1, KScreen_Width, 45)];
    againView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:againView];
    
    UILabel *againLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 15, 100, 15)];
    againLabel.text = @"确认交易密码";
    againLabel.font = BYM_LabelFont(15);
    [againView addSubview:againLabel];
    
    _againPassWord = [[BYMBaseTextField alloc]initWithFrame:CGRectMake(againLabel.right+5, 8, KScreen_Width-130, 30)];
    _againPassWord.keyboardType = UIKeyboardTypeNumberPad;
    _againPassWord.clearButtonMode = UITextFieldViewModeWhileEditing;
    _againPassWord.secureTextEntry = YES;
    _againPassWord.font = BYM_LabelFont(15);
    _againPassWord.placeholder = @"请再次输入6位数密码";
    _againPassWord.delegate = self;
    [_againPassWord setValue:HMColor(204, 204, 204) forKeyPath:@"_placeholderLabel.textColor"];
    //监听手机号码
    [_againPassWord addTarget:self action:@selector(findTrendPWDTextFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    [againView addSubview:_againPassWord];
    
    _finishButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _finishButton.frame = CGRectMake(20, againView.bottom +45, KScreen_Width-40, 45);
    _finishButton.backgroundColor = HMColor(221, 222, 223);
    _finishButton.enabled = NO;
    [_finishButton setTitle:@"完成" forState:UIControlStateNormal];
    [_finishButton setTitleColor:[UIColor whiteColor]  forState:UIControlStateNormal];
    _finishButton.layer.cornerRadius = 2.5;
    [_finishButton addTarget:self action:@selector(finishButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_finishButton];
    
    
    [self creatBottomView ];
    
}

- (void)creatBottomView
{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(15, 300, 280, 50)];
    backView.layer.cornerRadius = 5;
    [self.view addSubview:backView];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10,8, 10 , 10)];
    imgView.image = [UIImage imageNamed:@"wxts"];
    [backView addSubview:imgView];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(22, 5, 100, 15)];
    label1.font = BYM_LabelFont(12);
    label1.textColor = [UIColor grayColor];
    label1.text = @"温馨提示:";
    [backView addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(22, 20, 250, 90)];
    label2.font = BYM_LabelFont(11);
    label2.numberOfLines = 0;
    label2.text = @"1.交易密码为您在佰亿猫的支付密码,并非银行卡密码,佰亿猫不会使用任何方式向您索要银行卡密码;\n2.为保障您的资金安全,建议不要使用银行卡密码作为平台交易密码.";
    label2.textColor = [UIColor grayColor];
    [backView addSubview:label2];
}

- (void)findTrendPWDTextFieldDidChange
{
    if (_firstPassWord.text.length == 0 || _againPassWord.text.length== 0) {
        _finishButton.enabled = NO;
        _finishButton.backgroundColor = HMColor(221, 222, 223);
    }else{
        _finishButton.enabled = YES;
        _finishButton.backgroundColor = [UIColor colorWithRed:247/ 255.0 green:69/ 255.0 blue:69/255.0 alpha:1];
    }
}

- (void)finishButtonClick
{
    if (_firstPassWord.text.length == 0 || _againPassWord.text.length == 0) {
        
//        [self showHUD:@"密码不能为空"];
//        [self hideHUD:@"密码不能为空"];
        return;
    } else if (![_firstPassWord.text isEqualToString:_againPassWord.text]) {
        
//        [self showHUD:@"密码不一致，请再次输入"];
//        [self hideHUD:@"密码不一致，请再次输入"];
        return;
    } else if (_firstPassWord.text.length < 6 || _againPassWord.text.length < 6){
        
//        [self showHUD:@"密码长度为6位"];
//        [self hideHUD:@"密码长度为6位"];
        return;
    }
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];//phoneId
    NSDictionary *dic = [BYM_UserDefulats objectForKey:@"userDefulats"];
    NSString *authorization = [[dic objectForKey:@"obj"] objectForKey:@"authorization"];
    self.userName = [[dic objectForKey:@"obj"] objectForKey:@"username"];
    //    NSString *phoneID =[[[UIDevice currentDevice] identifierForVendor] UUIDString];//registPlatform
    //    NSString *adId =[[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
    if (self.isFindPWD == YES) {
        //实名认证设置交易密码
        //        NSString * str = [NSString stringWithFormat:@"{\"authorization\":\"%@\",\"name\":\"%@\",\"idcardno\":\"%@\",\"cardno\":\"%@\",\"phone\":\"%@\",\"validatecode\":\"%@\",\"username\":\"%@\",\"type\":\"%@\",\"requestid\":\"%@\",\"password\":\"%@\",\"pwd\":\"%@\",\"userip\":\"%@\"}",authorization,self.name,self.idcardno,self.cardno,self.phone,self.validatecode,self.userName,self.type,self.requestid,_firstPassWord.text,_againPassWord.text,self.userip];
        NSString * str = [NSString stringWithFormat:@"{\"authorization\":\"%@\",\"username\":\"%@\",\"password\":\"%@\",\"pwd\":\"%@\"}",authorization,self.userName,_firstPassWord.text,_againPassWord.text];
        
        //        [self showHUD:@"正在认证"];
        NSLog(@"%@",str);
        [dict setObject:str forKey:@"parameters"];
        [BYMBaseRequest requestWithURL:@"User/updatePayPwd" params:dict httpMethod:@"POST" blockSuccess:^(id result) {
            // 获取验证码成功
            if ([result isKindOfClass:[NSError class]]) {
//                [self showHUD:@"网络或服务器异常"];
//                [self hideHUD:@"网络或服务器异常"];
                
            }else  if ([[result objectForKey:@"end"] isEqualToString:@"ok"]) {
                //                [self showHUD:@"设置交易密码成功"];
                //                [self hideHUD:@"设置交易密码成功"];
                
                [self performSelector:@selector(sucessChangeTrendPassword) withObject:nil afterDelay:1.0];
            } else if ([[result objectForKey:@"end"] isEqualToString:@"noLogin"]) {
                //                [self showHUD:[result objectForKey:@"message"]];
                //                [self hideHUD:[result objectForKey:@"message"]];
                
                LogInViewController *loginVC = [[LogInViewController alloc]init];
                //                [self.navigationController pushViewController:loginVC animated:YES];
                UINavigationController *nav =[[UINavigationController alloc] initWithRootViewController:loginVC];
                [self presentViewController:nav animated:YES completion:nil];
                
                
            } else if ([[result objectForKey:@"end"] isEqualToString:@"error_code"]) {
                //                [self showHUD:[[result objectForKey:@"obj"] objectForKey:@"message"]];
                //                [self hideHUD:[[result objectForKey:@"obj"] objectForKey:@"message"]];
                
            }else if ([[result objectForKey:@"end"] isEqualToString:@"error"]) {
                //                [self showHUD:[result objectForKey:@"message"]];
                //                [self hideHUD:[result objectForKey:@"message"]];
                
            }else {
                //                [self showHUD:[result objectForKey:@"message"]];
                //                [self hideHUD:[result objectForKey:@"message"]];
                
            }
            

        } blockFailure:^(id result) {
            
        }];
        
    } else {
        //找回交易密码
        //type 0为登录密码，1为交易密码
        NSString *adId =[[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
        NSString *str = [NSString stringWithFormat:
                         @"{\"password\":\"%@\",\"pwd\":\"%@\",\"username\":\"%@\",\"type\":\"%@\",\"phoneId\":\"%@\"}",_firstPassWord.text,_againPassWord.text,self.userName,@"1",adId];
        
        [params setObject:str forKey:@"parameters"];
        
        [BYMBaseRequest requestWithURL:@"findPwdUpdatePwd" params:params httpMethod:@"POST" blockSuccess:^(id result) {
            
            if ([result isKindOfClass:[NSError class]]) {
                //                [self showHUD:@"网络或服务器异常"];
                //                [self hideHUD:@"网络或服务器异常"];
                
            } else if ([[result objectForKey:@"end"] isEqualToString:@"ok"]) {
                
                //                [self showHUD:@"修改成功"];
                //                [self hideHUD:@"修改成功"];
                
                [self performSelector:@selector(sucessChangeTrendPassword) withObject:nil afterDelay:1.0];
                
                
            } else if ([[result objectForKey:@"end"] isEqualToString:@"error"]) {
                //                [self showHUD:[result objectForKey:@"message"]];
                //                [self hideHUD:[result objectForKey:@"message"]];
                
            } else if ([[result objectForKey:@"end"] isEqualToString:@"paramError"]) {
                
                //                [self showHUD:[result objectForKey:@"message"]];
                //                [self hideHUD:[result objectForKey:@"message"]];
                
            } else {
                
                //                [self showHUD:@"修改失败"];
                //                [self hideHUD:@"修改失败"];
            }
            

        } blockFailure:^(id result) {
            
        }];
    }
    
}


- (void)sucessChangeTrendPassword
{
    if (self.isFindPWD == YES){
        
        if (self.popMoneyBlock) {
            self.popMoneyBlock();
        }
        
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
    }
}


#pragma mark - UITextField delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    int count = 6;
    
    NSMutableString *newtxt = [NSMutableString stringWithString:textField.text];
    
    [newtxt replaceCharactersInRange:range withString:string];
    
    return ([newtxt length] <= count);
    
}
- (void)backItemAction:(UIButton *)backButton
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
