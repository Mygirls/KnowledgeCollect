//
//  MyInvestViewController.m
//  BYMFinancing
//
//  Created by Administrator on 2016/11/1.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "MyInvestViewController.h"
#import "LogInViewController.h"
#import "MyGradeViewController.h"
#import "TransactionDetailViewController.h"
#import "PersonalCenterViewController.h"

#import "MyInvestHeadView.h"

@interface MyInvestViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) NSDictionary     *dataList;//数据
@property (nonatomic, copy  ) NSString         *fundRecordUrl;//资金流水url
@property (nonatomic, copy  ) NSString         *userNum;//带***
@property (nonatomic, copy  ) NSString         *isUnbind;
@property (nonatomic, strong) NSDictionary     *obj;
@property (nonatomic, strong) NSArray          *dataArray;
@property (nonatomic, strong) UIImageView      *levelImage;//等级图片
@property (nonatomic, strong) UIButton         *investRecordButton;//投资记录
@property (nonatomic, strong) UIImageView      *portraitImageView;//个人头像
@property (nonatomic, strong) UILabel          *phoneNumLabel;
@property (nonatomic, strong) UIView           *topWhiteView;
@property (nonatomic, strong) UIImageView      *baiImg;
@property (nonatomic, strong) MyInvestHeadView *assetInformationView;//headView
@property (nonatomic, strong) UIScrollView     *bgScrollView;//bgScrollView
@property (nonatomic, strong) UIView           *bgView;      //bgView
@property (nonatomic, assign) BOOL             isLogIn;
@end

@implementation MyInvestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreen_Width, 64)];
    topView.backgroundColor= [UIColor whiteColor];
    [self.view addSubview:topView];
    
    self.view.backgroundColor = HMColor(240, 244, 245);
    
    [self initNavBarItem];
    [self.view addSubview:self.bgScrollView];
    [self.bgScrollView addSubview:self.assetInformationView];
    [self setUpSectionView];
    [self.view addSubview:self.topWhiteView];
}

- (UIScrollView *)bgScrollView
{
    if (_bgScrollView == nil) {
        _bgScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, KScreen_Width, KScreen_Height - 64)];
        _bgScrollView.backgroundColor = [UIColor clearColor];
        _bgScrollView.contentSize = CGSizeMake(KScreen_Width, KScreen_Height);
        _bgScrollView.delegate = self;
        _bgScrollView.showsVerticalScrollIndicator = NO;
    }
    
    return _bgScrollView;
}

- (MyInvestHeadView *)assetInformationView
{
    if (_assetInformationView == nil) {
        _assetInformationView = [[MyInvestHeadView alloc]initWithFrame:CGRectMake(0, 0, KScreen_Width, 160)];
        _assetInformationView.backgroundColor = [UIColor whiteColor];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(assetInformationViewAction:)];
        [_assetInformationView addGestureRecognizer:tap];
    }
    return _assetInformationView;
}


- (void)assetInformationViewAction:(UITapGestureRecognizer *)tap
{
    [TalkingData trackEvent:@"我的" label:@"资产明细"];
    
    if (self.isLogIn == NO) {
        LogInViewController *loginVC = [[LogInViewController alloc] init];
        UINavigationController *nav =[[UINavigationController alloc] initWithRootViewController:loginVC];
        [self presentViewController:nav animated:YES completion:nil];
        return;
    }
//    PropertyDetailViewController *propertyDetailVC = [[PropertyDetailViewController alloc] init];
//    propertyDetailVC.dataList = self.dataList;
//    [self presentViewController:propertyDetailVC animated:YES completion:nil];
    
}
- (void)setUpSectionView
{
    _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, self.assetInformationView.bottom + 8, KScreen_Width, 45 * 8 + 3 * 8)];
    [self.bgScrollView addSubview:_bgView];
    [self setUpSubViewOfSuperViewFrame:CGRectMake(0, 0, KScreen_Width, 45) imageName:@"rechargephotts" titleLabelStr:@"我要充值" superViewTag:1 ];
    [self setUpSubViewOfSuperViewFrame:CGRectMake(0, 45, KScreen_Width, 45) imageName:@"withdrawphotts" titleLabelStr:@"我要提现" superViewTag:2];
    [self setUpSubViewOfSuperViewFrame:CGRectMake(0, 45 * 2 + 8, KScreen_Width, 45) imageName:@"myrank" titleLabelStr:@"我的等级" superViewTag:3];
    [self setUpSubViewOfSuperViewFrame:CGRectMake(0, 45 * 3 + 8 * 2, KScreen_Width, 45) imageName:@"redpacket" titleLabelStr:@"我的红包" superViewTag:4];
    [self setUpSubViewOfSuperViewFrame:CGRectMake(0, 45 * 4 + 8 * 2, KScreen_Width, 45) imageName:@"makeover" titleLabelStr:@"我的转让" superViewTag:5];
    [self setUpSubViewOfSuperViewFrame:CGRectMake(0, 45 * 5 + 8 * 2, KScreen_Width, 45) imageName:@"cardcoupons" titleLabelStr:@"我的卡券" superViewTag:6];
    [self setUpSubViewOfSuperViewFrame:CGRectMake(0, 45 * 6 + 8 * 3, KScreen_Width, 45) imageName:@"transactiondetail" titleLabelStr:@"交易明细" superViewTag:7];
    [self setUpSubViewOfSuperViewFrame:CGRectMake(0, 45 * 7 + 8 * 3, KScreen_Width, 45) imageName:@"personalzone" titleLabelStr:@"个人中心" superViewTag:8];
    
    CGFloat   bgHeight = _bgView.bottom+44;
    if (bgHeight>=KScreen_Height) {         /** 刷新滑动区域 */
        _bgScrollView.contentSize = CGSizeMake(KScreen_Width, bgHeight+20);
        
    }
}

- (void)setUpSubViewOfSuperViewFrame:(CGRect )frame imageName:(NSString *)imgName titleLabelStr:(NSString *)titleLabelText superViewTag:(NSInteger)tag
{
    UIView *superView = [[UIView alloc]initWithFrame:frame];
    superView.backgroundColor = [UIColor whiteColor];
    superView.tag = tag;
    [self.bgView addSubview:superView];
    
    UIImageView *imageView3 = [[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 20, 16, 8, 13)];//右边箭头
    imageView3.image = [UIImage imageNamed:@"tx_xy"];
    [superView addSubview:imageView3];
    if (tag == 1 || tag == 4 || tag == 5 || tag == 7) {// 分割线
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(10, 44.5, KScreen_Width-20, 0.5)];
        view.backgroundColor = HMColor(229, 229, 229);
        [superView addSubview:view];
    }
    
    UIImageView *leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 14, 14)];
    leftImageView.image = [UIImage imageNamed:imgName];
    [superView addSubview:leftImageView];//右边图标
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(32, 15, 100, 15)];
    titleLabel.text = titleLabelText;
    titleLabel.font = [UIFont fontWithName:@"STHeitiSC-Bold" size:15];
    titleLabel.textColor = HMColor(51, 51, 51);
    [superView addSubview:titleLabel];//文本
    
    UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(KScreen_Width-100-8-20, 17, 100, 12)];
    rightLabel.font = BYM_LabelFont(12);
    rightLabel.textColor = HMColor(253, 189, 78);
    rightLabel.textAlignment = NSTextAlignmentRight;
    rightLabel.hidden = YES;
    rightLabel.tag = 100;
    [superView addSubview:rightLabel];//右边文本
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapPushAction:)];
    [self.bgView addGestureRecognizer:tap];
    
}

#pragma mark - 点击事件
- (void)tapPushAction:(UITapGestureRecognizer * )tap
{
    if (self.isLogIn == NO) {
        LogInViewController *loginVC = [[LogInViewController alloc] init];
        UINavigationController *nav =[[UINavigationController alloc] initWithRootViewController:loginVC];
        [self presentViewController:nav animated:YES completion:nil];
        return;
    }
    CGPoint point = [tap locationInView:self.bgView];
    if (point.y <= 45   ) {//充值：充值成功即绑定银行卡
        [TalkingData trackEvent:@"我的" label:@"充值"];
//        RechargeViewController *rechargeVC = [[RechargeViewController alloc] init];
//        rechargeVC.dataList = self.dataList;
//        if ([self.dataList objectForKey:@"list"] == nil) {
//            [self wanchengshimingrenzheng];
//        } else {
//            [self.navigationController pushViewController:rechargeVC animated:YES];
//        }
//        
    }else if (point.y <= 45 * 2  ) {//提现
        [TalkingData trackEvent:@"我的" label:@"提现"];
        [self tixianAction];
        
    }else if (point.y >= 45 * 2 + 8  && point.y <= 45 * 3 + 8 ) {//我的等级
        [TalkingData trackEvent:@"我的" label:@"我的等级"];
        [self gradeBtnClick];
        
    }else if ( point.y >= 45 * 3 + 8 * 2  && point.y <= 45 * 4 + 8 * 2  ) {//我的红包
        [TalkingData trackEvent:@"我的" label:@"我的红包"];
//        MyRedPacketsViewController *redPackets = [[MyRedPacketsViewController alloc] init];
//        [self.navigationController pushViewController:redPackets animated:YES];
        
    }else if (point.y >= 45 * 4 + 8 * 2 && point.y <= 45 * 5 + 8 * 2  ) {//我的转让
        [TalkingData trackEvent:@"我的" label:@"我的转让"];
//        TransferViewController *transferVC = [[TransferViewController alloc]init];
//        [self.navigationController pushViewController:transferVC animated:YES];
        
    }else if (point.y >= 45 * 5 + 8 * 2 && point.y <= 45 * 6 + 8 * 2) {//我的卡券
        [TalkingData trackEvent:@"我的" label:@"我的卡券"];
//        InvestmentCodeViewController *investmentCodeVC = [[InvestmentCodeViewController alloc] init];
//        [self.navigationController pushViewController:investmentCodeVC animated:YES];
        
    }else if (point.y >= 45 * 6 + 8 * 3 && point.y <= 45 * 7 + 8 * 3 ) {//交易明细
        [TalkingData trackEvent:@"我的" label:@"交易明细"];
        
        TransactionDetailViewController *detailVC = [[TransactionDetailViewController alloc] init];
        [self.navigationController pushViewController:detailVC animated:YES];
        
    }else if (point.y >= 45 * 7 + 8 * 3 && point.y <= 45 * 8 + 8 * 3 ) {//个人中心
        [TalkingData trackEvent:@"我的" label:@"个人中心"];
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        if (appDelegate.status == 0) {
           
            return;
        }else {
            PersonalCenterViewController *myAccountVC = [[PersonalCenterViewController alloc] init];
            myAccountVC.dataList = self.dataList;
            myAccountVC.leftMoney = [NSString stringWithFormat:@"%.2f",[[NSString stringWithFormat:@"%@",[self.obj objectForKey:@"leftMoney"]] doubleValue] / 100];
            myAccountVC.userNum = self.userNum;
            myAccountVC.isUnbind = self.isUnbind;
            [self.navigationController pushViewController:myAccountVC animated:YES];
        }
    }
    
}

- (NSArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [@[@"0",@"0",@"0"] copy];
    }
    return _dataArray;

}

- (UIView *)topWhiteView
{
    if (!_topWhiteView) {
        _topWhiteView = [UIView new];
        _topWhiteView.backgroundColor = [UIColor whiteColor];
        [_topWhiteView addSubview:self.baiImg];
    }
    return _topWhiteView;
}

- (UIImageView *)baiImg
{
    if (!_baiImg) {
        _baiImg = [[UIImageView alloc] initWithFrame:CGRectMake((KScreen_Width-93)/2.0, -32, 93, 32)];
        _baiImg.image = [UIImage imageNamed:@"tzzq3"];
    }
    return _baiImg;
}

- (UILabel *)phoneNumLabel
{
    if (!_phoneNumLabel) {
        _phoneNumLabel = [UILabel new];
        _phoneNumLabel.font = BYM_LabelFont(13);
        _phoneNumLabel.size = CGSizeMake(85, 13);
    }
    return _phoneNumLabel;
}

- (UIImageView *)levelImage
{
    if (!_levelImage) {
        _levelImage = [UIImageView new];
        _levelImage.frame = CGRectMake(0, 0, 15, 15);
        UITapGestureRecognizer *levelImageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gradeBtnClick)];
        [_levelImage addGestureRecognizer:levelImageTap];
    }
    return _levelImage;
}

- (UIButton *)investRecordButton
{
    
    if (!_investRecordButton) {
        _investRecordButton = [UIButton new];
        _investRecordButton.frame = CGRectMake(0, 0, 60, 13);
        [_investRecordButton setTitle:@"投资记录" forState:UIControlStateNormal];
        _investRecordButton.titleLabel.textAlignment = NSTextAlignmentRight;
        [_investRecordButton setTitleColor:HMColor(69, 69, 69) forState:UIControlStateNormal];
        _investRecordButton.titleLabel.font = BYM_LabelFont(13);
        [_investRecordButton addTarget:self action:@selector(rightItemAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _investRecordButton;
}

- (void)wanchengshimingrenzheng
{
//    LLPayViewController *llVc = [[LLPayViewController alloc] init];
//    llVc.leftMoney = [NSString stringWithFormat:@"%.2f",[[NSString stringWithFormat:@"%@",[self.obj objectForKey:@"leftMoney"]] doubleValue] / 100];
//    [self.navigationController pushViewController:llVc animated:YES];
}

- (void)tixianAction
{
    NSDictionary *obj = [self.dataList objectForKey:@"obj"];
    //如果咩有绑定银行卡 去绑定
    if ([[obj objectForKey:@"isBindBank"] isEqualToString:@"1"] ) { //如果绑定银行卡
        
        NSString *payType = [obj objectForKey:@"payType"];
        if ([payType isEqualToString:@"1"]) {                       // 1 连连   0 易宝
            
            NSString *completeBankInfo = [obj objectForKey:@"completeBankInfo"];
            //判断有没有体现过
            if ([completeBankInfo isEqualToString:@"1"]) {          //有 跳转到体现页面
//                WithDrawCashViewController *drawVC = [[WithDrawCashViewController alloc] init];
//                drawVC.dataList = self.dataList;
//                [self.navigationController pushViewController:drawVC animated:YES];
            }else{                                                  //去设置体现页面
//                LLWithDrawCashViewController *LLVC = [[LLWithDrawCashViewController alloc] init];
//                LLVC.dataList = self.dataList;;
//                [self.navigationController pushViewController:LLVC animated:YES];
            }
        }else{                                                      // 易宝
//            WithDrawCashViewController *drawVC = [[WithDrawCashViewController alloc] init];
//            drawVC.dataList = self.dataList;
//            [self.navigationController pushViewController:drawVC animated:YES];
        }
    }else {                                                         //跳转到连连认证支付页面
//        [self showHUD:@"您尚未绑定银行卡，充值即可完成绑定"];
//        [self hideHUD:@"您尚未绑定银行卡，充值即可完成绑定"];
        [self performSelector:@selector(wanchengshimingrenzheng) withObject:nil afterDelay:2.0];
    }
}


#pragma mark - 网络 加载数据
- (void)_getData
{
    NSUserDefaults *userDefulats = [NSUserDefaults standardUserDefaults];
    NSDictionary *result = [userDefulats objectForKey:@"userDefulats"];
    NSDictionary *subDic = [result objectForKey:@"obj"];
    NSString *authorization = [subDic objectForKey:@"authorization"];
    NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
    NSString *str = [NSString stringWithFormat:  @"{\"authorization\":\"%@\"}",authorization];
    [dic setObject:str forKey:@"parameters"];
    [BYMBaseRequest requestWithURL:@"User/showMyAccount" params:dic httpMethod:@"POST" blockSuccess:^(id result) {
        if ([result isKindOfClass:[NSError class]]) {
            [self noLoginButton];
            
        } else if ([[result objectForKey:@"end"] isEqualToString:@"ok"]) {
            self.isLogIn = YES;
            self.dataList = result;
            NSDictionary *objDic = [result  objectForKey:@"obj"];//123
            NSString *levelDic = [objDic objectForKey:@"level"];
            [BYM_UserDefulats setObject:levelDic forKey:@"resultLevel"];//计数器用到vip加息
            [BYM_UserDefulats synchronize];
            self.obj = [self.dataList objectForKey:@"obj"];
            self.assetInformationView.isLogin = YES;
            self.assetInformationView.dataDic = self.obj;
            NSString *username = [subDic objectForKey:@"username"];
            [self hadLogIn:self.obj userName:username];
            [self loadUserData]; /** 显示数据 */
            
        } else if ([[result objectForKey:@"end"] isEqualToString:@"noLogin"]) {
            
            self.obj = nil;
            self.isLogIn = NO;
            self.assetInformationView.isLogin = NO;
            [BYM_UserDefulats removeObjectForKey:@"userDefulats"];
            [BYM_UserDefulats removeObjectForKey:@"resultLevel"];//移除vip加息
            [BYM_UserDefulats synchronize];
            [self noLoginButton];
        } else {
            [self noLoginButton];
        }
        [self refreshRightLabelData];//刷新右边的数据

    } blockFailure:^(id result) {
    
    }];
    
}
- (void)loadUserData{
    
    self.isUnbind = [self.obj objectForKey:@"isUnbind"];
    NSString *kqstr = [NSString stringWithFormat:@"%ld",[[self.obj objectForKey:@"couponcount"] integerValue] +[[self.obj objectForKey:@"interestCouponcount"] integerValue]];
    NSString *redPacket = [NSString stringWithFormat:@"%ld",[[self.obj objectForKey:@"cashCouponcount"] integerValue]];//红包
   
    self.dataArray = @[
                              redPacket,
                              [self.obj objectForKey:@"isExitTransProduct"],
                              kqstr
                              ];
    
    self.fundRecordUrl = [self.obj objectForKey:@"fundRecordUrl"];
    
    [self showLevelImage];
    
    //【3.3新增】vipBorthdayReward:xx投资券(奖励提示  totalInvestMoney:总投资额
    NSString *vipBorthdayReward = [self.obj objectForKey:@"vipBorthdayReward"];
    if (vipBorthdayReward.length > 0) {// ""
        [self vipBorthdayRewardMethodWithMiaobi:vipBorthdayReward];
    }
}

#pragma mark - 刷新 红包是否可使用 有无转让产品 可用卡券
- (void)refreshRightLabelData
{

    UIView *superView1 = (UIView *)[self.bgView viewWithTag:4];
    UILabel *redPackets = (UILabel *)[superView1 viewWithTag:100];//红包
    redPackets.hidden = NO;
    redPackets.text = [NSString stringWithFormat:@"%@个红包可使用",self.dataArray[0]];
    [redPackets settingLabelTextColor:HMColor(204, 204, 204) withStr:@"个红包可使用"];
    
    UIView *superView2 = (UIView *)[self.bgView viewWithTag:5];
    UILabel *isExitTransProduct = (UILabel *)[superView2 viewWithTag:100];//转让
    isExitTransProduct.hidden = NO;
    isExitTransProduct.textColor = HMColor(204, 204, 204);
    if ([self.dataArray[1] isEqualToString:@"0"]) {
        isExitTransProduct.text = @"无转让产品";
    } else {
        isExitTransProduct.text = @"有转让产品";
    }
    UIView *superView3 = (UIView *)[self.bgView viewWithTag:6];
    UILabel *couponcount = (UILabel *)[superView3 viewWithTag:100];//卡券
    couponcount.hidden = NO;
    couponcount.text = [NSString stringWithFormat:@"%@张可用卡券",self.dataArray[2]];
    [couponcount settingLabelTextColor:HMColor(204, 204, 204) withStr:@"张可用卡券"];
    
}

#pragma mark - 生日提醒弹窗
- (void)vipBorthdayRewardMethodWithMiaobi:(NSString *)miaobiMessage
{
    dispatch_async(dispatch_get_main_queue(), ^{
//        CustomAlertView *noticeNew = [[CustomAlertView alloc] initWithTitle:nil message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
//        noticeNew.type = @"12";
//        noticeNew.NoticeMessage = miaobiMessage;
//        [noticeNew show];
    });
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    double y = fabs(scrollView.contentOffset.y);
    _baiImg.alpha = y/140;
    _baiImg.y = y - 32;
    _topWhiteView.frame = CGRectMake(0, 0, KScreen_Width, -scrollView.contentOffset.y+64);
}

/** 投资纪录 */
- (void)rightItemAction:(UIButton *)rightItem
{
    [TalkingData trackEvent:@"我的" label:@"投资记录"];
    if (self.isLogIn == NO) {
        LogInViewController *loginVC = [[LogInViewController alloc] init];
        UINavigationController *nav =[[UINavigationController alloc] initWithRootViewController:loginVC];
        [self presentViewController:nav animated:YES completion:nil];
        return;
    }
//    MyInvestRecodeViewController *myInvestRecordVC = [[MyInvestRecodeViewController alloc]init];
//    myInvestRecordVC.isFromMyInV = YES;
//    [self.navigationController pushViewController:myInvestRecordVC animated:YES];
    
}
#pragma mark - navigationItem控件和事件
- (void)initNavBarItem
{
    UIImageView *leftImg =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 3, 14)];
    leftImg.image =[UIImage imageNamed:@"sandianp.png"];
    UIBarButtonItem *leftImgView = [[UIBarButtonItem alloc] initWithCustomView:leftImg];
    
    UIBarButtonItem *touImg = [[UIBarButtonItem alloc] initWithCustomView:self.portraitImageView];
    UIBarButtonItem *phone = [[UIBarButtonItem alloc] initWithCustomView:self.phoneNumLabel];
    UIBarButtonItem *levelImg = [[UIBarButtonItem alloc] initWithCustomView:self.levelImage];
    UIBarButtonItem *recordBtn = [[UIBarButtonItem alloc] initWithCustomView:self.investRecordButton];
    
    // 调整 leftBarButtonItem 在 iOS7 下面的位置
    if(([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0?1:0)){
        
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -10;
        
        self.navigationItem.leftBarButtonItems = @[negativeSpacer,leftImgView,touImg,phone,levelImg];
        self.navigationItem.rightBarButtonItems = @[negativeSpacer,recordBtn];
    }else{
        self.navigationItem.leftBarButtonItems =  @[leftImgView,touImg,phone,levelImg];
        self.navigationItem.rightBarButtonItems = @[recordBtn];
    }
}

- (void)showLevelImage{
    
    self.levelImage.hidden = NO;
    if ([[self.obj objectForKey:@"level"] isEqualToString:@"0"]) {
        self.levelImage.image = [UIImage imageNamed:@"vip_icon_un"];
    }else  if ([[self.obj objectForKey:@"level"] isEqualToString:@"1"]) {
        self.levelImage.image = [UIImage imageNamed:@"vip_icon1"];
    }else if ([[self.obj objectForKey:@"level"] isEqualToString:@"2"]) {
        self.levelImage.image = [UIImage imageNamed:@"vip_icon2"];
    }else if ([[self.obj objectForKey:@"level"] isEqualToString:@"3"]) {
        self.levelImage.image = [UIImage imageNamed:@"vip_icon3"];
    }else if ([[self.obj objectForKey:@"level"] isEqualToString:@"4"]) {
        self.levelImage.image = [UIImage imageNamed:@"vip_icon4"];
    }else if ([[self.obj objectForKey:@"level"] isEqualToString:@"5"]) {
        self.levelImage.image = [UIImage imageNamed:@"vip_icon5"];
    }else if ([[self.obj objectForKey:@"level"] isEqualToString:@"6"]) {
        self.levelImage.image = [UIImage imageNamed:@"vip_icon6"];
    }else if ([[self.obj objectForKey:@"level"] isEqualToString:@"7"]) {
        self.levelImage.image = [UIImage imageNamed:@"vip_icon7"];
    }else {
        
    }
}

- (UIImageView *)portraitImageView {
    if (!_portraitImageView) {
        CGFloat w = 30.0f; CGFloat h = w;
        CGFloat x = (self.view.frame.size.width - w) / 2;
        CGFloat y = (self.view.frame.size.height - h) / 2;
        _portraitImageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, w, h)];
        [_portraitImageView.layer setCornerRadius:(_portraitImageView.frame.size.height/2)];
        [_portraitImageView.layer setMasksToBounds:YES];
        [_portraitImageView setContentMode:UIViewContentModeScaleAspectFill];
        [_portraitImageView setClipsToBounds:YES];
        UITapGestureRecognizer *portraitTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(logInbtnClick)];
        [_portraitImageView addGestureRecognizer:portraitTap];
    }
    return _portraitImageView;
}
/** 点击个人图片跳转跳转至个人中心 */
- (void)logInbtnClick
{
    [TalkingData trackEvent:@"我的" label:@"个人中心"];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (appDelegate.status == 0) {
  
        return;
    }else{//未登陆
        if (self.isLogIn == NO) {
            LogInViewController *loginVC = [[LogInViewController alloc] init];
            UINavigationController *nav =[[UINavigationController alloc] initWithRootViewController:loginVC];
            [self presentViewController:nav animated:YES completion:nil];
            
        }else{
            
            PersonalCenterViewController *myAccountVC = [[PersonalCenterViewController alloc] init];
            myAccountVC.dataList = self.dataList;
            myAccountVC.leftMoney = [NSString stringWithFormat:@"%.2f",[[NSString stringWithFormat:@"%@",[self.obj objectForKey:@"leftMoney"]] doubleValue] / 100];
            myAccountVC.userNum = self.userNum;
            myAccountVC.isUnbind = self.isUnbind;
            [self.navigationController pushViewController:myAccountVC animated:YES];
            
        
        }
    }
    
}
/** 点击跳转至我的等级 */
- (void)gradeBtnClick
{
    [TalkingData trackEvent:@"我的" label:@"我的等级"];
    MyGradeViewController *myGradeVC = [[MyGradeViewController alloc]init];
    myGradeVC.dic = [self.dataList  objectForKey:@"obj"];
    [self.navigationController pushViewController:myGradeVC animated:YES];
}


- (void)hadLogIn:(NSDictionary *)dic userName:(NSString *)username
{
    if (username.length == 11) {
        NSString *string1 = [username substringToIndex:3];
        NSString *string2 = [username substringFromIndex:7];
        _userNum = [NSString stringWithFormat:@"%@****%@",string1,string2];
    }else{
        _userNum = username;
    }
    
    self.phoneNumLabel.text = _userNum;
    self.phoneNumLabel.textColor = HMColor(51, 51, 51);
    [self.portraitImageView  sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"userPhotos"]] placeholderImage:[UIImage imageNamed:@"basemap.png"]];
}

- (void)noLoginButton{
    _dataArray = @[@"0",@"0",@"0"];
    self.levelImage.hidden = YES;
    self.phoneNumLabel.text = @"未登录";
    self.phoneNumLabel.textColor = HMColor(204, 204, 204);
    self.portraitImageView.image = [UIImage imageNamed:@"notlogged.png"];

}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [TalkingData trackPageBegin:@"我的"];
    [self _getData];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [TalkingData trackPageEnd:@"我的"];
}

@end
