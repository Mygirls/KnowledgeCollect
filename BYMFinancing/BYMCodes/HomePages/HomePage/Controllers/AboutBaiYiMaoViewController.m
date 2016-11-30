//
//  AboutBaiYiMaoViewController.m
//  BYMFinancing
//
//  Created by Administrator on 2016/11/2.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "AboutBaiYiMaoViewController.h"

@interface AboutBaiYiMaoViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong)UIScrollView *scrollView;
@end

@implementation AboutBaiYiMaoViewController
/**
 *  首页关于佰亿猫页面：只是一个简单的UIScrollView上添加一张图片
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    [super _initViewBackItem];
    
    self.title = @"关于佰亿猫";
    
    self.view.backgroundColor = [UIColor whiteColor];
    //创建滑动视图
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64)];
    _scrollView.backgroundColor = [UIColor clearColor];
    
    //设置代理对象
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    
    UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectZero];
    imageView.frame = CGRectMake(0, 0, ZPRealValue(320), ZPRealValue(2070));//320 × 2138
    imageView.image = [UIImage imageNamed:@"gybym.png"];
    
    [_scrollView addSubview:imageView];
    CGFloat scrollViewHeight = 0.0f;
    
    for (UIView* view in _scrollView.subviews){
        scrollViewHeight += view.frame.size.height;
        
    }
    [_scrollView setContentSize:(CGSizeMake(KScreen_Width, scrollViewHeight))];
    
    
    [self.view addSubview:_scrollView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)backItemAction:(UIButton *)backButton
{
    [self.navigationController popViewControllerAnimated:YES];

}


@end
