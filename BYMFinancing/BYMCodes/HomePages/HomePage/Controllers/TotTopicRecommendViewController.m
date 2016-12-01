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
@interface TotTopicRecommendViewController ()

@end

@implementation TotTopicRecommendViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
   
    self.title = @"首页";
    
    [self QRCode];
    [self KLineView];
    
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
@end
