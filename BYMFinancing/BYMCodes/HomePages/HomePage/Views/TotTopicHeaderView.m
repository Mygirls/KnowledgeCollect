//
//  TotTopicHeaderView.m
//  BYMFinancing
//
//  Created by Administrator on 2016/11/2.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "TotTopicHeaderView.h"
#import "BYMTotpicItem.h"
#import "SDCycleScrollView.h"
#import "SystemNoticeViewController.h"
#import "InviteViewController.h"
#import "HomeSignViewController.h"
#define ItemTag 10
@interface TotTopicHeaderView ()<SDCycleScrollViewDelegate>

@property (nonatomic, strong)SDCycleScrollView  *vc;
@property (nonatomic, strong)UIView             *itemVIew;
@property (nonatomic, strong)UILabel            *textLabel;

@end

@implementation TotTopicHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self creatSixButton];
        [self createHeadlineTranslationView];
    }
    return self;
}

#pragma  mark - 创建6个按钮 并实现点击事件
- (void)creatSixButton
{
    _itemVIew = [[UIView alloc]initWithFrame:CGRectMake(0, KScreen_Width/2.0, KScreen_Width, 330/2.0)];
    _itemVIew.backgroundColor = [UIColor clearColor];
    [self addSubview:_itemVIew];
    NSArray *titleNames = @[@"签到",@"邀请好友",@"喵商城",@"活动中心",@"新手专区",@"帮助中心"];
    NSArray *placeholderImages = @[@"sign",@"inviteFriends",@"mall",@"activity",@"newbie",@"assist"];
    float width = KScreen_Width / 3.0;
    
    for (int i = 0; i < 6 ; i ++) {
        
        BYMTotpicItem *item = [[BYMTotpicItem alloc]initWithFrame:CGRectMake(i % 3 * width  , i / 3 * 165/2.0 , width, 165/2.0) imageUrl:nil title:titleNames[i] placeholderImage:[UIImage imageNamed:placeholderImages[i]]];
        item.backgroundColor = [UIColor clearColor];
        item.tag = ItemTag + i;
        [item addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [_itemVIew addSubview:item];
    }

    
}
- (void)click:(BYMTotpicItem*)btn
{
    //signUrl:签到webViewURL; freshUrl:新手专区webViewURL;
    if (btn.tag == 10) {//签到
        [self isLogin:btn];
        [TalkingData trackEvent:@"首页" label:@"签到"];
        HomeSignViewController *inviteVC = [[HomeSignViewController alloc]init];
        inviteVC.title = @"iiii";
        [self.viewController.navigationController pushViewController:inviteVC animated:YES];

    }else if (btn.tag == 11) {//邀请好友
        InviteViewController *inviteVC = [[InviteViewController alloc]init];
        inviteVC.title = @"邀请好友";
        inviteVC.webURLstring = self.inviteBackgroundUrl;
        [TalkingData trackEvent:@"首页" label:@"邀请好友"];
        [self.viewController.navigationController pushViewController:inviteVC animated:YES];
        
    }else if (btn.tag == 12) {//喵商城
        [TalkingData trackEvent:@"首页" label:@"喵商城"];
//        ShoppingCentreViewController *shoppingCentreVC = [[ShoppingCentreViewController alloc]init];
//        [self.viewController.navigationController pushViewController:shoppingCentreVC animated:YES];
        
    }else if (btn.tag == 13) {//活动中心
        [TalkingData trackEvent:@"首页" label:@"活动中心"];
//        TrendCenterOfMoreViewController *trendCMVC = [[TrendCenterOfMoreViewController alloc]init];
//        [self.viewController.navigationController pushViewController:trendCMVC animated:YES];
        
    }else if (btn.tag == 14) {//新手专区
        [TalkingData trackEvent:@"首页" label:@"新手专区"];
//        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//        if (appDelegate.status == 0) {
//            TotTopicRecommendViewController *vc = (TotTopicRecommendViewController *)self.viewController;
//            [vc showHUD:@"网络异常"];
//            [vc hideHUD:@"网络异常"];
//            
//        }else {
//            NoviceExclusiveViewController *directionVC = [[NoviceExclusiveViewController alloc]init];
//            directionVC.detailURL = _freshManUrl;
//            [self.viewController.navigationController pushViewController:directionVC animated:YES];
//        }
        
    }else if (btn.tag == 15) {//帮助中心
        [TalkingData trackEvent:@"首页" label:@"帮助中心"];
//        HelpCenterViewController *helpvc = [[HelpCenterViewController alloc]init];
//        [self.viewController.navigationController pushViewController:helpvc animated:YES];
    }

}

- (void)isLogin:(BYMTotpicItem *)btn
{
    btn.enabled = NO;
    NSDictionary *result = [BYM_UserDefulats objectForKey:@"userDefulats"];
    NSDictionary *subDic = [result objectForKey:@"obj"];
    NSString *authorization = [subDic objectForKey:@"authorization"];
    if ([authorization isEqualToString:@"(null)"] || authorization == nil) {
        authorization = @"";
    }
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    NSString *str = [NSString stringWithFormat:  @"{\"authorization\":\"%@\"}",authorization];
    [params setObject:str forKey:@"parameters"];
    [BYMBaseRequest requestWithURL:@"/User/toMSignIn" params:params httpMethod:@"POST" blockSuccess:^(id result) {
        btn.enabled = YES;
        
        if ([result isKindOfClass:[NSError class]]) {
            
        }else  if ([[result objectForKey:@"end"] isEqualToString:@"noLogin"]) {
            //            __weak typeof(self) weakSelf = self;
            //            LogInViewController *loginVC = [[LogInViewController alloc]init];
            //            loginVC.myReloadDataBlock = ^(NSDictionary *dic){
            //                [weakSelf isLogin:btn];
            //            };
            //            UINavigationController *nav =[[UINavigationController alloc]initWithRootViewController:loginVC];
            //            [self.viewController presentViewController:nav animated:YES completion:nil];
            
            
        }else  if ([[result objectForKey:@"end"] isEqualToString:@"ok"]) {
            //            HomeSignViewController *homeSignVC = [[HomeSignViewController alloc]init];
            //            [self.viewController.navigationController pushViewController:homeSignVC animated:YES];
        }else {
            
        }

    } blockFailure:^(id result) {
        
    }];
    
}

#pragma  mark - 头条资讯
- (void)createHeadlineTranslationView
{
    UIView *headlineTranslationView = [[UIView alloc]initWithFrame:CGRectMake(0, _itemVIew.bottom , KScreen_Width, 44)];
    headlineTranslationView.backgroundColor = [UIColor clearColor];
    [self addSubview:headlineTranslationView];
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(10, 0, KScreen_Width - 20, 0.5)];
    lineView.backgroundColor = HMColor(229, 229, 229);
    [headlineTranslationView addSubview:lineView];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10,(44 - 27)/2.0, 41, 27)];
    imageView.image = [UIImage imageNamed:@"announcement"];//41 * 27
    [headlineTranslationView addSubview:imageView];
    _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageView.right + 20,(headlineTranslationView.height - 20) /2.0, self.width - imageView.right - 20 - 20, 20)];
    _textLabel.backgroundColor = [UIColor clearColor];
    _textLabel.textAlignment = NSTextAlignmentLeft;
    _textLabel.textColor = HMColor(51, 51, 51);
    _textLabel.font = [UIFont systemFontOfSize:15];
    _textLabel.text = @"";
    [headlineTranslationView addSubview:_textLabel];
    
    UIImageView *arraw = [[UIImageView alloc]initWithFrame:CGRectMake(_textLabel.right + 3,(44 - 13)/2.0, 7, 13)];
    arraw.image = [UIImage imageNamed:@"rightarrow"];//41 * 27
    [headlineTranslationView addSubview:arraw];
    
    UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(0, 43.5, KScreen_Width, 0.5)];
    lineView2.backgroundColor = HMColor(229, 229, 229);
    [headlineTranslationView addSubview:lineView2];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(translationTap:)];
    [headlineTranslationView addGestureRecognizer:tap];

}

- (void)translationTap:(UITapGestureRecognizer *)tap
{
    [TalkingData trackEvent:@"首页" label:@"头条资讯"];
    SystemNoticeViewController *sysvc = [[SystemNoticeViewController alloc]init];
    [self.viewController.navigationController pushViewController:sysvc animated:YES];
    
}
#pragma mark - 创建滑动视图
- (void)setImageList:(NSArray *)imageList
{
    _imageList = imageList;
    if (![_imageList isKindOfClass:[NSNull class]]) {
        [self DYMRollingBannerVC];
    }
}
- (void)DYMRollingBannerVC{
    
    NSMutableArray *imageArray = [NSMutableArray array];
    for(NSDictionary *dict in _imageList){
        if(dict[@"imgURL"]){
            [imageArray addObject:dict[@"imgURL"]];
        }
    }
    self.backgroundColor = [UIColor whiteColor];
    if (_vc == nil) {
        // 网络加载 --- 创建带标题的图片轮播器
        _vc = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, KScreen_Width, KScreen_Width/2.0) delegate:self placeholderImage:nil];//[UIImage imageNamed:@"placeholder"]
        _vc.backgroundColor = [UIColor whiteColor];
        _vc.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        _vc.hidesForSinglePage = NO;
        _vc.autoScrollTimeInterval = 2.5;
        _vc.currentPageDotColor = [UIColor redColor]; // 自定义分页控件小圆标颜色
        _vc.pageDotColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
        [self addSubview:_vc];
        
    }
    
    //         --- 模拟加载延迟
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _vc.imageURLStringsGroup = imageArray;
        
    });
    
    /*
     block监听点击方式
     
     cycleScrollView2.clickItemOperationBlock = ^(NSInteger index) {
     NSLog(@">>>>>  %ld", (long)index);
     };
     
     */
    
}
#pragma mark - set 方法 传递数据
- (void)setInviteBackgroundUrl:(NSString *)inviteBackgroundUrl
{
    _inviteBackgroundUrl = inviteBackgroundUrl;
    
}

- (void)setFreshManUrl:(NSString *)freshManUrl
{
    _freshManUrl = freshManUrl;
}

- (void)setSignUrl:(NSString *)signUrl
{
    _signUrl = signUrl;
    
}

- (void)setIcons:(NSArray *)icons
{
    _icons = icons;
     NSArray *placeholderImages = @[@"sign",@"inviteFriends",@"mall",@"activity",@"newbie",@"assist"];
    for (int i = 0; i < _icons.count; i ++) {
        NSDictionary *dic = _icons[i];
        NSString *iconKey = [dic objectForKey:@"iconKey"];
        NSString *iconName = [dic objectForKey:@"iconName"];
        NSString *iconUrl = [dic objectForKey:@"iconUrl"];
        if ([iconKey isEqualToString:@"qd"]) {//签到
            BYMTotpicItem *item = (BYMTotpicItem *)[_itemVIew viewWithTag:ItemTag + 0 ];
            [item setImageUrl:iconUrl title:iconName placeholderImage:[UIImage imageNamed:placeholderImages[0]]];
        }else if ([iconKey isEqualToString:@"yqhy"]) {//邀请好友
            BYMTotpicItem *item = (BYMTotpicItem *)[_itemVIew viewWithTag:ItemTag + 1 ];
            [item setImageUrl:iconUrl title:iconName placeholderImage:[UIImage imageNamed:placeholderImages[1]]];
            
        }else if ([iconKey isEqualToString:@"msc"]) {//喵商城
            BYMTotpicItem *item = (BYMTotpicItem *)[_itemVIew viewWithTag:ItemTag + 2 ];
            [item setImageUrl:iconUrl title:iconName placeholderImage:[UIImage imageNamed:placeholderImages[2]]];
            
        }
        else if ([iconKey isEqualToString:@"hdzx"]) {//活动中心
            BYMTotpicItem *item = (BYMTotpicItem *)[_itemVIew viewWithTag:ItemTag + 3 ];
            
            [item setImageUrl:iconUrl title:iconName placeholderImage:[UIImage imageNamed:placeholderImages[3]]];
            
        }
        else if ([iconKey isEqualToString:@"sxzq"]) {//新手专区
            BYMTotpicItem *item = (BYMTotpicItem *)[_itemVIew viewWithTag:ItemTag + 4 ];
            
            [item setImageUrl:iconUrl title:iconName placeholderImage:[UIImage imageNamed:placeholderImages[4]]];
            
        }
        else if ([iconKey isEqualToString:@"bzzx"]) {//帮助中心
            BYMTotpicItem *item = (BYMTotpicItem *)[_itemVIew viewWithTag:ItemTag + 5 ];
            [item setImageUrl:iconUrl title:iconName placeholderImage:[UIImage imageNamed:placeholderImages[5]]];
            
        }
    }
}

- (void)setNotice:(NSDictionary *)notice
{
    _notice = notice;
    if ([notice isKindOfClass:[NSNull class]]) {
        return;
    }
    _textLabel.text = [notice objectForKey:@"title"];
    
}

#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    [TalkingData trackEvent:@"首页" label:@"Banner"];
    
    NSInteger page =  index;
    NSDictionary *dic = self.imageList[page];
    NSString *noticeUrl = [NSString stringWithFormat:@"%@",[dic objectForKey:@"noticeUrl"]];
    
    //isChange:是否有js交互:0：无1：有
    if ([[NSString stringWithFormat:@"%@",[dic objectForKey:@"isChange"]] isEqualToString:@"1"]) {
//        AnnFestiveViewController *annVC = [[AnnFestiveViewController alloc]init];
//        annVC.detailURL = noticeUrl;
//        [self.viewController.navigationController pushViewController:annVC animated:YES];
        
    }else {
        if ([noticeUrl isEqualToString:@"www"]) {
            return;
        } else {
//            BannerViewController *bannerVc = [[BannerViewController alloc]init];
//            bannerVc.noticeUrl = noticeUrl;
//            [self.viewController.navigationController pushViewController:bannerVc animated:YES];
        }
    }
    
    
}


@end
