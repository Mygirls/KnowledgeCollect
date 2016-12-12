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


@end
