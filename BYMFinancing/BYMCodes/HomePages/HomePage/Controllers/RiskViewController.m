//
//  RiskViewController.m
//  BYMFinancing
//
//  Created by Administrator on 2016/11/2.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "RiskViewController.h"
#import "AboutRiskViewController.h"
@interface RiskViewController ()

@property (nonatomic, strong)UIScrollView *scrollView;

@end

@implementation RiskViewController
/**
 *  首页 风控解读 页面：放置三张图片 点击图片 模态到AboutRiskViewController页面
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"风控解读";
    [super _initViewBackItem];
    
    self.view.backgroundColor = [UIColor whiteColor];
    NSArray *imageArray = @[@"cdfkjd_3",@"mytfkjd_3",@"fdfkjd_3"];
    [self addSubviews:imageArray];
}

- (void)addSubviews:(NSArray *)array
{
    for (int i =0; i<3; i ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 64+i*(ZPRealValue(167)+(KScreen_Height-ZPRealValue(167)*3-64)/2.0), KScreen_Width, ZPRealValue(167));
        button.tag = i;
        [button setBackgroundImage:[UIImage imageNamed:array[i]] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
}
- (void)btnClick:(UIButton *)btn
{
    AboutRiskViewController *about = [[AboutRiskViewController alloc] init];
    
    switch (btn.tag) {
        case 0:
            about.titleLabel.text = @"车贷风控解读";
            about.imageHeight = @"1410";
            about.imagestr = @"fkjd_cd3";
            break;
        case 1:
            about.titleLabel.text = @"贸易通风控解读";
            about.imageHeight = @"2323";
            about.imagestr = @"fkjd_myt3";
            break;
            
        default:
            about.titleLabel.text =  @"房贷风控解读";
            about.imageHeight = @"1915";
            about.imagestr = @"fkjd_fd3";
            break;
    }
    [self presentViewController:about animated:YES completion:nil];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = YES;
}

- (void)backItemAction:(UIButton *)backButton
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
