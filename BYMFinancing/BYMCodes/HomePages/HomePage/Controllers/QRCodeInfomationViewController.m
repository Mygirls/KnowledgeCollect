//
//  QRCodeInfomationViewController.m
//  BYMFinancing
//
//  Created by administrator on 2016/11/30.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "QRCodeInfomationViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "QRCode.h"

@interface QRCodeInfomationViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    UITextView *textView;
    
    
}
@property(nonatomic,strong)UIImageView *imgView1;



@end

@implementation QRCodeInfomationViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.title = @"首页";
    
    
    [self scanningQRCode];
    [self scanningCamera];
    [self imgAndTextFieldView];
    CGRect rect = [UIScreen mainScreen].bounds;
    CGFloat w = rect.size.width;
    CGFloat h = w;
    CGFloat y = (rect.size.height - h) / 2;
    CGRect rect_target = CGRectMake(0, y, w, h);
    MJQQRCodeGenerate *qrCode = [[MJQQRCodeGenerate alloc]init];
    UIImage *myImage = [qrCode generateQuickResponseCodeWithFrame:rect_target dataString:@"https://www.baidu.com"];
    //    UIImage *myImage = [qrCode generateQuickResponseCodeWithFrame:rect_target dataString:@"https://www.baidu.com" centerImage:[UIImage imageNamed:@"logo"] ];
    
    //    UIImage *myImage = [qrCode generateQuickResponseCodeWithFrame:rect_target dataString:@"https://www.baidu.com" centerImage:[UIImage imageNamed:@"logo"] centerImageSize:CGSizeMake(80, 80) centerImageRadius:8 ];
    self.imgView1.image =  myImage;
    
    
    
    UILongPressGestureRecognizer * longPressGr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressToDo:)];
    longPressGr.minimumPressDuration = 1.0;
    [self.view addGestureRecognizer:longPressGr];
}


- (void)longPressToDo:(UILongPressGestureRecognizer * )longPress
{
    UIImage *image = [UIImage imageNamed:@"QRCode"];
    MJQQRCodeScanCamera *ca = [[MJQQRCodeScanCamera alloc] init];
    [ca ScanCameraPhotoGetCIQRCodeFeatureByImage:image completion:^(NSString *strValue) {
        NSLog(@"%@",strValue);
    }];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}



- (void)imgAndTextFieldView
{
    textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 50)];
    textView.backgroundColor = [UIColor greenColor];
    textView.text = @"扫描后返回的信息";
    [self.view addSubview:textView];
    
    _imgView1 = [[UIImageView alloc]initWithFrame:CGRectMake(50, 150, 200, 200)];
    [self.view addSubview:_imgView1];
    _imgView1.backgroundColor = [UIColor orangeColor];
    
}

- (void)scanningQRCode
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 400, 160, 40);
    [button setTitle:@"扫一扫  " forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)buttonAction:(UIButton *)btn
{
    QRViewController *QRVC = [[QRViewController alloc] init];
    QRVC.completionBlock = ^(NSString *result) {
        
        textView.text = result;
    };
    [self presentViewController:QRVC animated:YES completion:nil];
}

- (void)scanningCamera{
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(10, 450, 160, 40);
    [button2 setTitle:@"扫一扫相册" forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(buttonAction2:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
}
- (void)buttonAction2:(UIButton *)btn
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.allowsEditing = NO;
    
    [self presentViewController:picker animated:YES completion:^{}];
    /**
     UIImagePickerControllerSourceTypePhotoLibrary：表示显示所有的照片
     UIImagePickerControllerSourceTypeCamera：表示从摄像头选取照片
     UIImagePickerControllerSourceTypeSavedPhotosAlbum：表示仅仅从相册中选取照片。
     allowEditing和allowsImageEditing 设置为YES，表示 允许用户编辑图片，否则，不允许用户编辑。
     */
    
}

#pragma mark - UIImagePickerControllerDelegate event
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    MJQQRCodeScanCamera *ca = [[MJQQRCodeScanCamera alloc] init];
    [ca ScanCameraPhotoGetCIQRCodeFeatureByImage:image completion:^(NSString *strValue) {
        NSLog(@"%@",strValue);
    }];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
