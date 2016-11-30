//
//  MyGradeViewController.m
//  BYMFinancing
//
//  Created by Administrator on 2016/11/8.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "MyGradeViewController.h"
#import "UnderstandingLevelPrivilegeViewController.h"
#import "MyGradeHeadView.h"
#import "KACircleProgressView.h"


#define  TotalProductCost(productCost,money,value) (productCost-100*(value))/(money*100)
@interface MyGradeViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIView               *secondView;
@property (nonatomic, strong) UIView               *threeView;
@property (nonatomic, strong) UIView               *fourView;

@property (nonatomic, strong) UIView               *coverView;      //等级规格说明试图
@property (nonatomic, strong) UIScrollView         *scrollView;
@property (nonatomic, strong) KACircleProgressView *progress;
@property (nonatomic, strong) NSMutableArray       *dataArr;
@property (nonatomic, assign) NSInteger            index;           // 记录当前等级
@property (nonatomic, assign) CGFloat              precent;         // 记录当前等级下的投资比例
@property (nonatomic, strong) UILabel              *detailsLabel;   //当前享有等级特权
@property (nonatomic, strong) NSArray              *listArr;


@end

@implementation MyGradeViewController


- (NSMutableArray *)dataArr{
    
    if (!_dataArr) {
        _dataArr = [@[@"暂不享有等级特权",@"升级为V1会员：系统即刻自动赠送500个喵币",@"升级为V2会员：系统即刻自动赠送1000个喵币",@"升级为V3会员：系统即刻自动赠送2500个喵币，系统自动加息0.1%",@"升级为V4会员：系统即刻自动赠送4000个喵币；系统自动加息0.2%；享生日祝福及生日大礼包（888元投资券）",@"升级为V5会员：系统即刻自动赠送6000个喵币；系统自动加息0.3%；享生日祝福及生日大礼包（1888元投资券）；累计签到额外奖励喵币翻倍（详情见签到页面说明）",@"升级为V6会员：系统即刻自动赠送8000个喵币；系统自动加息0.4%；享生日祝福及生日大礼包（2888元投资券）；累计签到额外奖励喵币翻倍（详情见签到页面说明）",@"升级为V7会员：系统即刻自动赠送10000个喵币；系统自动加息0.5%；享生日祝福及生日大礼包（3888元投资券）；累计签到额外奖励喵币翻倍（详情见签到页面说明）"]mutableCopy];
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [super _initViewBackItem];
    
    self.title = @"我的等级";
    self.lineHad = YES;
    [self _initNavgationWithItem];
    
}

-(KACircleProgressView *)progress{
    if (!_progress) {
        CGFloat width = 125*KScreen_Width/320;
        _progress = [[KACircleProgressView alloc] initWithFrame:CGRectMake((KScreen_Width-width)/2.0, 24*KScreen_Width/320, width, width)];
        _progress.trackColor = HMColor(238, 236, 239);
        _progress.progressColor = HMColor(247, 69, 69);
        _progress.progressWidth = 8.0f;
    }
    return _progress;
}

- (void)_initNavgationWithItem{
    
    UIButton *rightItem = [UIButton buttonWithType:UIButtonTypeCustom];
    rightItem.frame = CGRectMake(0, 0, 40, 20);
    [rightItem setTitleColor:HMColor(51, 51, 51) forState:UIControlStateNormal];
    [rightItem setTitle:@"规则" forState:UIControlStateNormal];
    rightItem.titleLabel.font = BYM_LabelFont(15);
    [rightItem addTarget:self action:@selector(rightItemAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem  *rightButton= [[UIBarButtonItem alloc] initWithCustomView:rightItem];
    self.navigationItem.rightBarButtonItem = rightButton;
}

- (void)addScrollerView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, KScreen_Width , KScreen_Height-64)];
        _scrollView.delegate = self;
        _scrollView.contentSize = CGSizeMake(KScreen_Width , KScreen_Height );
        _scrollView.showsVerticalScrollIndicator = YES;
        _scrollView.backgroundColor = HMColor(238, 236, 239);
    }
    [self.view addSubview:_scrollView];
}
-(void)setDic:(NSDictionary *)dic
{
    _dic = dic;
    _index =[[dic objectForKey:@"level"] integerValue];
    
    [self addScrollerView];
    [self addAllSubviews];
    
}
#pragma mark - 添加_scrollView子试图
- (void)addAllSubviews{
    MyGradeHeadView *gradesHeadView = [[MyGradeHeadView alloc]initWithFrame:CGRectMake(0, 0, KScreen_Width, 162*KScreen_Width/320)];
    gradesHeadView.dic = _dic;
    [_scrollView addSubview:gradesHeadView];
    
    
    if (!_secondView) {
        _secondView = [[UIView alloc]initWithFrame:CGRectMake(0, gradesHeadView.bottom+5*KScreen_Width/320, KScreen_Width, 40)];
        _secondView.backgroundColor = [UIColor whiteColor];
        [_scrollView addSubview:self.secondView];
        [self creatSecondViewSubview];
    }
    
    
    if (!_threeView) {
        _threeView = [[UIView alloc]initWithFrame:CGRectMake(0, _secondView.bottom+5*KScreen_Width/320, KScreen_Width, 100)];
        _threeView.backgroundColor = [UIColor whiteColor];
        [_scrollView addSubview:self.threeView];
        
        [self.threeView addSubview:self.progress];
        [self creatThreeViewSubview];
        
        _progress.progress = _precent;
        _progress.nextLevel = _index;
        _threeView.height = _progress.bottom+13+(16+10)*KScreen_Width/320;
    }
    gradesHeadView.value = _precent;                            /** 修改我的等级进度 */
    
    
    if (!_fourView) {
        _fourView = [[UIView alloc]initWithFrame:CGRectMake(0, _threeView.bottom+5*KScreen_Width/320, KScreen_Width, 44*KScreen_Width/320)];
        _fourView.backgroundColor = [UIColor whiteColor];
        [_scrollView addSubview:self.fourView];
        [self creatFourViewSubview];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
        [_fourView addGestureRecognizer:tap];
    }
    
    if (_scrollView.height < _fourView.bottom) {                /** 更新scrollview的frame  */
        _scrollView.contentSize = CGSizeMake(KScreen_Width, _fourView.bottom+44);
    }
}

- (void)creatSecondViewSubview{
    
    UILabel *currentlabel = [[UILabel alloc]initWithFrame:CGRectMake(8*KScreen_Width/320, 10*KScreen_Width/320, KScreen_Width, 15)];
    currentlabel.font = BYM_LabelFont(14);
    currentlabel.backgroundColor = [UIColor clearColor];
    currentlabel.textColor = HMColor(51, 51, 51);
    currentlabel.text = @"当前等级特权";
    [_secondView addSubview:currentlabel];
    
    
    _listArr = [[NSArray alloc]init];
    _listArr = [self.dataArr[_index] componentsSeparatedByString:@"；"];
    NSMutableArray *cellArray = [[NSMutableArray alloc]init];    /**  用来存储所有_detailsLabel对象  */
    for (NSInteger i =0; i <_listArr.count; i++) {
        UIView *imageView = [[UIView alloc]initWithFrame:CGRectMake(10, 35*KScreen_Width/320, 4, 4)];
        [imageView.layer setCornerRadius:imageView.frame.size.width/2.0];
        imageView.backgroundColor = HMColor(247, 69, 69);
        [_secondView addSubview:imageView];
        CGSize size =[self sizeForString:_listArr[i] andWidth:KScreen_Width-(20+10*KScreen_Width/320) andFont:BYM_LabelFont(12)];
        CGSize size1 = [self sizeForString:@"白羊" andWidth:KScreen_Width-imageView.right-10 andFont:BYM_LabelFont(12)];                       /** 获取到只有一行label的高度 */
        
        imageView.top =35*KScreen_Width/320+(size1.height-4)/2.0;
        
        _detailsLabel = [[UILabel alloc]initWithFrame:CGRectMake(imageView.right+6, 35*KScreen_Width/320, KScreen_Width-(20+10*KScreen_Width/320), size.height+5)];
        _detailsLabel.numberOfLines = 0;
        _detailsLabel.backgroundColor = [UIColor clearColor];
        _detailsLabel.font = BYM_LabelFont(12);
        _detailsLabel.textColor = HMColor(51, 51, 51);
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:_listArr[i]];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:5];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [_listArr[i] length])];
        _detailsLabel.attributedText = attributedString;
        [_secondView addSubview:self.detailsLabel];
        
        if ( i > 0 ) {                                          /** 更新label和imageView的frame  */
            UILabel *label = [cellArray lastObject];            /** 获取上一个label对象  */
            _detailsLabel.top = label.bottom+(27*KScreen_Width/320-size1.height)/2.0 ;
            
            imageView.top = _detailsLabel.top+(size1.height-4)/2.0;
        }
        [cellArray addObject:_detailsLabel];
    }
    _secondView.height = _detailsLabel.bottom+20;
}

- (void)creatThreeViewSubview{
    
    UILabel *threeViewBottomLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _progress.bottom+16*KScreen_Width/320, KScreen_Width, 13)];
    threeViewBottomLabel.font = BYM_LabelFont(12);
    threeViewBottomLabel.textAlignment = NSTextAlignmentCenter;
    threeViewBottomLabel.textColor = HMColor(51, 51, 51);
    threeViewBottomLabel.backgroundColor = [UIColor clearColor];
    
    NSString *totalInvestMoneyStr = [NSString stringWithFormat:@"%@",[ self.dic objectForKey:@"totalInvestMoney"]];
    if ([totalInvestMoneyStr isEqualToString:@"(null)"] ||[totalInvestMoneyStr isEqualToString:@"<null>"]||totalInvestMoneyStr==nil) {
        totalInvestMoneyStr = @"0";
    }
    NSInteger totalInvest =[totalInvestMoneyStr integerValue];
    switch (_index) {
        case 0:
            _precent = TotalProductCost(totalInvest,100000.0,0);
            threeViewBottomLabel.text = [NSString stringWithFormat:@"距升级还需投资￥%ld",100000-TotalProductCost(totalInvest,1,0)];
            break;
        case 1:
            _precent = TotalProductCost(totalInvest,400000.0,100000);
            threeViewBottomLabel.text = [NSString stringWithFormat:@"距升级还需投资￥%ld",500000-TotalProductCost(totalInvest,1,0)];
            break;
        case 2:
            _precent = TotalProductCost(totalInvest,1500000.0,500000);
            threeViewBottomLabel.text = [NSString stringWithFormat:@"距升级还需投资￥%ld",2000000-TotalProductCost(totalInvest,1,0)];
            break;
        case 3:
            _precent = TotalProductCost(totalInvest,2000000.0,2000000);
            threeViewBottomLabel.text = [NSString stringWithFormat:@"距升级还需投资￥%ld",4000000-TotalProductCost(totalInvest,1,0)];
            break;
        case 4:
            _precent = TotalProductCost(totalInvest,3000000.0,4000000);
            threeViewBottomLabel.text = [NSString stringWithFormat:@"距升级还需投资￥%ld",7000000-TotalProductCost(totalInvest,1,0)];
            break;
        case 5:
            _precent = TotalProductCost(totalInvest,5000000.0,7000000);
            threeViewBottomLabel.text = [NSString stringWithFormat:@"距升级还需投资￥%ld",12000000-TotalProductCost(totalInvest,1,0)];
            break;
        case 6:
            _precent = TotalProductCost(totalInvest,8000000.0,12000000);
            threeViewBottomLabel.text = [NSString stringWithFormat:@"距升级还需投资￥%ld",20000000-TotalProductCost(totalInvest,1,0)];
            break;
        case 7:
            _precent = 0;
            break;
        default:
            break;
    }
    
    [_threeView addSubview:threeViewBottomLabel];
    
}

- (void)creatFourViewSubview{
    
    UIImageView *imageViewVip = [[UIImageView alloc]initWithFrame:CGRectMake(10*KScreen_Width/320, (44*KScreen_Width/320-17)/2.0, 18, 17)];
    imageViewVip.image = [UIImage imageNamed:@"vip_icon"];
    [_fourView addSubview:imageViewVip];
    UIImageView *imageViewRight = [[UIImageView alloc]initWithFrame:CGRectMake(KScreen_Width - 10*KScreen_Width/320, (44*KScreen_Width/320-13)/2.0, 8, 13)];
    imageViewRight.image = [UIImage imageNamed:@"tx_xy"];
    [_fourView addSubview:imageViewRight];
    UILabel *understeerlabel = [[UILabel alloc]initWithFrame:CGRectMake(imageViewVip.right+3*KScreen_Width/320, (44*KScreen_Width/320-15)/2.0, 100, 15)];
    understeerlabel.font = BYM_LabelFont(14);
    understeerlabel.textColor = HMColor(51, 51, 51);
    understeerlabel.text = @"了解等级特权";
    [_fourView addSubview:understeerlabel];
    
}

- (void)tap{
    UnderstandingLevelPrivilegeViewController *ULPCtr = [[UnderstandingLevelPrivilegeViewController alloc]init];
    ULPCtr.level = _index;
    [self.navigationController pushViewController:ULPCtr animated:YES];
}

- (void)rightItemAction:(UIButton *)rightButton{
    
    _coverView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreen_Width, KScreen_Height)];
    _coverView.backgroundColor = [UIColor colorWithRed:45/255.0 green:52/255.0 blue:62/255.0 alpha:0.95];
    [[[UIApplication sharedApplication].delegate window]  addSubview:_coverView];
    [self exChangeOut:_coverView dur:0.5];
    UIScrollView *scorllView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0,  KScreen_Width,KScreen_Height )];
    scorllView.backgroundColor = [UIColor colorWithRed:255 green:255 blue:255 alpha:0];
    [_coverView addSubview:scorllView];
    scorllView.contentSize = CGSizeMake(KScreen_Width, KScreen_Height + 20);
    
    UIImageView *ruleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -40, KScreen_Width, 568)];
    ruleImageView.image = [UIImage imageNamed:@"norms3"];
    ruleImageView.contentMode = UIViewContentModeScaleAspectFit;
    ruleImageView.backgroundColor = [UIColor colorWithRed:255 green:255 blue:255 alpha:0.0];
    [scorllView addSubview:ruleImageView];
    
    UIButton *removeCoverButton = [UIButton buttonWithType:UIButtonTypeCustom];
    removeCoverButton.frame = CGRectMake((KScreen_Width - 24)/2.0, (KScreen_Height - 80), 24, 24);
    [removeCoverButton setBackgroundImage:[UIImage imageNamed:@"del_icon"] forState:UIControlStateNormal];
    [removeCoverButton addTarget:self action:@selector(removeCoverButton:) forControlEvents:UIControlEventTouchUpInside];
    [_coverView addSubview:removeCoverButton];}


- (void)removeCoverButton:(UIButton *)removeCoverButton
{
    [_coverView removeFromSuperview];

}

- (void)exChangeOut:(UIView *)changeOutView dur:(CFTimeInterval)dur
{
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    animation.duration = dur;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    NSMutableArray *values = [NSMutableArray array];
    
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    
    animation.values = values;
    animation.timingFunction = [CAMediaTimingFunction functionWithName: @"easeInEaseOut"];
    
    [changeOutView.layer addAnimation:animation forKey:nil];
}

- (void)backItemAction:(UIButton *)backButton
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - 根据NSString的宽度和文字大小来计算label的区域
- (CGSize)sizeForString:(NSString *)str andWidth:(CGFloat)width andFont:(UIFont *)font
{
    return [str boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil].size;
}

@end
