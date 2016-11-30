//
//  ProtectViewController.m
//  BYMFinancing
//
//  Created by Administrator on 2016/11/2.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ProtectViewController.h"

@interface ProtectViewController ()

@property (nonatomic, strong)UIWebView *webView;
    

@end

@implementation ProtectViewController

/**
 *  首页安全保障说明：只是一个简单的webView
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    [super _initViewBackItem];
    
    self.title = @"安全保障说明";
    [self loadWebView];
}

- (void)loadWebView
{
    NSString *bankSafeUrlMobile = [BYM_UserDefulats objectForKey:@"bankSafeUrlMobile"];//支付安全保障文本
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, KScreen_Width, KScreen_Height)];
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:bankSafeUrlMobile]];
    [(UIScrollView*)[_webView.subviews objectAtIndex:0] setShowsHorizontalScrollIndicator:NO];
    [(UIScrollView*)[_webView.subviews objectAtIndex:0] setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:_webView];
    [_webView loadRequest:request];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)backItemAction:(UIButton *)backButton
{
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
