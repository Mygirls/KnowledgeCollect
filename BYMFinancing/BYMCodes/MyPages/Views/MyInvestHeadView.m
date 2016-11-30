//
//  MyInvestHeadView.m
//  BYMFinancing
//
//  Created by Administrator on 2016/11/4.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "MyInvestHeadView.h"

@interface MyInvestHeadView ()

/**
 * allProfitLabel总收益金额,willCountMoney待结算收益,leftMoney可用余额,totalMoney资产总额
 */
@property (nonatomic, strong) UILabel  *allProfitLabel;
@property (nonatomic, strong) UILabel  *willCountMoney;
@property (nonatomic, strong) UILabel  *leftMoney;
@property (nonatomic, strong) UILabel  *totalMoney;

@property (nonatomic, strong) UIButton *secretButton;
@property (nonatomic, strong) NSArray  *moneyDataArr;

@end

@implementation MyInvestHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatTableViewHeadView];
    }
    return self;
}
- (NSArray *)moneyDataArr
{
    if (!_moneyDataArr) {
        _moneyDataArr = [NSArray new];
        if ([[BYM_UserDefulats objectForKey:@"isSecret"] boolValue]) {
            _moneyDataArr = @[@"****",@"****",@"****",@"****"];
        } else {
            _moneyDataArr = @[@"0.00",@"0.00",@"0.00",@"0.00"];
        }
    }
    return _moneyDataArr;
}
- (void)creatTableViewHeadView
{
    _allProfitLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, KScreen_Width, 30)];
    _allProfitLabel.font = BYM_LabelFont(30);
    _allProfitLabel.textColor =  HMColor(51, 51, 51);
    _allProfitLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_allProfitLabel];
    
    UILabel *allProfit = [[UILabel alloc] initWithFrame:CGRectMake(0, 57, KScreen_Width, 12)];
    allProfit.font = BYM_LabelFont(12);
    allProfit.textColor =  HMColor(128, 128, 128);
    allProfit.textAlignment = NSTextAlignmentCenter;
    allProfit.text = @"总收益(元)";
    [self addSubview:allProfit];
    
    
    _secretButton = [[UIButton alloc] init];
    _secretButton.center = CGPointMake(KScreen_Width/2.0 + 12, 33);
    _secretButton.size =CGSizeMake(70, 60);
    _secretButton.selected = [[BYM_UserDefulats objectForKey:@"isSecret"] boolValue];
    [_secretButton setImage:[UIImage imageNamed:@"wd_zsy2"] forState:UIControlStateNormal];
    [_secretButton setImage:[UIImage imageNamed:@"wd_zsy1"] forState:UIControlStateSelected];
    [_secretButton addTarget:self action:@selector(secretButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_secretButton];
    
    _willCountMoney = [[UILabel alloc] initWithFrame:CGRectMake(0,117, KScreen_Width/3.0,15)];
    _willCountMoney.font = BYM_LabelFont(15);
    _willCountMoney.textColor =  HMColor(6, 190, 189);
    _willCountMoney.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_willCountMoney];
    
    _leftMoney = [[UILabel alloc] initWithFrame:CGRectMake(KScreen_Width/3.0,117, KScreen_Width/3.0,15)];
    _leftMoney.font = BYM_LabelFont(15);
    _leftMoney.textColor =  HMColor(6, 190, 189);
    _leftMoney.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_leftMoney];
    
    _totalMoney = [[UILabel alloc] initWithFrame:CGRectMake(2*KScreen_Width/3.0,117, KScreen_Width/3.0,15)];
    _totalMoney.font = BYM_LabelFont(15);
    _totalMoney.textColor =  HMColor(51, 51, 51);
    _totalMoney.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_totalMoney];

    
    NSArray *moneyArray = @[@"待结算收益",@"可用余额",@"资产总额"];
    NSArray *colorArray = @[@"tobeknot",@"overage",@"totalm"];
    for (int i = 0; i < 3; i++) {

        if (i==1 || i ==2) {
            UIView *seview = [[UIView alloc] initWithFrame:CGRectMake(i *KScreen_Width/3.0, 119, 0.5, 25)];
            seview.backgroundColor = HMColor(229, 229, 229);
            [self addSubview:seview];
        }
        UIButton *money = [[UIButton alloc] initWithFrame:CGRectMake(i *KScreen_Width/3.0,136, KScreen_Width/3.0,12)];
        money.imageEdgeInsets = UIEdgeInsetsMake(0, -4, 0, 0);
        UIImage *image = [UIImage imageNamed:colorArray[i]];
        [money setImage:image forState:UIControlStateNormal];
        [money setTitle:moneyArray[i] forState:UIControlStateNormal];
        [money setTitleColor:HMColor(128, 128, 128) forState:UIControlStateNormal];
        money.titleLabel.font = BYM_LabelFont(11);
        [self addSubview:money];
    }
    
}

-(void)setIsLogin:(BOOL)isLogin
{
    _isLogin = isLogin;
    
    if (_isLogin == NO) {
        _secretButton.hidden = YES;
        self.dataDic = nil;
        [BYM_UserDefulats removeObjectForKey:@"isSecret"];
    }else{
        _secretButton.hidden = NO;
    }
    [self refreshPersonalData];
}

-(void)setDataDic:(NSDictionary *)dataDic{
    _dataDic = dataDic;
    
    [self refreshPersonalData];
}

#pragma mark-UIButton处理事件方法
- (void)secretButtonClick
{
    _secretButton.selected=!_secretButton.selected;
    [BYM_UserDefulats setObject:[NSNumber numberWithBool:_secretButton.selected] forKey:@"isSecret"];
    [BYM_UserDefulats synchronize];
    
    [self refreshPersonalData];
}

- (void)refreshPersonalData
{
    NSString *allProfitStr = [NSString stringWithFormat:@"%.2f",[[NSString stringWithFormat:@"%@",[self.dataDic objectForKey:@"allProfit"]]  doubleValue] / 100];
    NSString *wfsyStr = [NSString stringWithFormat:@"%.2f",[[NSString stringWithFormat:@"%@",[self.dataDic objectForKey:@"wfsy"]]  doubleValue] / 100];
    NSString *leftMoneyStr = [NSString stringWithFormat:@"%.2f",[[NSString stringWithFormat:@"%@",[self.dataDic objectForKey:@"leftMoney"]]  doubleValue] / 100];
    NSString *totalMoneyStr = [NSString stringWithFormat:@"%.2f",[[NSString stringWithFormat:@"%@",[self.dataDic objectForKey:@"totalMoney"]]  doubleValue] / 100];
    
    if (self.dataDic ==nil) {
        if (_secretButton.selected) {
            _moneyDataArr = @[@"****",@"****",@"****",@"****"];
        } else {
            _moneyDataArr = @[@"0.00",@"0.00",@"0.00",@"0.00"];
        }
    }else{
        if (_secretButton.selected) {
            _moneyDataArr = @[@"****",@"****",@"****",@"****"];
            
        } else {
            _moneyDataArr = @[
                              allProfitStr,
                              wfsyStr,
                              leftMoneyStr,
                              totalMoneyStr,
                              ];
        }
    }
    _allProfitLabel.text = [NSString stringWithFormat:@"%@",self.moneyDataArr[0]];
    _willCountMoney.text = [NSString stringWithFormat:@"%@",self.moneyDataArr[1]];
    _leftMoney.text =[NSString stringWithFormat:@"%@",self.moneyDataArr[2]];
    _totalMoney.text = [NSString stringWithFormat:@"%@",self.moneyDataArr[3]];

}

@end
