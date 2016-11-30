//
//  HomebottomView.m
//  BYMFinancing
//
//  Created by Administrator on 2016/11/2.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "HomebottomView.h"
#import "RiskViewController.h"
#import "ProtectViewController.h"
#import "AboutBaiYiMaoViewController.h"
@implementation HomebottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        /**
         * 首页底部三个视图： 风控解读 安全保障  关于百亿猫
         *
         */
        float width = (KScreen_Width - 40)/3.0;
        NSArray *imageNames = @[@"know",@"safety",@"information"];
        NSArray *titles = @[@"风控解读",@"安全保障",@"关于佰亿猫"];
        for (int i = 0; i < 3; i ++) {
            UIImageView *imageView = [[ UIImageView alloc]initWithFrame:CGRectMake(10 + i * width  + i * 10, 0, width, width/2.0)];
            imageView.userInteractionEnabled = YES;
            imageView.image = [UIImage imageNamed:imageNames[i]];
            [self addSubview:imageView];
            
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, (imageView.height - 13)/2.0, imageView.width, 13)];
            label.text = titles[i];
            label.textColor = HMColor(255, 255, 255);
            label.font = [UIFont systemFontOfSize:13];
            [imageView addSubview:label];
            label.textAlignment = NSTextAlignmentCenter;
            
            UITapGestureRecognizer *bottomViewTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bottomTap:)];
            [self addGestureRecognizer:bottomViewTap];
        }
    }
    return self;
}

- (void)bottomTap:(UITapGestureRecognizer *)bottomViewTap
{
    CGPoint point = [bottomViewTap locationInView:self];
    float width = (KScreen_Width - 40)/3.0;
    
    if (point.x > 10  && point.x < width + 10 ) {//风控解读
//        [TalkingData trackEvent:@"首页" label:@"风控解读"];
        RiskViewController *risk = [[RiskViewController alloc] init];
        [self.viewController.navigationController pushViewController:risk animated:YES];
        
    }else if (point.x > width + 20  && point.x < width * 2 + 20  ) {//安全保障
//        [TalkingData trackEvent:@"首页" label:@"安全保障"];
        ProtectViewController *protectVC = [[ProtectViewController alloc]init];
        [self.viewController.navigationController pushViewController:protectVC animated:YES];
        
    }else if (point.x > width * 2 + 30  && point.x < width * 3 + 30  ) {//关于百亿猫
//        [TalkingData trackEvent:@"首页" label:@"关于百亿猫"];
        AboutBaiYiMaoViewController *aboutBYMVC = [[AboutBaiYiMaoViewController alloc]init];
        [self.viewController.navigationController pushViewController:aboutBYMVC animated:YES];
    }
}
@end
