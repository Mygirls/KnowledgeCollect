//
//  MJQ_QR_Code_generate.h
//  QR_CodeDemo
//
//  Created by administrator on 2016/11/9.
//  Copyright © 2016年 BYM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/** MJQQRCodeGenerate
 *
 *  功能：生成二维码
 *  MJQ:代表我自己的名字的大写
 *  QR_Code：表示二维码
 *  generate:表示生成
 *  通过该类的方法，获取的是 二维码 UIImage 对象
 *  
 *  如果需要用到含图像的二维码：里面的icon的size 默认为（80，80）Radius 为 8，如需改动，请调用第三个方法中，当二维码的UIImageView size改变时，icon 会按比例放缩
 */
@interface MJQQRCodeGenerate : NSObject


/* 普通的二维码：不含图像
 * Generate QRCode
 * @param imageRect , which is what size(CGRect) you want
 * @param dataString, is data string which could wrap into QR Code image
 **/
- (UIImage *)generateQuickResponseCodeWithFrame:(CGRect)imageRect dataString:(NSString *)dataString
 NS_AVAILABLE_IOS(7_0);

/* 普通的二维码：含图像
 * Generate QRCode with a center icon
 * @param imageRect ,   which is what size(CGRect) you want
 * @param dataString,   is data string which could wrap into QR Code image
 * @param image,        which is center icon amidst of the image
 **/
- (UIImage *)generateQuickResponseCodeWithFrame:(CGRect)imageRect dataString:(NSString *)dataString centerImage:(UIImage *)image NS_AVAILABLE_IOS(7_0);

/* 普通的二维码：含图像 手动设置icon的大小 和 圆角
 * Generate QRCode with a center icon
 * @param imageRect ,   which is what size(CGRect) you want
 * @param dataString,   is data string which could wrap into QR Code image
 * @param centerImg,    which is center icon amidst of the image
 * @param centerImgSize
 * @param centerImageRadius
 **/
- (UIImage *)generateQuickResponseCodeWithFrame:(CGRect)imageRect dataString:(NSString *)dataString centerImage:(UIImage *)centerImg centerImageSize:(CGSize)centerImgSize centerImageRadius:(float)radius NS_AVAILABLE_IOS(7_0);


@end
