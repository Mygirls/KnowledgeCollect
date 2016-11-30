//
//  QRViewController.m
//  yeeaoobox
//
//  Created by yeeaoo on 15/5/11.
//  Copyright (c) 2015年 com.yeeaoo. All rights reserved.
//

#import "QRViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "QRView.h"
@interface QRViewController ()<AVCaptureMetadataOutputObjectsDelegate,QRViewDelegate>

//是展示如何使用  AVFoundation 来进行二维码扫描，更主要的是限制扫描二维码的范围。（因为默认的是全屏扫描）
//苹果原生的扫描。

//代表抽象的硬件设备
@property (strong, nonatomic) AVCaptureDevice * device;

//代表输入设备（可以是它的子类），它配置抽象硬件设备的ports
@property (strong, nonatomic) AVCaptureDeviceInput * input;

//它代表输出数据，管理着输出到一个movie或者图像
@property (strong, nonatomic) AVCaptureMetadataOutput * output;

//它是input和output的桥梁。它协调着intput到output的数据传输
@property (strong, nonatomic) AVCaptureSession * session;
@property (strong, nonatomic) AVCaptureVideoPreviewLayer * preview;

@end

@implementation QRViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"扫一扫";
    self.view.backgroundColor = [UIColor whiteColor];
    [self createQRCode];
}

/*
 有很多Device的input，也有很多数据类型的Output，都通过一个Capture Session来控制进行传输。
 也即：CaptureDevice适配AVCaptureInput，通过Session来输入到AVCaptureOutput中。
 这样也就达到了从设备到文件等持久化传输的目的（如从相机设备采集图像到UIImage中）。
 // 条码类型 AVMetadataObjectTypeQRCode
 //    _output.metadataObjectTypes =@[AVMetadataObjectTypeQRCode];
 
 //增加条形码扫描:二者之间metadataObjectTypes 用于切换
 */
- (void)createQRCode
{
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (_device) {
        _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
        _output = [[AVCaptureMetadataOutput alloc]init];
        [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        _session = [[AVCaptureSession alloc]init];
        [_session setSessionPreset:AVCaptureSessionPresetHigh];
        if ([_session canAddInput:self.input]){
            [_session addInput:self.input];
        }
        
        if ([_session canAddOutput:self.output]){
            [_session addOutput:self.output];
        }
        _output.metadataObjectTypes = @[AVMetadataObjectTypeEAN13Code,
                                        AVMetadataObjectTypeEAN8Code,
                                        AVMetadataObjectTypeCode128Code,
                                        AVMetadataObjectTypeQRCode];
        
        _preview =[AVCaptureVideoPreviewLayer layerWithSession:_session];
        _preview.videoGravity =AVLayerVideoGravityResize;
        _preview.frame =self.view.layer.bounds;
        [self.view.layer insertSublayer:_preview atIndex:0];
        [_session startRunning];
    }
    
#pragma mark - 二维码还中心的那个小方块，
    CGRect screenRect = [UIScreen mainScreen].bounds;
    QRView *qrRectView = [[QRView alloc] initWithFrame:screenRect];
    qrRectView.transparentArea = CGSizeMake(220, 220);
    qrRectView.backgroundColor = [UIColor clearColor];
    qrRectView.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2);
    qrRectView.delegate = self;
    [self.view addSubview:qrRectView];
    
    
    //修正扫描区域
    CGFloat screenHeight = self.view.frame.size.height;
    CGFloat screenWidth = self.view.frame.size.width;
    CGRect cropRect = CGRectMake((screenWidth - qrRectView.transparentArea.width) / 2,
                                 (screenHeight - qrRectView.transparentArea.height) / 2,
                                 qrRectView.transparentArea.width,
                                 qrRectView.transparentArea.height);
    //设置每一帧画面感兴趣的区域（字面意思），那岂不是就是设置扫描范围喽，大喜
    //区域的原点在左上方（后面才知道坑苦我了！），然后区域是相对于设备的大小的，默认值是 CGRectMake(0, 0, 1, 1) ，这时候我才知道是有比例关系的，最大值才是1，也就是说只要除以相应的设备宽和高的大小不就行了？然后就改成
    [_output setRectOfInterest:CGRectMake(cropRect.origin.y / screenHeight,
                                          cropRect.origin.x / screenWidth,
                                          cropRect.size.height / screenHeight,
                                          cropRect.size.width / screenWidth)];
    
}

#pragma mark QRViewDelegate<切换到  条形码 扫描>
-(void)scanTypeConfig:(QRItem *)item {
    
    if (item.type == QRItemTypeQRCode) {
        _output.metadataObjectTypes =@[AVMetadataObjectTypeQRCode];
        
    } else if (item.type == QRItemTypeOther) {
        
        _output.metadataObjectTypes = @[AVMetadataObjectTypeEAN13Code,
                                        AVMetadataObjectTypeEAN8Code,
                                        AVMetadataObjectTypeCode128Code,
                                        AVMetadataObjectTypeQRCode];
    }
}
#pragma mark AVCaptureMetadataOutputObjectsDelegate <扫描结束后返回的结构>
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    [_session stopRunning];

    NSString *stringValue;
    if ([metadataObjects count] >0){
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;        
    }
    if (self.completionBlock) {
        self.completionBlock(stringValue);
    }
    
    [self dismissController];
}

- (void)dismissController
{
    if ([self.navigationController.childViewControllers lastObject] == self) {
        [self.navigationController popViewControllerAnimated:false];
    } else {
        [self dismissViewControllerAnimated:false completion:^{}];
    }
}

#pragma mark The switch , turn On or Off
- (void)torchOnOrOff
{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    [device lockForConfiguration:nil];
    if (device.torchMode == AVCaptureTorchModeOff) {
        [device setTorchMode: AVCaptureTorchModeOn];
    }else{
        [device setTorchMode: AVCaptureTorchModeOff];
    }
    [device unlockForConfiguration];
}

//成功后的声音与振动效果，提高用户体验
- (void)playBeep{
    SystemSoundID soundID;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"滴-2"ofType:@"mp3"]], &soundID);
    AudioServicesPlaySystemSound(soundID);
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}
@end
