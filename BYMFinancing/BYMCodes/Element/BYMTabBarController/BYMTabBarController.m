//
//  BYMTabBarController.m
//  BYMFinancing
//
//  Created by Administrator on 2016/11/1.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "BYMTabBarController.h"
#import "BYMNavgationController.h"
#import "BYMTabBar.h"

#import "TotTopicRecommendViewController.h"
#import "ManagerFinancialProductViewController.h"
#import "MyInvestViewController.h"

@interface BYMTabBarController ()

@end

@implementation BYMTabBarController

+ (void)initialize {
    
    // 设置为不透明
    [[UITabBar appearance] setTranslucent:NO];
    // 设置背景颜色
    [UITabBar appearance].barTintColor = [UIColor colorWithRed:0.97f green:0.97f blue:0.97f alpha:1.00f];
    
    // 拿到整个导航控制器的外观
    UITabBarItem * item = [UITabBarItem appearance];
    item.titlePositionAdjustment = UIOffsetMake(0, 1.5);
    
    // 普通状态
    NSMutableDictionary * normalAtts = [NSMutableDictionary dictionary];
    normalAtts[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    normalAtts[NSForegroundColorAttributeName] = [UIColor colorWithRed:0.62f green:0.62f blue:0.63f alpha:1.00f];
    [item setTitleTextAttributes:normalAtts forState:UIControlStateNormal];
    
    // 选中状态
    NSMutableDictionary *selectAtts = [NSMutableDictionary dictionary];
    selectAtts[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    selectAtts[NSForegroundColorAttributeName] = [UIColor redColor];
    [item setTitleTextAttributes:selectAtts forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    
    [self addCustomTabBar];
    [self setUpAllChildViewController];
}
- (void)addCustomTabBar
{
    // 创建自定义tabbar
    BYMTabBar *customTabBar = [[BYMTabBar alloc] init];
    // 更换系统自带的tabbar
    [self setValue:customTabBar forKeyPath:@"tabBar"];
}

/**
 *  添加所有子控制器方法
 */
- (void)setUpAllChildViewController{

    TotTopicRecommendViewController *hotTopicVC = [[TotTopicRecommendViewController alloc]init];
    ManagerFinancialProductViewController *managerVC = [[ManagerFinancialProductViewController alloc]init];
    MyInvestViewController *myInvestVC = [[MyInvestViewController alloc]init];

    NSArray *childVcs = @[hotTopicVC,managerVC,myInvestVC];
    NSArray *imagename = @[
                              @"sy",
                              @"tzlc",
                              @"wd"];
    NSArray *titles = @[@"",@"",@""];
    for (int i = 0; i < childVcs.count; i ++) {
        [self addChildViewController:childVcs[i] WithNormalImage:imagename[i]  andTitle:titles[i]];
    }

}
/**
 *  添加一个子控制器的方法
 */
- (void)addChildViewController:(UIViewController *)childVC WithNormalImage:(NSString *)imagename andTitle:(NSString *)title
{
    BYMNavgationController *navC = [[BYMNavgationController alloc]initWithRootViewController:childVC];
    navC.title = title;
    navC.tabBarItem.image =[UIImage imageNamed:imagename];
    navC.tabBarItem.selectedImage = [[UIImage imageNamed:[imagename stringByAppendingString:@"h"]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVC.navigationItem.title = title;
    [self addChildViewController:navC];
}

/**
 *  单例
 */
+ (BYMTabBarController *)shareMainTabBarViewControler
{
    static BYMTabBarController *mainTBVC = nil;
    if (mainTBVC == nil) {
        mainTBVC = [[BYMTabBarController alloc]init];
    }
    return mainTBVC;
}

- (BOOL)shouldAutorotate
{
    return [self.selectedViewController shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [self.selectedViewController supportedInterfaceOrientations];
}
@end
