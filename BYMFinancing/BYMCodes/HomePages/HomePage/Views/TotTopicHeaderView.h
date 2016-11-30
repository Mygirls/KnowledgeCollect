//
//  TotTopicHeaderView.h
//  BYMFinancing
//
//  Created by Administrator on 2016/11/2.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TotTopicHeaderView : UIView

@property (nonatomic, strong)     NSArray *imageList;
@property (nonatomic,   copy)NSDictionary *notice;
@property (nonatomic, strong)     NSArray *icons;
@property (nonatomic,   copy)    NSString *inviteBackgroundUrl;
@property (nonatomic,   copy)    NSString *freshManUrl;
@property (nonatomic,   copy)    NSString *signUrl;

@end
