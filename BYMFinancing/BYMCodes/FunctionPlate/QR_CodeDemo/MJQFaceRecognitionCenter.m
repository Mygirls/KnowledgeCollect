


#import "MJQFaceRecognitionCenter.h"

@implementation MJQFaceRecognitionCenter

+(NSArray *)faceImagesByFaceRecognitionWithImage:(UIImage *)image{
    
    CIContext * context = [CIContext contextWithOptions:nil];
    
    CIImage * cImage = [CIImage imageWithCGImage:image.CGImage];
    
    
    NSDictionary * param = [NSDictionary dictionaryWithObject:CIDetectorAccuracyHigh forKey:CIDetectorAccuracy];
    CIDetector * faceDetector = [CIDetector detectorOfType:CIDetectorTypeFace context:context options:param];
    
    
    NSArray * detectResult = [faceDetector featuresInImage:cImage];
    
    NSMutableArray * imagesArr = [[NSMutableArray alloc] init];
    
    for (int i = 0; i< detectResult.count; i++) {

        CIImage * faceImage = [cImage imageByCroppingToRect:[[detectResult objectAtIndex:i] bounds]];
        [imagesArr addObject:[UIImage imageWithCIImage:faceImage]];
    }
    
    return [NSArray arrayWithArray:imagesArr];
}

+(NSInteger)totalNumberOfFacesByFaceRecognitionWithImage:(UIImage *)image{
    CIContext * context = [CIContext contextWithOptions:nil];
    
    CIImage * cImage = [CIImage imageWithCGImage:image.CGImage];
    
    NSDictionary * param = [NSDictionary dictionaryWithObject:CIDetectorAccuracyHigh forKey:CIDetectorAccuracy];
    CIDetector * faceDetector = [CIDetector detectorOfType:CIDetectorTypeFace context:context options:param];
    
    
    NSArray * detectResult = [faceDetector featuresInImage:cImage];
    
    return detectResult.count;
}
/**
 CIDetector:
 前言
 CIDetecror是Core Image框架中提供的一个识别类，包括对人脸、形状、条码、文本的识别，本文主要介绍人脸特征识别。
 人脸识别功能不单单可以对人脸进行获取，还可以获取眼睛和嘴等面部特征信息。但是CIDetector不包括面纹编码提取，也就是说CIDetector只能判断是不是人脸，而不能判断这张人脸是谁的，比如说面部打卡这种功能是实现不了的。
 
 // 创建图形上下文
 CIContext * context = [CIContext contextWithOptions:nil];
 // 创建自定义参数字典
 NSDictionary * param = [NSDictionary dictionaryWithObject:CIDetectorAccuracyHigh forKey:CIDetectorAccuracy];
 // 创建识别器对象
 CIDetector * faceDetector = [CIDetector detectorOfType:CIDetectorTypeFace context:context options:param];
 
 
 我们先来看看识别器的类型都有哪些，这里我们设置的是CIDetectorTypeFace，人脸识别探测器类型
         // 人脸识别探测器类型
         CORE_IMAGE_EXPORT NSString* const CIDetectorTypeFace NS_AVAILABLE(10_7, 5_0);
         // 矩形检测探测器类型
         CORE_IMAGE_EXPORT NSString* const CIDetectorTypeRectangle NS_AVAILABLE(10_10, 8_0);
         // 条码检测探测器类型
         CORE_IMAGE_EXPORT NSString* const CIDetectorTypeQRCode NS_AVAILABLE(10_10, 8_0);
         // 文本检测探测器类型
         #if __OBJC2__
         CORE_IMAGE_EXPORT NSString* const CIDetectorTypeText NS_AVAILABLE(10_11, 9_0);
         #endif
 
 参数设置
 说完识别器的类型我们再来看看，识别器的参数设置。识别器参数的设置是以一个字典形式的参数传入的。这里的NSDictionary * param就是我们要设置的参数字典。
 
 我们这里设置了一个识别精度CIDetectorAccuracy，识别精度的值有
         // 识别精度低，但识别速度快、性能高
         CORE_IMAGE_EXPORT NSString* const CIDetectorAccuracyLow NS_AVAILABLE(10_7, 5_0);
         // 识别精度高，但识别速度慢、性能低
         CORE_IMAGE_EXPORT NSString* const CIDetectorAccuracyHigh NS_AVAILABLE(10_7, 5_0);
 
 除了精度的设置，还有CIDetectorTracking，指定使用特种跟踪，这个功能就像相机中的人脸跟踪功能。
 
 
 
 CIDetectorMinFeatureSize用于设置将要识别的特征的最小范围，也就是说小于这个范围的特征将不识别。
 @ 对于人脸检测器，这个关键字的值是一个范围从0.0……1.0的NSNumber值，这个值表示基于输入图像短边的百分比。有效值范围:0.01 <= CIDetectorMinFeatureSize <= 0.5。为这个参数设定更高值仅用于提高性能。默认值是0.15。
 @ 对于矩形探测器，这个关键字的值是一个范围从0.0……1.0的NSNumber值，这个值表示基于输入图像短边的百分比。有效值范围:0.2 <= CIDetectorMinFeatureSize <= 1.0的默认值是0.2。
 @ 对于文本探测器，这个关键字的值是一个范围从0.0……1.0的NSNumber值，这个值表示基于输入图像的高度的百分比。有效值范围:0.0 <= CIDetectorMinFeatureSize <= 1.0。默认值是10/(输入图像的高度)。
 
 CIDetectorNumberOfAngles用于设置角度的个数，值是1、3、5、7、9、11中的一个值。
 
 CIDetectorImageOrientation用于设置识别方向，值是一个从1 . .8的整型的NSNumber。如果值存在，检测将会基于这个方向进行，但返回的特征仍然是基于这些图像的。
 
 CIDetectorEyeBlink如果设置这个参数为true(bool类型的NSNumber)，识别器将提取眨眼特征。
 
 DetectorSmile如果设置这个参数为ture(bool类型的NSNumber)，识别器将提取微笑特征。
 
 CIDetectorFocalLength用于设置每帧焦距，值得类型为floot类型的NSNumber
 
 CIDetectorAspectRatio用于设置矩形的长宽比，值得类型为floot类型的NSNumber
 
 CIDetectorReturnSubFeatures控制文本检测器是否应该检测子特征。默认值是否，值的类型为bool类型的NSNumber
 
 
 
 使用实例
 进行识别的函数如下
         - (CI_ARRAY(CIFeature*) *)featuresInImage:(CIImage *)image
         NS_AVAILABLE(10_7, 5_0);
         - (CI_ARRAY(CIFeature*) *)featuresInImage:(CIImage *)image
         options:(nullable CI_DICTIONARY(NSString*,id) *)options
         NS_AVAILABLE(10_8, 5_0);
 
 
 
 
 */

@end
