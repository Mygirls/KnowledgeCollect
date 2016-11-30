//
//  QRView.h
//  QRWeiXinDemo
//
//  Created by lovelydd on 15/4/25.
//  Copyright (c) 2015年 lovelydd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QRMenu.h"

/**
 *  点击按钮，切换二维码／条码扫描 协议方法
 */
@protocol QRViewDelegate <NSObject>
@optional
-(void)scanTypeConfig:(QRItem *)item;

@end

@interface QRView : UIView


@property (nonatomic, weak) id<QRViewDelegate> delegate;

/**
 *  透明的区域:可扫描区域
 */
@property (nonatomic, assign) CGSize transparentArea;
@end
