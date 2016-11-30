//
//  BYMDefinition.h
//  BYMFinancing
//
//  Created by Administrator on 2016/11/2.
//  Copyright © 2016年 mac. All rights reserved.
//

/**
 *  注意：宏的命名以 BYM 开头
 */

#ifndef BYMDefinition_h
#define BYMDefinition_h


/**
 *单例：NSUserDefaults
 */
#define BYM_UserDefulats [NSUserDefaults standardUserDefaults]

/**
 * 通知中心
 */
#define BYM_NotificationCenter [NSNotificationCenter defaultCenter]

/**
 *  弱指针
 */
#define BYM_WeakSelf(weakSelf)  __weak __typeof(&*self)weakSelf = self;

/**
 * 屏幕的宽高
 */
#define KScreen_Width  [UIScreen mainScreen].bounds.size.width
#define KScreen_Height [UIScreen mainScreen].bounds.size.height

/**
 * 随机色
 */
#define HMColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define BYM_testColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0  blue:arc4random_uniform(255)/255.0  alpha:1.0]
/**
 * 本地路径
 */
#define pathFile [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/firstAnimation7.plist"]


#define ZPRealValue(value) ((value)/320.0f*[UIScreen mainScreen].bounds.size.width)


#define DirectAndSourceVCDescription @"directAndSourceVCDescription"

/**
 * 判断版本
 */
#define IOS_VERSION_9_OR_ABOVE (([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)? (YES):(NO))
#define IOS_VERSION_8_OR_ABOVE (([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)? (YES):(NO))

/**
 * 字体大小
 */
#define BYM_LabelFont(size)  [UIFont systemFontOfSize:size]
#define BYM_multableLabelFont(size)  [UIFont systemFontOfSize:size]*[UIScreen mainScreen].bounds.size.height

/**
 * 判断是不是手机
 */
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_6PLUS (IS_IPHONE && [[UIScreen mainScreen] scale] == 3.0f)










/**
 * 提示语
 */
#define holderColor [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0]

/**
 * 边框
 */
#define borderColor1 [UIColor colorWithRed:183/255.0 green:186/255.0 blue:191/255.0 alpha:1.0]
#define borderColor2 [UIColor colorWithRed:232/255.0 green:162/255.0 blue:63/255.0 alpha:1.0]

/**
 * 下一步button
 */
#define buttonColor1 [UIColor colorWithRed:255/255.0 green:139/255.0 blue:139/255.0 alpha:1.0]
#define buttonColor2 [UIColor colorWithRed:247/255.0 green:69/255.0 blue:69/255.0 alpha:1.0]
#define buttonFontColor1 [UIColor colorWithRed:255/255.0 green:179/255.0 blue:179/255.0 alpha:1.0]
#define buttonFontColor2 [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]



#endif /* BYMDefinition_h */
