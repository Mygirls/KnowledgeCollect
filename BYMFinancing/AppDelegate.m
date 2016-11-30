//
//  AppDelegate.m
//  BYMFinancing
//
//  Created by Administrator on 2016/11/1.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "AppDelegate.h"
#import "BYMTabBarController.h"

#import "QINetReachabilityManager.h"
#import "QIReachability.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    BYMTabBarController *tabBarVC = [BYMTabBarController shareMainTabBarViewControler];
    self.window.rootViewController = tabBarVC;
    [self.window makeKeyAndVisible];
    
    [self networkMonitor];                                      //网络监控通知
#ifdef DEBUG
    [TalkingData setExceptionReportEnabled:NO];                 //talkingdata 在此设置收集用户错误日志来修正bug
#else
    [TalkingData setExceptionReportEnabled:YES];
#endif
    [TalkingData sessionStarted:@"A1EA0F0B2C0AA5F32D4A64FF8C27DBE2" withChannelId:@"APPStore"];
    
    
    
    

    
    return YES;
}


#pragma mark - 网络监控
- (void)networkMonitor
{
    QINetReachabilityManager *manager = [QINetReachabilityManager sharedInstance];
    QINetReachabilityStatus status = (QINetReachabilityStatus)[manager currentNetReachabilityStatus];
    
    if(status == QINetReachabilityStatusNotReachable){
        self.status = 0;                    // 没有网络
    }else if (status == QINetReachabilityStatusWIFI){
        self.status = 1;                    // wifi
    }else if (status == QINetReachabilityStatusWWAN){
        self.status = 2;                    // 4G/3G
    }
    
    [manager currentNetStatusChangedBlock:^(QINetReachabilityStatus currentStatus) {
        if(currentStatus == QINetReachabilityStatusNotReachable){
            self.status = 0;                // 没有网络
            
        }else if (currentStatus == QINetReachabilityStatusWIFI){
            self.status = 1;                // wifi
            
        }else if (currentStatus == QINetReachabilityStatusWWAN){
            self.status = 2;                // 4G/3G
        }
    }];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end

