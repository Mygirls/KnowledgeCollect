//
//  MJQQRCodeScanCamera.h
//  QR_CodeDemo
//
//  Created by administrator on 2016/11/11.
//  Copyright © 2016年 BYM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>
typedef void(^QRCodeScanCameraCompletionBlock)(NSString *strValue);

@interface MJQQRCodeScanCamera : NSObject
/**
 * Generate QRCode 扫描相册图片／长按扫描图片也相似
 * @param img , 你所需要扫描的img
 * @param completion ,扫描完成后传递一个str
 */
- (void )ScanCameraPhotoGetCIQRCodeFeatureByImage:(UIImage *)img completion:(QRCodeScanCameraCompletionBlock)completion;

@end
