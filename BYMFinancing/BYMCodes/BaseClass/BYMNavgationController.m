//
//  BYMNavgationController.m
//  BYMFinancing
//
//  Created by Administrator on 2016/11/1.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "BYMNavgationController.h"

@interface BYMNavgationController ()

@end

@implementation BYMNavgationController

- (void)viewDidLoad
{
    [super viewDidLoad];

    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count >0)
    {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}


@end
