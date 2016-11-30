//
//  RecommendationMeddleView.m
//  BYMFinancing
//
//  Created by Administrator on 2016/11/2.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "RecommendationMeddleView.h"
#import "SpecialRecommendationView.h"

@interface RecommendationMeddleView ()

@property (nonatomic, strong) SpecialRecommendationView *slRViewOne;
@property (nonatomic, strong) SpecialRecommendationView *slRViewTwo;
@property (nonatomic, strong) SpecialRecommendationView *slRViewThree;

@end
@implementation RecommendationMeddleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        /**
         * 创建三个cellView
         *
         */
        [self creatViews];
    }
    return self;
}
- (void)creatViews
{
    UIView *linView = [[UIView alloc]initWithFrame:CGRectMake(0, 6, 1, 26)];
    linView.backgroundColor = [UIColor redColor];
    [self addSubview:linView];
    
    UILabel *titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, KScreen_Width, 76/2.0)];
    titlelabel.textColor = HMColor(128, 128, 128);
    titlelabel.font = [UIFont systemFontOfSize:15];
    titlelabel.textAlignment = NSTextAlignmentLeft;
    titlelabel.text = @"特别推荐";
    [self addSubview:titlelabel];
    
    _slRViewOne = [[SpecialRecommendationView alloc]init];
    _slRViewOne.frame = CGRectMake(0,76/2.0  , KScreen_Width ,110 );
    _slRViewOne.backgroundColor = [UIColor whiteColor];
    [self addSubview:_slRViewOne];
    
    _slRViewTwo = [[SpecialRecommendationView alloc]init];
    _slRViewTwo.frame = CGRectMake(0,76/2.0+ 110 , KScreen_Width ,110 );
    _slRViewTwo.backgroundColor = [UIColor whiteColor];
    [self addSubview:_slRViewTwo];
    
    _slRViewThree = [[SpecialRecommendationView alloc]init];
    _slRViewThree.frame = CGRectMake(0,76/2.0 + 110 * 2 , KScreen_Width ,110 );
    _slRViewThree.backgroundColor = [UIColor whiteColor];
    [self addSubview:_slRViewThree];
    
    for (int i = 0; i < 3; i ++) {
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 76/2.0 + i * 110, KScreen_Width   , 0.5)];
        lineView.backgroundColor = HMColor(229, 229, 229);
        [self addSubview:lineView];
    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(translationTap:)];
    [self addGestureRecognizer:tap];

}

- (void)translationTap:(UITapGestureRecognizer *)tap
{
    CGPoint point = [tap locationInView:self];
    float pointY = point.y;
    NSInteger index = 0;
    if (pointY < 76/2.0) {//特别推荐
    }else if (pointY < 76/2.0+ 110) {//特别推荐
//        [TalkingData trackEvent:@"首页" label:@"特别推荐1"];
        index = 0;
    }else if (pointY < 76/2.0+ 110 * 2) {//特别推荐
//        [TalkingData trackEvent:@"首页" label:@"特别推荐2"];
        index = 1;
        
    }else if (pointY < 76/2.0+ 110 * 3) {//特别推荐
//        [TalkingData trackEvent:@"首页" label:@"特别推荐3"];
        index = 2;
        
    }else {// 其他
        
    }
    
    NSDictionary *dic = _productList[index];
//    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    if (appDelegate.status == 0) {
//        TotTopicRecommendViewController *vc = (TotTopicRecommendViewController *)self.viewController;
//        [vc showHUD:@"网络或服务器异常"];
//        [vc hideHUD:@"网络或服务器异常"];
//        
//    }else {
//        NSString *productType = [dic objectForKey:@"productType"];
//        NSString *productID = [dic objectForKey:@"id"];
//        NSString *title = [dic objectForKey:@"title"];
//        
//        NSUserDefaults *userDefulats = [NSUserDefaults standardUserDefaults];
//        [userDefulats setObject:productType forKey:@"productType"];
//        [userDefulats setObject:productID forKey:@"productID"];
//        [userDefulats synchronize];
//        
//        if ([productType isEqualToString:@"0"]|| [productType isEqualToString:@"1"]) {
//            ProductDetailViewController *productDetailVC = [[ProductDetailViewController alloc] init];
//            productDetailVC.productID = productID;
//            productDetailVC.productTitle = title;
//            [self.viewController.navigationController pushViewController:productDetailVC animated:YES];
//            
//        }else if ([productType isEqualToString:@"2"]){
//            FundProductDetailViewController *fundProductDetailView = [[FundProductDetailViewController alloc] init];
//            fundProductDetailView.productID = productID;
//            fundProductDetailView.productTitle = title;
//            [self.viewController.navigationController pushViewController:fundProductDetailView animated:YES];
//        }
//    }
    
}


- (void)setProductList:(NSArray *)productList
{
    _productList = productList;
    for (int i = 0; i < productList.count; i ++) {
        NSDictionary *dic = productList[i];
        if (i == 0) {
            _slRViewOne.obj   = dic;
            
        }else if (i == 1) {
            _slRViewTwo.obj   = dic;
            
        }else if (i == 2) {
            _slRViewThree.obj = dic;
        }
    }
}
@end
