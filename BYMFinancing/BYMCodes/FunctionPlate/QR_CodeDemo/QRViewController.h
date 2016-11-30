//
//  QRViewController.h
//  yeeaoobox
//
//  Created by yeeaoo on 15/5/11.
//  Copyright (c) 2015年 com.yeeaoo. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^QRCodeCompletionBlock)(NSString *url);




@interface QRViewController : UIViewController

@property (nonatomic, copy) QRCodeCompletionBlock completionBlock;

- (void)torchOnOrOff;

@end
