//
//  MJQQRCodeScanCamera.m
//  QR_CodeDemo
//
//  Created by administrator on 2016/11/11.
//  Copyright © 2016年 BYM. All rights reserved.
//

#import "MJQQRCodeScanCamera.h"

@implementation MJQQRCodeScanCamera


- (void )ScanCameraPhotoGetCIQRCodeFeatureByImage:(UIImage *)img
                                       completion:(QRCodeScanCameraCompletionBlock)completion
{
    UIImage *image = img;
    CIImage *ciImage = [CIImage imageWithCGImage:[image CGImage]];
    /** UIImage --> CIImage(两种方法都可以)
     NSData *imageData = UIImagePNGRepresentation(image);
     CIImage *ciImage = [CIImage imageWithData:imageData];
     */
    
    /**  创建探测器
     初始化CIDetector,选择类型为CIDetectorTypeQRCode，自动解析二维码类型的数据根据初始化时的类型，数组中存放相对应的数据，我这选择类型为CIDetectorTypeQRCode，返回的数据类型即为CIQRCodeFeature,
     feature.messageString即我们需要的数据了，通过它就能跳转到对应的网页了
     
     注意：CIDetectorAccuracyLow／CIDetectorAccuracyHigh 这里要用CIDetectorAccuracyLow，否则识别不了
     然后便利数组：得到一个字符串
     if (features.count>0) {
         //取出探测到的数据
         for (CIQRCodeFeature *result in features) {
             content = result.messageString;
             NSLog(@"%@",result);
         }
     }
     */
    NSString *stringValue = @"" ;
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{ CIDetectorAccuracy : CIDetectorAccuracyLow }];
    NSArray *features = [detector featuresInImage:ciImage];
    if (features.count>0) {
        //取出探测到的数据
        for (CIQRCodeFeature *result in features) {
            stringValue = result.messageString;
            completion(stringValue);
        }
        
    }else{
        [[[UIAlertView alloc] initWithTitle:nil message:@"未发现二维码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil] show];
    }

}

/**
 *判断用户是否有权限访问相册
 */
- (BOOL)canAccessCamera
{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        return NO;  //无权限
    }
    return YES;
}


@end
