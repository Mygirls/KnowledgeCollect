//
//  MJQ_QR_Code_generate.m
//  QR_CodeDemo
//
//  Created by administrator on 2016/11/9.
//  Copyright © 2016年 BYM. All rights reserved.
//

#import "MJQQRCodeGenerate.h"
@implementation MJQQRCodeGenerate
/**
 *  NSAssert 表示断言
 */


#pragma mark - Generate QR Code
- (UIImage *)generateQuickResponseCodeWithFrame:(CGRect)imageRect dataString:(NSString *)dataString
{
    NSAssert(dataString, @"`dataString` must be non-nil!");
    return [self generateQRCodeWithFrame:imageRect dataString:dataString];
}

- (UIImage *)generateQuickResponseCodeWithFrame:(CGRect)imageRect dataString:(NSString *)dataString centerImage:(UIImage *)image
{
    NSAssert(dataString, @"`dataString` must be non-nil!");
    NSAssert(image, @"`image` must be non-nil!");
    UIImage *myImage = [self generateQRCodeWithFrame:imageRect dataString:dataString];
    if (image) {
        UIImage *iconImg = [self createRoundedRectImage:image withSize:CGSizeMake(80, 80) withRadius:8];
        myImage = [self addCenterImageWithOrigin:myImage withCGSize:CGSizeMake(80, 80) centerImage:iconImg];
    }
    return myImage;
}

- (UIImage *)generateQuickResponseCodeWithFrame:(CGRect)imageRect dataString:(NSString *)dataString centerImage:(UIImage *)centerImg centerImageSize:(CGSize)centerImgSize centerImageRadius:(float)radius
{
    NSAssert(dataString, @"`dataString` must be non-nil!");
    NSAssert(centerImg, @"`image` must be non-nil!");
    UIImage *myImage = [self generateQRCodeWithFrame:imageRect dataString:dataString];
    if (centerImg) {
        UIImage *iconImg = [self createRoundedRectImage:centerImg withSize:centerImgSize withRadius:radius];
        myImage = [self addCenterImageWithOrigin:myImage withCGSize:centerImgSize centerImage:iconImg];
    }
    return myImage;
}

/**
 *  生成不带图片的二维码：
 */
- (UIImage *)generateQRCodeWithFrame:(CGRect)imageRect dataString:(NSString *)dataString
{
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    NSData *data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKey:@"inputMessage"];
    CIImage *outputImage = [filter outputImage];
    UIImage  *image = [self createNonInterpolatedUIImageFormCIImage:outputImage withSize:imageRect.size.width];
    return image;
}

/*
 //使用核心绘图框架CG（Core Graphics）对象操作，合并二维码图片和用于中间显示的图标图片
 Whether if it needs center icon , convey `YES` in this parameter
 */
- (UIImage *)addCenterImageWithOrigin:(UIImage *)image withCGSize:(CGSize)iconSize centerImage:(UIImage *)centerImage
{
    UIGraphicsBeginImageContext(image.size);
    //通过两张图片进行位置和大小的绘制，实现两张图片的合并；其实此原理做法也可以用于多张图片的合并
    CGFloat widthOfImage = image.size.width;
    CGFloat heightOfImage = image.size.height;
    CGFloat widthOfIcon = iconSize.width;
    CGFloat heightOfIcon = iconSize.height;
    
    [image drawInRect:CGRectMake(0, 0, widthOfImage, heightOfImage)];
    [centerImage drawInRect:CGRectMake((widthOfImage-widthOfIcon)/2, (heightOfImage-heightOfIcon)/2,
                                widthOfIcon, heightOfIcon)];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

/*
 使用核心绘图框架CG（Core Graphics）对象操作，进一步针对大小生成二维码图片imgAdaptiveQRCode（图片大小适合，清晰，效果好）
 Get Image of original size through `size`
 */
- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size {
    //Get original extent size
    CGRect extent = CGRectIntegral(image.extent);
    
    //Get its scale
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    //According to the scale scope to acquire bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    
    //Create bitmap ImageRef based on `image` and `extent`
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // Saveing bitmap to UIImage in memory
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

/**
 *  使用核心绘图框架CG（Core Graphics）对象操作，创建带圆角效果的图片
 */
- (UIImage *)createRoundedRectImage:(UIImage *)image withSize:(CGSize)size withRadius:(float)radius {
    int w = size.width;
    int h = size.height;
    
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGContextRef contextRef = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpaceRef, (CGBitmapInfo)kCGImageAlphaPremultipliedFirst);
    CGRect rect = CGRectMake(0, 0, w, h);
    
    CGContextBeginPath(contextRef);
    
    //下面有两种方法 均可用：自己去选择
//    [self addRoundedRectToPathWithCGContextRef:contextRef rect:rect widthOfRadius:radius heightOfRadius:radius];  //方法1
    addRoundedRectToPath(contextRef, rect, radius, radius); //方法2

    CGContextClosePath(contextRef);
    CGContextClip(contextRef);
    CGContextDrawImage(contextRef, CGRectMake(0, 0, w, h), image.CGImage);
    CGImageRef imageMasked = CGBitmapContextCreateImage(contextRef);
    UIImage *img = [UIImage imageWithCGImage:imageMasked];
    
    CGContextRelease(contextRef);
    CGColorSpaceRelease(colorSpaceRef);
    CGImageRelease(imageMasked);
    return img;
}

static void addRoundedRectToPath(CGContextRef context, CGRect rect, float ovalWidth,
                                 float ovalHeight)
{
    float fw, fh;
    
    if (ovalWidth == 0 || ovalHeight == 0)
    {
        CGContextAddRect(context, rect);
        return;
    }
    
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextScaleCTM(context, ovalWidth, ovalHeight);
    fw = CGRectGetWidth(rect) / ovalWidth;
    fh = CGRectGetHeight(rect) / ovalHeight;
    
    CGContextMoveToPoint(context, fw, fh/2);  // Start at lower right corner
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);  // Top right corner
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1); // Top left corner
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1); // Lower left corner
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1); // Back to lower right
    
    CGContextClosePath(context);
    CGContextRestoreGState(context);
}

- (void)addRoundedRectToPathWithCGContextRef:(CGContextRef)contextRef rect:(CGRect)rect widthOfRadius:(float)widthOfRadius heightOfRadius:(float)heightOfRadius
{
    float fw, fh;
    if (widthOfRadius == 0 || heightOfRadius == 0)
    {
        CGContextAddRect(contextRef, rect);
        return;
    }
    
    CGContextSaveGState(contextRef);
    CGContextTranslateCTM(contextRef, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextScaleCTM(contextRef, widthOfRadius, heightOfRadius);
    fw = CGRectGetWidth(rect) / widthOfRadius;
    fh = CGRectGetHeight(rect) / heightOfRadius;
    
    CGContextMoveToPoint(contextRef, fw, fh/2);  // Start at lower right corner
    CGContextAddArcToPoint(contextRef, fw, fh, fw/2, fh, 1);  // Top right corner
    CGContextAddArcToPoint(contextRef, 0, fh, 0, fh/2, 1); // Top left corner
    CGContextAddArcToPoint(contextRef, 0, 0, fw/2, 0, 1); // Lower left corner
    CGContextAddArcToPoint(contextRef, fw, 0, fw, fh/2, 1); // Back to lower right
    
    CGContextClosePath(contextRef);
    CGContextRestoreGState(contextRef);
}



@end
