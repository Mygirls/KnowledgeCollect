//
//  ManagerFinancialProductViewController.m
//  BYMFinancing
//
//  Created by Administrator on 2016/11/1.
//  Copyright © 2016年 mac. All rights reserved.
//
//http://www.cnblogs.com/graveliang/p/5749787.html  横竖屏

#import "ManagerFinancialProductViewController.h"

@interface ManagerFinancialProductViewController ()

@end

@implementation ManagerFinancialProductViewController


- (void)interfaceOrientation:(UIInterfaceOrientation)orientation
{
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector             = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val                  = orientation;
        // 从2开始是因为0 1 两个参数已经被selector和target占用
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}


- (BOOL)shouldAutorotate{
    return NO;
}


-(void) viewDidAppear:(BOOL) animated{
    [super viewDidAppear:animated];
}

-(void) viewDidDisappear:(BOOL) animated{
    [super viewDidAppear:animated];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view .backgroundColor = [UIColor whiteColor];
    self.title = @"K线图";
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 250, 200, 40);
    [button setTitle:@"竖屏" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor grayColor];
    [button addTarget:self action:@selector(button01) forControlEvents:UIControlEventAllEvents];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:button];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(10, 150, 200, 40);
    [button2 setTitle:@"横屏" forState:UIControlStateNormal];
    button2.backgroundColor = [UIColor grayColor];
    [button2 addTarget:self action:@selector(button02) forControlEvents:UIControlEventAllEvents];
    [button2 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:button2];
    
}
- (void)button02
{
    [self interfaceOrientation:UIInterfaceOrientationLandscapeRight];
}

- (void)button01{
    [self interfaceOrientation:UIInterfaceOrientationPortrait];
}








@end
