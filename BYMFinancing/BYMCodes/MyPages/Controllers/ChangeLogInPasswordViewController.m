//
//  ChangeLogInPasswordViewController.m
//  BYMFinancing
//
//  Created by Administrator on 2016/11/7.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ChangeLogInPasswordViewController.h"
#import "LogInViewController.h"

@interface ChangeLogInPasswordViewController ()<UITextFieldDelegate>


@property (nonatomic, strong) UIButton *confirmBtn;
@property (nonatomic, strong) BYMBaseTextField *oldPasswordTextField;
@property (nonatomic, strong) BYMBaseTextField *newpasswordTextField;
@property (nonatomic, strong) BYMBaseTextField *againPasswordTextField;
@end

@implementation ChangeLogInPasswordViewController
/**
 *  修改登录密码
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    [super _initViewBackItem];
    
    self.view.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreen_Width, 64)];
    topView.backgroundColor= [UIColor whiteColor];
    [self.view addSubview:topView];
    [self addAllChildViews];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeAuthKeyboard:)];
    [self.view addGestureRecognizer:tap];
}

- (void)closeAuthKeyboard:(UITapGestureRecognizer *)closeAuthKeyboard
{
    [_oldPasswordTextField resignFirstResponder];
    [_newpasswordTextField resignFirstResponder];
    [_againPasswordTextField resignFirstResponder];
}

- (void)addAllChildViews
{
     [self setUpViewFrame:CGRectMake(0, 80, KScreen_Width, 44) andTitleLabelStr:@"登录密码" andTextFieldPlaceholderName:@"请输入登录密码" andViewTag:1];
     [self setUpViewFrame:CGRectMake(0, 125, KScreen_Width, 44) andTitleLabelStr:@"新密码" andTextFieldPlaceholderName:@"请输入新密码" andViewTag:2];
     [self setUpViewFrame:CGRectMake(0, 170, KScreen_Width, 44) andTitleLabelStr:@"确定密码" andTextFieldPlaceholderName:@"请再次输入新密码" andViewTag:3];
    
    
    UIView *bgView1 = [(UIView *)self.view viewWithTag:1];
    UIView *bgView2 = [(UIView *)self.view viewWithTag:2];
    UIView *bgView3 = [(UIView *)self.view viewWithTag:3];
    
    _oldPasswordTextField = [(BYMBaseTextField *)bgView1 viewWithTag:10];
    _newpasswordTextField = [(BYMBaseTextField *)bgView2 viewWithTag:10];
    _againPasswordTextField = [(BYMBaseTextField *)bgView3 viewWithTag:10];
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirmBtn.frame = CGRectMake(20, 245, KScreen_Width-40, 45);
    _confirmBtn.titleLabel.font = BYM_LabelFont(15);
    _confirmBtn.backgroundColor = [UIColor colorWithRed:249/255.0 green:69/255.0 blue:69/255.0 alpha:1] ;
    [_confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
    [_confirmBtn setTitleColor:[UIColor whiteColor]  forState:UIControlStateNormal];
    _confirmBtn.layer.cornerRadius = 2.5;
    [_confirmBtn addTarget:self action:@selector(sureButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_confirmBtn];
    
}
- (void)sureButton
{
    if (_oldPasswordTextField.text.length == 0) {
//        [self showHUD:@"请输入原密码"];
//        [self hideHUD:@"请输入原密码"];
        return;
        
    }else if (_againPasswordTextField.text.length == 0 && _newpasswordTextField.text.length == 0)
    {
//        [self showHUD:@"请输入新密码"];
//        [self hideHUD:@"请输入新密码"];
        return;
    }else if (_againPasswordTextField.text.length == 0 || _newpasswordTextField.text.length == 0)
    {
//        [self showHUD:@"两次密码不一致"];
//        [self hideHUD:@"两次密码不一致"];
        return;
    }
    else if (![_againPasswordTextField.text isEqualToString:_newpasswordTextField.text]) {
//        [self showHUD:@"设置的新密码不一致"];
//        [self hideHUD:@"设置的新密码不一致"];
        return;
    }else if ([_newpasswordTextField.text isEqualToString:_oldPasswordTextField.text]) {
//        [self showHUD:@"新密码不能与旧密码一致"];
//        [self hideHUD:@"新密码不能与旧密码一致"];
        return;
        
    } else if (_againPasswordTextField.text.length  < 6 || _newpasswordTextField.text.length < 6){
        
//        [self showHUD:@"密码至少为6位"];
//        [self hideHUD:@"密码至少为6位"];
        return;
        
    } else if (![_againPasswordTextField.text passwordCheck:_againPasswordTextField.text]) {
//        [self showHUD:@"不能有特殊字符"];
//        [self hideHUD:@"不能有特殊字符"];
        return;
    }
    else {
        _confirmBtn.enabled = NO;
    }
    NSString *adId =[[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    //把登陆信息保存到本地，并返回刚才的页面
    NSUserDefaults *userDefulats = [NSUserDefaults standardUserDefaults];
    NSDictionary *dic =  [userDefulats objectForKey:@"userDefulats"];
    [userDefulats synchronize];
    NSDictionary *obj = [dic objectForKey:@"obj"];
    NSString *username = [obj objectForKey:@"username"];
    NSString *authorization = [obj objectForKey:@"authorization"];
    
    NSString *str = [NSString stringWithFormat:  @"{\"phoneId\":\"%@\",\"username\":\"%@\",\"authorization\":\"%@\",\"type\":\"%@\",\"oldpwd\":\"%@\",\"pwd\":\"%@\",\"password\":\"%@\"}",adId,username,authorization,@"0",_oldPasswordTextField.text,_newpasswordTextField.text,_againPasswordTextField.text];//phoneId
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    [params setObject:str forKey:@"parameters"];
    [BYMBaseRequest requestWithURL:@"User/updatePwd" params:params httpMethod:@"POST" blockSuccess:^(id result) {
        _confirmBtn.enabled = YES;
        
        if ([result isKindOfClass:[NSError class]]) {
            //            [self hideHUD:@"网络或服务器异常"];
            
        } else if ([[result  objectForKey:@"end"]isEqualToString:@"noLogin"]) {
            
            //            [self showHUD:@"未登录，请先登录"];
            //            [self hideHUD:@"未登录，请先登录"];
            LogInViewController *loginVC = [[LogInViewController alloc]init];
            UINavigationController *nav =[[UINavigationController alloc] initWithRootViewController:loginVC];
            [self presentViewController:nav animated:YES completion:nil];
            
        }else if ([[result objectForKey:@"end"]isEqualToString:@"ok"]) {
            //            [self showHUD:@"修改成功"];
            //            [self hideHUD:@"修改成功"];
            [self performSelector:@selector(delayTwoSecondeToLoginVC) withObject:nil afterDelay:1];
        }else if ([[result objectForKey:@"end"]isEqualToString:@"noData"]) {
            //            [self showHUD:@"无更多数据"];
            //            [self hideHUD:@"无更多数据"];
            
        }else if ([[result objectForKey:@"end"]isEqualToString:@"paramError"]) {
            //            [self showHUD:[result objectForKey:@"message"]];
            //            [self hideHUD:[result objectForKey:@"message"]];
            
        } else if([result isKindOfClass:[NSError class]]) {
            //            [self showHUD:@"网络或服务器异常"];
            //            [self hideHUD:@"网络或服务器异常"];
            //
        } else if([[result objectForKey:@"end"]isEqualToString:@"error"]) {
            //            [self showHUD:[result objectForKey:@"message"]];
            //            [self hideHUD:[result objectForKey:@"message"]];
            
        } else {
            //            [self showHUD:@"对不起，您现在不能修改密码"];
            //            [self hideHUD:@"对不起，您现在不能修改密码"];
        }

    } blockFailure:^(id result) {
        
    }];
}


- (void)setUpViewFrame:(CGRect )frame andTitleLabelStr:(NSString *)titleLabelText andTextFieldPlaceholderName:(NSString *)placeholderName  andViewTag:(NSInteger)tag
{
    UIView *bgView = [[UIView alloc]initWithFrame:frame];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.tag = tag;
    [self.view addSubview:bgView];
    
    UILabel *bgLabel= [[UILabel alloc]initWithFrame:CGRectMake(15, 14, 100, 15)];
    bgLabel.text = titleLabelText;
    bgLabel.font = BYM_LabelFont(15);
    [bgView addSubview:bgLabel];
    
    BYMBaseTextField *bgTextField = [[BYMBaseTextField alloc]initWithFrame:CGRectMake(bgLabel.right, 7, KScreen_Width-bgLabel.right-10, 30)];
    bgTextField.tag = 10;
    bgTextField.font = BYM_LabelFont(15);
    bgTextField.placeholder = placeholderName;
    bgTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [bgTextField setValue:HMColor(204, 204, 204) forKeyPath:@"_placeholderLabel.textColor"];
    bgTextField.textColor = HMColor(40, 41, 41);
    bgTextField.secureTextEntry = YES;
    bgTextField.delegate = self;
    [bgView addSubview:bgTextField];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSInteger count = 16;
    // 限制长度
    NSUInteger proposedNewLength = textField.text.length - range.length + string.length;
    if (proposedNewLength > count) return NO;//限制长度
    return YES;
}

- (void)delayTwoSecondeToLoginVC
{
    LogInViewController *loginVC = [[LogInViewController alloc]init];
    UINavigationController *nav =[[UINavigationController alloc] initWithRootViewController:loginVC];
    [self presentViewController:nav animated:YES completion:^{
        [self.navigationController popToRootViewControllerAnimated:NO];
    }];
}

- (void)backItemAction:(UIButton *)backButton
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
