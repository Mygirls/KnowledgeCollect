//
//  AboutRiskViewController.m
//  BYMFinancing
//
//  Created by Administrator on 2016/11/2.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "AboutRiskViewController.h"

@interface AboutRiskViewController ()<UIScrollViewDelegate>
{
    NSArray *_imageNames;
    
}
@property(nonatomic,strong) UIScrollView *bigScroll;
@property(nonatomic,strong)UIButton *backButton;
@property(nonatomic,strong)UIView *topView;
@property(nonatomic,strong)UIView *seView;
@property(nonatomic,strong)UILabel *bottomLabel;
@end

@implementation AboutRiskViewController
/**
 *  首页 风控解读 页面：放置三张图片 点击图片 模态到AboutRiskViewController页面
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _imageNames = @[@"fkjd_myt3",@"fkjd_cd3",@"fkjd_fd3"];
    
    [self setupScrollView];
    [self.view addSubview:self.topView];
    [self.view addSubview:self.backButton];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.seView];
}

- (UILabel *)bottomLabel
{
    if (!_bottomLabel) {
        _bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, KScreen_Height-40, KScreen_Width, 40)];
        _bottomLabel.textColor = [UIColor blackColor];
        _bottomLabel.alpha = 0.9;
        _bottomLabel.font = [UIFont systemFontOfSize:18];
        _bottomLabel.textAlignment = NSTextAlignmentCenter;
        _bottomLabel.text = @"1/3";
        _bottomLabel.backgroundColor = [UIColor whiteColor];
    }
    return _bottomLabel;
}

- (UIButton *)backButton
{
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backButton.frame = CGRectMake(-15, 25, 65, 36);
        _backButton.layer.cornerRadius = 18;
        _backButton.backgroundColor  =[UIColor grayColor];
        _backButton.alpha = 0.6;
        [_backButton setImage:[UIImage imageNamed:@"homeback3"] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(riskBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}


- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, KScreen_Width, 18)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font  =[UIFont systemFontOfSize:18];
        _titleLabel.textColor = HMColor(51, 51, 51);
        _titleLabel.alpha = 0;
    }
    return  _titleLabel;
    
}

- (UIView *)topView
{
    if (!_topView) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreen_Width, 64)];
        _topView.backgroundColor = [UIColor clearColor];
    }
    return _topView;
}

- (UIView *)seView
{
    if (!_seView) {
        _seView = [[UIView alloc] initWithFrame:CGRectMake(0, 63.5, KScreen_Width, 0.5)];
        _seView.backgroundColor = HMColor(229, 229, 229);
        _seView.hidden = YES;
    }
    return _seView;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
{
    if (scrollView.contentOffset.y > 40) {
        [UIView animateWithDuration:0.5 animations:^{
            self.topView.backgroundColor  =[UIColor whiteColor];
            self.backButton.backgroundColor = [UIColor clearColor];
            [_backButton setImage:[UIImage imageNamed:@"homeback32"] forState:UIControlStateNormal];
            self.titleLabel.alpha = 1;
            self.seView.hidden = NO;
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
        } completion:^(BOOL finished) {
            
        }];
    }else {
        [UIView animateWithDuration:0.5 animations:^{
            self.topView.backgroundColor  =[UIColor clearColor];
            self.backButton.backgroundColor = [UIColor grayColor];
            [_backButton setImage:[UIImage imageNamed:@"homeback3"] forState:UIControlStateNormal];
            self.titleLabel.alpha = 0;
            self.backButton.alpha = 0.6;
            self.seView.hidden = YES;
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
        } completion:^(BOOL finished) {
            
        }];
    }
    if ([scrollView isEqual:self.bigScroll]) {
        NSInteger a = scrollView.contentOffset.x / KScreen_Width;
        self.bottomLabel.text = [NSString stringWithFormat:@"%ld/3",a+1];
    }
    
}

- (void)riskBtnClick
{
    [self dismissViewControllerAnimated:YES completion:^{
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    }];
}


///2.创建背景滑动视图
#pragma mark 添加滑动视图
-(void)setupScrollView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    //2.1 添加大的滚动菜单栏
    UIScrollView *bigScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0,0 , KScreen_Width, KScreen_Height)];
    bigScroll.contentSize = CGSizeMake(KScreen_Width, ZPRealValue([self.imageHeight doubleValue]));
    bigScroll.showsHorizontalScrollIndicator=NO;
    bigScroll.delegate=self;
    bigScroll.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bigScroll];
    self.bigScroll=bigScroll;
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KScreen_Width, ZPRealValue([self.imageHeight doubleValue]))];
    imageView.image = [UIImage imageNamed:self.imagestr ];
    [self.bigScroll addSubview:imageView];
    
}




@end
