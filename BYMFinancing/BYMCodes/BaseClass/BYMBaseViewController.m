//
//  BYMBaseViewController.m
//  BYMFinancing
//
//  Created by Administrator on 2016/11/2.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "BYMBaseViewController.h"
@interface BYMBaseViewController ()

@property(nonatomic,strong)UIView *lineView;
@end

@implementation BYMBaseViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
   
//    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];//去掉导航栏下面系统的黑线
//    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:HMColor(51, 51, 51)}];
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationBg.png"] forBarMetrics:UIBarMetricsDefault];//图片为透明的图片
//    [self.navigationController.navigationBar.layer setMasksToBounds:YES];       // 剪切掉多余的背景

    [self.view addSubview:self.lineView];   //导航栏下分割线
    
    // 右滑返回
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
}


-(void)_initViewBackItem
{
    UIButton *backItem = [UIButton buttonWithType:UIButtonTypeCustom];
    backItem.frame = CGRectMake(0, 0, 50,20 );
    backItem.backgroundColor = [UIColor orangeColor];
    [backItem setBackgroundImage:[UIImage imageNamed:@"banck3"] forState:UIControlStateNormal];
    [backItem addTarget:self action:@selector(backItemAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *menuButton = [[UIBarButtonItem alloc] initWithCustomView:backItem];
    self.navigationItem.leftBarButtonItem = menuButton;
}

- (void)backItemAction:(UIButton *)sender
{

}

/**
 *  懒加载
 *  普通状态下的图片
 */
- (NSMutableArray *)normalImages
{
    if (_normalImages == nil) {
        _normalImages = [[NSMutableArray alloc] init];
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"Loading.png"]];
        [self.normalImages addObject:image];
    }
    return _normalImages;
}

//正在刷新状态下的图片
- (NSMutableArray *)refreshImages
{
    if (_refreshImages == nil) {
        _refreshImages = [[NSMutableArray alloc] init];
        for (NSUInteger i = 1; i<=6; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"Loading%ld", i]];
            [self.refreshImages addObject:image];
        }
    }
    return _refreshImages;
}

/**
 *  导航栏下分割线:默认隐藏
 */
- (UIView *)lineView
{
    if (_lineView == nil) {
        _lineView =[[UIView alloc]initWithFrame:CGRectMake(0, 63.5, KScreen_Width, .5)];
        _lineView.hidden = YES;
        _lineView.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:.1];
    }
    return _lineView;
}

- (void)setLineHad:(BOOL)lineHad
{
    if (lineHad == YES) {
        self.lineView.hidden = NO;
    }else {
        self.lineView.hidden = YES;
    }
}


- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}

/**
    去掉navigationBar下的黑线 方法一
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:HMColor(51, 51, 51)}];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationBg.png"] forBarMetrics:UIBarMetricsDefault];//图片为透明的图片
    [self.navigationController.navigationBar.layer setMasksToBounds:YES];       // 剪切掉多余的背景


    去掉navigationBar下的黑线 方法二
    self.navigationController.navigationBar.tintColor = [UIColor redColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor redColor];
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        NSArray *list=self.navigationController.navigationBar.subviews;
        for (id obj in list) {
            if ([obj isKindOfClass:[UIImageView class]]) {
                UIImageView *imageView=(UIImageView *)obj;
                NSArray *list2=imageView.subviews;
                for (id obj2 in list2) {
                    if ([obj2 isKindOfClass:[UIImageView class]]) {
                        UIImageView *imageView2=(UIImageView *)obj2;
                        imageView2.hidden=YES;
                    }
                }
            }
        }
    }
*/

@end
