//
//  TotTopicRecommendViewController.m
//  BYMFinancing
//
//  Created by Administrator on 2016/11/1.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "TotTopicRecommendViewController.h"
#import "QRCodeInfomationViewController.h"
#import "KLineViewController.h"
#import "KVCViewController.h"
#import "TestView.h"
#import "InterviewKnowledgeViewController.h"
#import "AppStoreKitViewController.h"
#import "AVPlayerViewController.h"
@interface TotTopicRecommendViewController ()

@property(nonatomic,strong)TestView *testView;
@end

@implementation TotTopicRecommendViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
   
    self.title = @"首页";
    
    
    [self QRCode];
    [self KLineView];
    [self KVCView];
    [self test];
    [self AppStoreKitViewControllerTest];
    [self AVPlayerDemo];
    [self InterviewKnowledgeViewController];
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com/search?id=1//"];
    NSLog(@"scheme:%@", [url scheme]); //协议 http
    NSLog(@"host:%@", [url host]);     //域名 www.baidu.com
    NSLog(@"absoluteString:%@", [url absoluteString]); //完整的url字符串 http://www.baidu.com:8080/search?id=1   (刚才在真机上跑了一下，并没有打印出来端口 8080 啊)
    NSLog(@"%d",[[url absoluteString] hasSuffix:@"/"]);//测试字符串是否以aString结尾
    url = [url URLByAppendingPathComponent:@""];
    NSLog(@"url = %@",url);
    
    NSLog(@"relativePath: %@", [url relativePath]); //相对路径 search
    NSLog(@"port :%@", [url port]);  // 端口 8080
    NSLog(@"path: %@", [url path]);  // 路径 search
    NSLog(@"pathComponents:%@", [url pathComponents]); // search
    NSLog(@"Query:%@", [url query]);  //参
    
    
}

- (void)QRCode
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 100, 160, 40);
    [button setTitle:@"二维码相关知识" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor grayColor];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)buttonAction:(UIButton *)btn
{
    QRCodeInfomationViewController *qrcodeInfoVC = [[QRCodeInfomationViewController alloc]init];
    [self.navigationController pushViewController:qrcodeInfoVC animated:YES];

}


- (void)KLineView
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 150, 160, 40);
    [button setTitle:@"K 线图" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor grayColor];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(KLineViewAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)KLineViewAction:(UIButton *)btn
{
    KLineViewController *qrcodeInfoVC = [[KLineViewController alloc]init];
    [self.navigationController pushViewController:qrcodeInfoVC animated:YES];
    
}



- (void)KVCView
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 200, 160, 40);
    [button setTitle:@"KVC／KVO" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor grayColor];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(KVCViewAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)KVCViewAction:(UIButton *)btn
{
    KVCViewController *kvcVC = [[KVCViewController alloc]init];
    [self.navigationController pushViewController:kvcVC animated:YES];
    
}

- (void)test
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 250, 160, 40);
    [button setTitle:@"test" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor grayColor];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(testAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)testAction:(UIButton *)btn
{

    TestView *testView = [[TestView alloc]initWithFrame:CGRectMake(0, 300, KScreen_Width, 300)];
    testView.backgroundColor = [UIColor grayColor];

    [self.view addSubview:testView];
}

- (void)InterviewKnowledgeViewController
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 300, 160, 40);
    [button setTitle:@"面试" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor grayColor];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(mianshi:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)mianshi:(UIButton *)btn
{
    
    InterviewKnowledgeViewController *kvcVC = [[InterviewKnowledgeViewController alloc]init];
    [self.navigationController pushViewController:kvcVC animated:YES];
    
}

- (void)AppStoreKitViewControllerTest
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 350, 160, 40);
    [button setTitle:@"内购" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor grayColor];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(AppStoreKit:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)AppStoreKit:(UIButton *)btn
{
    
    AppStoreKitViewController *kvcVC = [[AppStoreKitViewController alloc]init];
    [self.navigationController pushViewController:kvcVC animated:YES];
    
}

- (void)AVPlayerDemo
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 400, 160, 40);
    [button setTitle:@"视频" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor grayColor];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(AVPlayerDemo:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

- (void)AVPlayerDemo:(UIButton *)btn
{
    
    AVPlayerViewController *kvcVC = [[AVPlayerViewController alloc]init];
    [self.navigationController pushViewController:kvcVC animated:YES];
    
}
@end
