//
//  BYMTotpicItem.h
//  BYMFinancing
//
//  Created by Administrator on 2016/11/2.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BYMTotpicItem : UIControl
{
    UIImageView *_titleImageView;
    UILabel *_titleLabel;
}
//自定义初始化方法
- (id)initWithFrame:(CGRect)frame
           imageUrl:(NSString *)imageUrl
              title:(NSString *)title
   placeholderImage:(UIImage *)placeholderImage;



- (void)setImageUrl:(NSString *)imageUrl
              title:(NSString *)title
   placeholderImage:(UIImage *)placeholderImage;

@end
