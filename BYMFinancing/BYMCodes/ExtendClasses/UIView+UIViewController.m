//
//  UIView+UIViewController.m
//  BYMFinancing
//
//  Created by Administrator on 2016/11/7.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "UIView+UIViewController.h"

/**
 *  获取当前view 所在的ViewController
 */
@implementation UIView (UIViewController)

- (UIViewController *)viewController {
    
    //通过响应者链关系，取得此视图的下一个响应者
    UIResponder *next = self.nextResponder;
    
    do {
        
        //判断响应者对象是否是视图控制器类型
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        
        next = next.nextResponder;
        
    }while(next != nil);
    
    
    return nil;
}


@end
