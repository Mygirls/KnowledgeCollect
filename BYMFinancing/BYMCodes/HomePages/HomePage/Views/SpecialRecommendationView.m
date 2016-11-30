//
//  SpecialRecommendationView.m
//  BYMFinancing
//
//  Created by Administrator on 2016/11/2.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "SpecialRecommendationView.h"
#import "BYMDescriptionView.h"
@interface SpecialRecommendationView ()

@property (nonatomic,strong) UIView  *backgroundView;
@property (nonatomic,strong) UILabel *annLable;
@property (nonatomic,strong) UILabel *annText;
@property (nonatomic,strong) UILabel *titlelabel;
@property (nonatomic,strong) UILabel *timeLable;

@end
@implementation SpecialRecommendationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.backgroundView];
        [self addSubview:self.annLable];
        [self addSubview:self.annText];
        [self addSubview:self.titlelabel];
        [self addSubview:self.timeLable];
        [self creatSepetateView];
        
    }
    return self;
}
#pragma mark - 创建子视图
- (UIView *)backgroundView
{
    if (!_backgroundView) {
        _backgroundView=[[UIView alloc]init];
        [_backgroundView setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width , 110)];
        _backgroundView.backgroundColor = [UIColor whiteColor];
    }
    return _backgroundView;
}
- (UILabel *)annLable {
    if (!_annLable) {
        _annLable=[[UILabel alloc]init];
        [_annLable setFrame:CGRectMake((KScreen_Width/3.0 - 45)/2.0, 35, KScreen_Width/3.0 - (KScreen_Width/3.0 - 45)/2.0, 24)];
        _annLable.font = [UIFont systemFontOfSize:24];
        _annLable.backgroundColor = [UIColor clearColor];
        _annLable.textColor = HMColor(51, 51, 51);
        _annLable.textAlignment = NSTextAlignmentLeft;
        [_annLable setNumberOfLines:0];
        _annLable.text = @"";
    }
    return _annLable;
}

- (UILabel *)annText{
    if (!_annText) {
        _annText=[[UILabel alloc]init];
        [_annText setFrame:CGRectMake(_annLable.left, _annLable.bottom + 7, KScreen_Width/3.0 - 30, 12)];
        _annText.font = [UIFont systemFontOfSize:12];
        _annText.backgroundColor = [UIColor clearColor];
        _annText.textAlignment = NSTextAlignmentLeft;
        [_annText setNumberOfLines:0];
        _annText.textColor = HMColor(128, 128, 128);
        _annText.text = @"";
    }
    return _annText;
}

- (UILabel *)titlelabel{
    if (!_titlelabel) {
        _titlelabel=[[UILabel alloc]init];
        [_titlelabel setFrame:CGRectMake(KScreen_Width/3.0 + 40, 33 , KScreen_Width/3.0 * 2 - 40, 15)];
        _titlelabel.font = [UIFont systemFontOfSize:15];
        _titlelabel.backgroundColor = [UIColor clearColor];
        _titlelabel.textAlignment = NSTextAlignmentLeft;
        [_titlelabel setNumberOfLines:0];
        _titlelabel.text = @"";
    }
    return _titlelabel;
}

- (UILabel *)timeLable {
    if (!_timeLable) {
        _timeLable=[[UILabel alloc]init];
        [_timeLable setFrame:CGRectMake(_titlelabel.left, 33 + 15 + 4 + 13 + 3, KScreen_Width/3.0 * 2 - 40, 15)];
        _timeLable.font = [UIFont systemFontOfSize:12];
        _timeLable.backgroundColor = [UIColor clearColor];
        _timeLable.textAlignment = NSTextAlignmentLeft;
        [_timeLable setNumberOfLines:0];
        _timeLable.textColor = HMColor(128, 128, 128);
        _timeLable.text = @"";
    }
    return _timeLable;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self creatSepetateView];
    
}
- (void)creatSepetateView
{
    UIView *sepetateView1 = [[UIView alloc]initWithFrame:CGRectMake(KScreen_Width/3.0 , 35, 0.5, 40)];
    sepetateView1.backgroundColor = HMColor(229, 229, 229);
    [self addSubview:sepetateView1];
    
}

- (void)setObj:(NSDictionary *)obj
{
    _obj = obj;
    
    [self addSubViewDatas];
    NSString *str = [NSString stringWithFormat:@"%@",[_obj objectForKey:@"label"]];
    if ([str isEqualToString:@"<null>"] || [str isEqualToString:@"(null)"]) {
    }else {
        [self setTagLabelwithString:str withSuperView:_backgroundView ];
    }
    
}
- (void)addSubViewDatas
{
    _annText.text = @"年化收益率";
    _titlelabel.text = [NSString stringWithFormat:@"%@",[_obj objectForKey:@"title"]];
    double money =  [self StringChangeToDoubleForJingdu:[NSString stringWithFormat:@"%@",[_obj objectForKey:@"atleastMoney"]]] * 0.01;
    
    _timeLable.text = [NSString stringWithFormat:@"期限%@天 │ %@起投",[_obj objectForKey:@"tzqx"],[NSString stringWithFormat:@"%.0f元",money]];
    _annLable.textColor = HMColor(247, 69, 69);
    
    NSString *productType  = [NSString stringWithFormat:@"%@",[_obj objectForKey:@"productType"]];
    if ([productType isEqualToString:@"2"]) {
        
        NSString *fdsyqj = [NSString stringWithFormat:@"%@",[_obj objectForKey:@"fdsyqj"]];
        if ([fdsyqj isEqualToString:@"<null>"]) {
            
        }else {
            NSArray *array =  [fdsyqj componentsSeparatedByString:@","];
            NSString *str2 = [array lastObject];
            _annLable.text = [NSString stringWithFormat:@"%@%%",str2];
            
        }
        [_annLable settingLabelTextKitWithText:[NSString stringWithFormat:@"%%"] withLabelFont:[UIFont systemFontOfSize:15]];
        
    }else {
        //预期收益
        
        NSString *ann = [NSString stringWithFormat:@"%@",[_obj objectForKey:@"annualEarnings"]] ;
        double testDouble = [ann doubleValue];
        ann = [self decimalNumberWithDouble:testDouble];
        
        
        _annLable.text = [NSString stringWithFormat:@"%@%%",ann];
        
        [_annLable settingLabelTextKitWithText:[NSString stringWithFormat:@"%%"] withLabelFont:[UIFont systemFontOfSize:15]];
    }

}
#pragma mark - 标签
- (void)setTagLabelwithString:(NSString *)str withSuperView:(UIView *)superView {
    if ([str isEqualToString:@"<null>"] || [str isEqualToString:@"(null)"] ) {
        
    }else {
        if ( [str rangeOfString:@"," options:NSCaseInsensitiveSearch].location != NSNotFound) {
            NSArray *arrays = [str componentsSeparatedByString:@","];
            BYMDescriptionView *descriptionView =[[BYMDescriptionView alloc]initWithFrame:CGRectMake(_titlelabel.left,_titlelabel.bottom + 4,  KScreen_Width / 3.0 * 2, 13)];
            descriptionView.backgroundColor = [UIColor whiteColor];
            descriptionView.smallLabelBackgroundColor = [UIColor whiteColor];
            descriptionView.smallLabelTextColol = [UIColor colorWithRed:247/255.0 green:69/255.0 blue:69/255.0 alpha:1];
            [descriptionView setupWithOrderDataItemsArray:arrays];
            [_backgroundView addSubview:descriptionView];
            
        } else {
            if ([NSString stringWithFormat:@"%@",str].length == 0) {
                return;
            }else {
                BYMDescriptionView *descriptionView =[[BYMDescriptionView alloc]initWithFrame:CGRectMake(_titlelabel.left, _titlelabel.bottom + 4,  KScreen_Width / 3.0 * 2 , 13)];
                descriptionView.backgroundColor = [UIColor whiteColor];
                descriptionView.smallLabelBackgroundColor = [UIColor whiteColor];
                
                descriptionView.smallLabelTextColol = [UIColor colorWithRed:247/255.0 green:69/255.0 blue:69/255.0 alpha:1];
                NSArray *items =  [[NSArray alloc]initWithObjects:str, nil];
                [descriptionView setupWithOrderDataItemsArray:items];
                [_backgroundView addSubview:descriptionView];
                
            }
        }
    }
}

- (double)StringChangeToDoubleForJingdu:(NSString *)textString
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    return  [[formatter numberFromString:textString]doubleValue];
    
}

- (NSString *)decimalNumberWithDouble:(double)conversionValue
{
    NSString *doubleString        = [NSString stringWithFormat:@"%lf", conversionValue];
    NSDecimalNumber *decNumber    = [NSDecimalNumber decimalNumberWithString:doubleString];
    return [decNumber stringValue];
}

@end
