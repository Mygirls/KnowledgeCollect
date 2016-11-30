//
//  BYMTotpicItem.m
//  BYMFinancing
//
//  Created by Administrator on 2016/11/2.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "BYMTotpicItem.h"

@implementation BYMTotpicItem

/**
 *  自定义button 在首页中有六个button
 */
- (id)initWithFrame:(CGRect)frame
           imageUrl:(NSString *)imageUrl
              title:(NSString *)title
   placeholderImage:(UIImage *)placeholderImage

{
    self = [super initWithFrame:frame];
    if (self) {
        
        //1.创建标题图片
        _titleImageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.width - 45)/2.0, 8, 45, 45)];
        _titleImageView.layer.masksToBounds = YES;
        _titleImageView.layer.cornerRadius = 22.5;
        //图片的填充方式
        //        _titleImageView.backgroundColor = [UIColor greenColor];
        //        _titleImageView.contentMode = UIViewContentModeScaleAspectFit;
        //设置图片
        //        _titleImageView.image = [UIImage imageNamed:imageName];
        [_titleImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:placeholderImage];
        [self addSubview:_titleImageView];
        
        //2.标题文本
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _titleImageView.bottom + 6, self.width, 13)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = HMColor(51, 51, 51);
        _titleLabel.font = [UIFont systemFontOfSize:13];
        _titleLabel.text = title;
        [self addSubview:_titleLabel];
    }
    return self;
}


- (void)setImageUrl:(NSString *)imageUrl
              title:(NSString *)title
   placeholderImage:(UIImage *)placeholderImage
{
    
    [_titleImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:placeholderImage];
    _titleLabel.text = title;
    
    
}


@end
