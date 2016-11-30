//
//  PTImageCropViewController.h
//  BYMFinancing
//
//  Created by Administrator on 2016/11/7.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PTImageCropViewController : UIViewController

/**
 *  初始化
 *  @param image         被裁剪照片
 *  @param cropScale     裁剪比例（高/宽）0:任意比例
 *  @param complentBlock 完成回调
 *  @param cancelBlock   取消回调
 *  @return self
 */
- (instancetype)initWithImage:(UIImage*)image withCropScale:(CGFloat)cropScale complentBlock:(void (^)(UIImage* image))complentBlock cancelBlock:(void (^)(id sender))cancelBlock;

@end
