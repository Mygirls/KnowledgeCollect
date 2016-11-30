//
//  InviteViewController.m
//  BYMFinancing
//
//  Created by Administrator on 2016/11/4.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "InviteViewController.h"
#import "LogInViewController.h"

@interface InviteViewController ()

@property(nonatomic,strong)UIButton *shareDetailButton;
@property(nonatomic,strong)UIButton *bottomButton;
@property(nonatomic,assign)NSString *inviteId;
@property(nonatomic,assign)BOOL *isLogIn;
@property(nonatomic,assign)NSDictionary *result;
@property(nonatomic,strong)UIWebView *webView;
@property(nonatomic,strong)UIVisualEffectView *effectview;
@property(nonatomic,strong)UIView *viewEffect;
@property(nonatomic,strong)NSMutableArray *contentArray;
@property(nonatomic,copy)NSString *userName;
@property(nonatomic,copy)NSString *shareURL;
@property(nonatomic,strong)UIView *bgView;

@end

@implementation InviteViewController
/**
 *  邀请好友页面：加载一个webView  在webView 上面添加一个 红包明细(只有要求好友的时候才可以查看到)
 *  此页面同时可以通过不同途径去分享 邀请好友等功能
 *  奖励弹框没弹出来之前不能点击返回按钮
 *
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
   
    [super _initViewBackItem];
    [self.view addSubview:self.bottomButton];
    [self.view addSubview:self.webView];
    [self.view addSubview:self.shareDetailButton];
    [self judgeIsLogin];
}
- (UIWebView *)webView
{
    if (!_webView) {
        
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64-45)];
        NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:self.webURLstring]];
        [(UIScrollView*)[_webView.subviews objectAtIndex:0] setShowsHorizontalScrollIndicator:NO];
        [(UIScrollView*)[_webView.subviews objectAtIndex:0] setShowsVerticalScrollIndicator:NO];
        [_webView loadRequest:request];
        
    }
    return _webView;
}
- (UIButton *)shareDetailButton
{
    if (!_shareDetailButton) {
        _shareDetailButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _shareDetailButton.frame = CGRectMake(KScreen_Width - 10-70, 18+64, 70, 13);
        [_shareDetailButton setTitle:@"查看明细>>" forState:UIControlStateNormal];
        [_shareDetailButton setTitleColor:HMColor(51, 51, 51) forState:UIControlStateNormal];
        _shareDetailButton.titleLabel.font = [UIFont systemFontOfSize:13];
        _shareDetailButton.hidden = YES;
        [_shareDetailButton addTarget:self action:@selector(checDetailJLBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareDetailButton;
    
}

- (UIButton *)bottomButton
{
    if (!_bottomButton) {
        _bottomButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _bottomButton.frame = CGRectMake(0, KScreen_Height - 45, KScreen_Width, 50);
        [_bottomButton setBackgroundColor:HMColor(254, 219, 91)];
        [_bottomButton setImage:[UIImage imageNamed:@"shareBtn.png"] forState:UIControlStateNormal];
        [_bottomButton setImage:[UIImage imageNamed:@"shareBtn.png"] forState:UIControlStateSelected];
        [_bottomButton addTarget:self action:@selector(shareItemAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomButton;
}
/**
 *  查看明细
 */
- (void)checDetailJLBtn:(UIButton *)btn
{
//    HBDetailViewController *hb = [[HBDetailViewController alloc] init];
//    hb.userName = self.userName;
//    [self.navigationController pushViewController:hb animated:YES];
    
}
- (void)shareDetailButtonClick:(UIButton *)btn
{
    [self.bgView removeFromSuperview];
    [self checDetailJLBtn:btn];
}
-(NSMutableArray *)contentArray
{
    if (!_contentArray) {
        _contentArray = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < 4 ; i ++) {
            CGFloat width = 71;
            CGFloat height = 94;
            UIButton *upButton = [UIButton buttonWithType:UIButtonTypeCustom];
            upButton.frame = CGRectMake((KScreen_Width-143)/3.0+(i % 2) * (width+(KScreen_Width-143)/3.0) ,KScreen_Height +(i / 2)*(height+30), 71, 94);
            NSString *imgName = [NSString stringWithFormat:@"icon_%ld",i + 1];
            [upButton setBackgroundImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
            upButton.tag = i;
            [upButton addTarget:self action:@selector(inviteButtonImgClick:) forControlEvents:UIControlEventTouchUpInside];
            [_contentArray addObject:upButton];
        }
        
    }
    return _contentArray;
}
- (void)inviteButtonImgClick:(UIButton *)btn
{
    
}
- (void)shareItemAction
{
    NSDictionary *result = [BYM_UserDefulats objectForKey:@"userDefulats"];
    if ([[result objectForKey:@"end"] isEqualToString:@"noLogin"] || result == NULL) {//未登录
        LogInViewController *loginVC = [[LogInViewController alloc] init];
        loginVC.myReloadDataBlock = ^(NSDictionary *dic){
            self.userName = [[dic objectForKey:@"obj"] objectForKey:@"username"];
            [self getDataOfHB:_userName];
        };
        UINavigationController *nav =[[UINavigationController alloc] initWithRootViewController:loginVC];
        [self presentViewController:nav animated:YES completion:nil];
    }else {
        
        if (IOS_VERSION_8_OR_ABOVE) {
            [[[UIApplication sharedApplication].delegate window]  addSubview:self.effectview];
            [self.contentArray enumerateObjectsUsingBlock:^(id obj,NSUInteger idx,BOOL*stop) {
                
                UIButton* btn = obj;
                btn.alpha=0.0;
                [_effectview.contentView addSubview:btn];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(idx *0.03*NSEC_PER_SEC)),dispatch_get_main_queue(), ^{
                    
                    [UIView animateWithDuration:1.0 delay:0 usingSpringWithDamping:1.0 initialSpringVelocity:15 options:UIViewAnimationOptionCurveEaseIn animations:^{
                        
                        btn.alpha=1;
                        btn.frame=CGRectMake(btn.x, btn.y-KScreen_Height/2.0-btn.width-15, 71, 94);
                        
                    } completion:^(BOOL finished) {
                        
                    }];
                    
                });
            }];
            
        }else{
            
            [[[UIApplication sharedApplication].delegate window]  addSubview:self.viewEffect];
            [self.contentArray enumerateObjectsUsingBlock:^(id obj,NSUInteger idx,BOOL*stop) {
                UIButton* btn = obj;
                btn.alpha=0.0;
                [_viewEffect addSubview:btn];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(idx *0.03*NSEC_PER_SEC)),dispatch_get_main_queue(), ^{
                    
                    [UIView animateWithDuration:1.0 delay:0 usingSpringWithDamping:1.0 initialSpringVelocity:15 options:UIViewAnimationOptionCurveEaseIn animations:^{
                        
                        btn.alpha=1;
                        btn.frame=CGRectMake(btn.x, btn.y-KScreen_Height/2.0-btn.width-15, 71, 94);
                        
                    } completion:^(BOOL finished) {
                        
                    }];
                });
            }];
        }
    }
}

- (UIVisualEffectView *)effectview
{
    if (!_effectview) {
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
        _effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
        _effectview.frame = CGRectMake(0, 0, KScreen_Width, KScreen_Height);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(effectviewClick)];
        [_effectview addGestureRecognizer:tap];
    }
    return _effectview;
    
}

- (UIView *)viewEffect
{
    if (!_viewEffect) {
        _viewEffect = [UIView new];
        _viewEffect.backgroundColor = [UIColor whiteColor];
        _viewEffect.alpha = 0.8;
        _viewEffect.frame = CGRectMake(0, 0, KScreen_Width, KScreen_Height);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(effectviewClick)];
        [_viewEffect addGestureRecognizer:tap];
    }
    return _viewEffect;
    
}
- (void)effectviewClick
{
    if (IOS_VERSION_8_OR_ABOVE) {
        self.effectview.alpha = 1.0;
        [UIView animateWithDuration:0.5 animations:^{
            self.effectview.alpha = 0.0;
        } completion:^(BOOL finished) {
            [self.effectview removeFromSuperview];
            self.effectview = nil;
            self.contentArray = nil;
            
        }];
    }else{
        self.viewEffect.alpha = 0.8;
        [UIView animateWithDuration:0.5 animations:^{
            self.viewEffect.alpha = 0.0;
        } completion:^(BOOL finished) {
            [self.viewEffect removeFromSuperview];
            self.viewEffect = nil;
            self.contentArray = nil;
            
        }];
        
    }
}
#pragma mark - 网络请求
- (void)judgeIsLogin
{
    NSDictionary *result = [BYM_UserDefulats objectForKey:@"userDefulats"];
    if ([[result objectForKey:@"end"] isEqualToString:@"noLogin"] || result == NULL) {//未登录
        
        
    }else {
        self.inviteId = [result objectForKey:@"inviteId"];
        self.userName = [[result objectForKey:@"obj"] objectForKey:@"username"];
        [self getDataOfHB:self.userName];
    }
}
- (void)getDataOfHB:(NSString *)username
{
    NSString *authorization = [[[BYM_UserDefulats objectForKey:@"userDefulats"] objectForKey:@"obj"] objectForKey:@"authorization"];
    NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
    
    NSString *str = [NSString stringWithFormat:  @"{\"authorization\":\"%@\",\"username\":\"%@\"}",authorization,username];
    [dic setObject:str forKey:@"parameters"];
    
    [BYMBaseRequest requestWithURL:@"User/isInviteFriends" params:dic httpMethod:@"POST" blockSuccess:^(id result) {
        if ([result isKindOfClass:[NSError class]]) {
            
            self.shareDetailButton.hidden = YES;
            
        } else if ([[result objectForKey:@"end"] isEqualToString:@"ok"]) {
            self.shareDetailButton.hidden = NO;
            NSDictionary *dic = [result objectForKey:@"list"];
            self.shareURL = [result objectForKey:@"url"];
            [self popAlertview:dic];
            
        } else  if([[result objectForKey:@"end"] isEqualToString:@"noData"]){
            self.shareDetailButton.hidden = YES;
            self.shareURL = [result objectForKey:@"url"];
            
        }else{
            self.shareDetailButton.hidden = YES;
            
        }

    } blockFailure:^(id result) {
        
    }];
}
#pragma mark - 弹框
- (void)popAlertview:(NSDictionary *)dic
{
    //底图
    self.bgView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.bgView];
    //背景图
    UIView *smallView = [[UIView alloc] initWithFrame:self.bgView.bounds];
    [smallView setBackgroundColor:[UIColor blackColor]];
    [smallView setAlpha:0.8];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeAlertView)];
    [smallView addGestureRecognizer:tap];
    [self.bgView addSubview:smallView];
    
    [self initInviteView:dic];
    
}

/**
 *邀请好友成功--弹窗
 */
- (void)initInviteView:(NSDictionary *)dic
{
    NSString *num = [NSString stringWithFormat:@"%@",[dic objectForKey:@"inviteNumber"]];
    NSString *message = [NSString stringWithFormat:@"%.2f",[[dic objectForKey:@"inMoney"] doubleValue]];
    
    UIView *xiview = [[UIView alloc] initWithFrame:CGRectMake(KScreen_Width/2.0, 64, 1, 200)];
    xiview.backgroundColor = HMColor(225, 24, 52);
    [self.bgView addSubview:xiview];
    
    UIView *dropView = [[UIView alloc] initWithFrame:CGRectMake((KScreen_Width-204)/2.0, 0, 204, 256)];
    dropView.layer.cornerRadius = 5;
    dropView.backgroundColor = HMColor(225, 24, 52);
    [self.bgView addSubview:dropView];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake((204-135)/2.0, 10, 135, 113)];
    imgView.image = [UIImage imageNamed:@"1_3_2hb3"];
    [dropView addSubview:imgView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 135, 204, 45)];
    label.text = [NSString stringWithFormat:@"已成功邀请%@位好友\n获%@元红包奖励",num,message];
    label.numberOfLines = 2;
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    [dropView addSubview:label];
    
    
    UIButton *detail = [[UIButton alloc] initWithFrame:CGRectMake((204-170)/2.0, 256-36-23, 170, 36)];
    [detail setBackgroundImage:[UIImage imageNamed:@"1_3_2icon3"] forState:UIControlStateNormal];
    [detail setBackgroundImage:[UIImage imageNamed:@"1_3_2icon_down3"] forState:UIControlStateHighlighted];
    detail.titleEdgeInsets = UIEdgeInsetsMake(-5, 0, 0, 0);
    [detail setTitle:@"查看明细" forState:UIControlStateNormal];
    [detail setTitleColor:HMColor(51, 51, 51) forState:UIControlStateNormal];
    detail.titleLabel.font = [UIFont systemFontOfSize:15];
    [detail addTarget:self action:@selector(shareDetailButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [dropView addSubview:detail];
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        dropView.y = 156;
    } completion:nil];
}
- (void)removeAlertView
{
    [self.bgView removeFromSuperview];
}

- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)backItemAction:(UIButton *)backButton
{
    [self.navigationController popViewControllerAnimated:YES];
}



@end
