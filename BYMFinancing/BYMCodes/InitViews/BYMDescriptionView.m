//
//  BYMDescriptionView.m
//  BYMFinancing
//
//  Created by Administrator on 2016/11/2.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "BYMDescriptionView.h"

@interface BYMDescriptionView ()

@property (nonatomic, strong) NSMutableArray *containArray;         /** 所以Lable的一个容器 */
@property (nonatomic, strong)        NSArray *dataArray;            /** 要展示数据的数组 */
@property (nonatomic, strong) NSMutableArray *rectWidthArray;       /** 要展示数据文本长度的数组 */

@end
@implementation BYMDescriptionView

/*
 此功能 可以模仿 QQ 动态评论（ps：由于评论的条数不确定性，在每个cell 里面无法确定创建label的个数，所以，这个功能的大体思路如下：根据数据的条数来自适应来创建label的个数，例如，当上一个cell评论个数为10条的时候，创建10个label，把它存放在一个可变数组里面，然后通过数组去取适当的数据，当下一个cell的条数为 15的时候，只需要在原来的基础上在创建5个即可，然后在根据数据数组去去相应的数据即可，当再下一个cell的条数为 5的时候，我们只需要去那个可变数组的前面5个label就可以了，这样即可以解决labe 的复用问题，但是使用的时候必须labe 的相关数据清空，fame 也有情况，以便使用的还是赋值）
 */

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.smallLabelTextColol = [UIColor colorWithRed:247/255.0 green:69/255.0 blue:69/255.0 alpha:1];
        self.smallLabelBackgroundColor = [UIColor whiteColor];
        self.smallLabelFont = 10.0;
        self.smallLabelMasksToBounds = YES;
        self.smallLabelCornerRadius = 1.5;
        self.smallLabelBorderWidth = 0.5;
        self.smallLabelBorderColor = [UIColor colorWithRed:247/255.0 green:69/255.0 blue:69/255.0 alpha:1];
        self.smallLabelHeight = 13;
        self.smallLabelInterval = 5;
    }
    return self;
}


- (void)awakeFromNib
{
    [super awakeFromNib];
    self.backgroundColor = [UIColor whiteColor];
    self.smallLabelTextColol = [UIColor colorWithRed:247/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    self.smallLabelBackgroundColor = [UIColor whiteColor];
    self.smallLabelFont = 10.0;
    self.smallLabelMasksToBounds = YES;
    self.smallLabelCornerRadius = 1.5;
    self.smallLabelBorderWidth = 0.5;
    self.smallLabelBorderColor = [UIColor colorWithRed:247/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    self.smallLabelHeight = 13;
    self.smallLabelInterval = 5;
    
    
}

/**  设置属性 **/
- (void)setSmallLabelBackgroundColor:(UIColor *)smallLabelBackgroundColor {
    _smallLabelBackgroundColor = smallLabelBackgroundColor;
}

- (void)setSmallLabelTextColol:(UIColor *)smallLabelTextColol {
    _smallLabelTextColol = smallLabelTextColol;
}

- (void)setSmallLabelFont:(double)smallLabelFont {
    _smallLabelFont = smallLabelFont;
}

- (void)setSmallLabelBorderColor:(UIColor *)smallLabelBorderColor {
    _smallLabelBorderColor = smallLabelBorderColor;
}

- (void)setSmallLabelCornerRadius:(double)smallLabelCornerRadius {
    _smallLabelCornerRadius = smallLabelCornerRadius;
}

-(void)setSmallLabelHeight:(double)smallLabelHeight{
    _smallLabelHeight = smallLabelHeight;
}

- (void)setSmallLabelBorderWidth:(double)smallLabelBorderWidth {
    _smallLabelBorderWidth = smallLabelBorderWidth;
}

- (void)setSmallLabelMasksToBounds:(BOOL)smallLabelMasksToBounds {
    _smallLabelMasksToBounds = smallLabelMasksToBounds;
}
- (void)setSmallLabelInterval:(double)smallLabelInterval {
    _smallLabelInterval = smallLabelInterval;
}

/**
 *
 */
- (NSMutableArray *)containArray
{
    if (!_containArray) {
        _containArray = [NSMutableArray new];
    }
    return _containArray;
}

- (NSMutableArray *)rectWidthArray
{
    if (!_rectWidthArray) {
        _rectWidthArray = [NSMutableArray new];
    }
    return _rectWidthArray;
}

- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    long originalLabelsCount = self.containArray.count;
    long needsToAddCount = dataArray.count > originalLabelsCount ? (dataArray.count - originalLabelsCount) : 0;
    for (int i = 0; i < needsToAddCount; i++) {
        UILabel *describtionLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        describtionLabel.text = @"";
        describtionLabel.textColor = self.smallLabelTextColol;
        describtionLabel.font =  [UIFont systemFontOfSize:self.smallLabelFont];
        if (self.smallLabelMasksToBounds) {
            describtionLabel.layer.masksToBounds = YES;
            describtionLabel.layer.cornerRadius = self.smallLabelCornerRadius;
            describtionLabel.layer.borderWidth = self.smallLabelBorderWidth;
            describtionLabel.layer.borderColor = self.smallLabelBorderColor.CGColor;
        }
        
        describtionLabel.backgroundColor = self.smallLabelBackgroundColor;
        describtionLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:describtionLabel];
        [self.containArray addObject:describtionLabel];
    }
    
}
/**
 * 倒序排列
 *
 */
- (void)setupWithReverseDataItemsArray:(NSArray *)array;
{
    self.dataArray = array;
    
    if (self.containArray.count) {
        [self.containArray enumerateObjectsUsingBlock:^(UILabel *describtionLabel, NSUInteger idx, BOOL * _Nonnull stop) {
            describtionLabel.text = @"";
            describtionLabel.frame = CGRectZero;
            
        }];
    }
    [self.rectWidthArray removeAllObjects];
    for (int i = 0; i < self.dataArray.count; i ++) {
        
        CGRect rect = [self rectWidthWithStr:self.dataArray[i] AndFont:self.smallLabelFont WithStrHeight:self.smallLabelHeight];
        [self.rectWidthArray addObject:[NSString stringWithFormat:@"%f",rect.size.width]];
    }
    
    for (NSInteger i = self.dataArray.count - 1; i >= 0; i --) {
        NSString *widthStr = self.rectWidthArray[i];
        double labelWidth =  [self stringChangeToDoubleForJingdu:widthStr] + 3;
        UILabel *describtionLabel = (UILabel *)self.containArray[i];
        if (i == self.dataArray.count - 1) {
            describtionLabel.frame = CGRectMake(self.frame.size.width - labelWidth, (self.frame.size.height - self.smallLabelHeight)/2.0, labelWidth , self.smallLabelHeight);
        }else {
            UILabel *lastDescribtionLabel = (UILabel *)self.containArray[i+1];
            describtionLabel.frame = CGRectMake(lastDescribtionLabel.frame.origin.x - 0 - labelWidth - self.smallLabelInterval, (self.frame.size.height - self.smallLabelHeight)/2.0, labelWidth , self.smallLabelHeight);
        }
        describtionLabel.text = self.dataArray[i];
    }
}

/**
 * 顺序排列
 *
 */
- (void)setupWithOrderDataItemsArray:(NSArray *)array;
{
    self.dataArray = array;
    if (self.containArray.count) {
        [self.containArray enumerateObjectsUsingBlock:^(UILabel *describtionLabel, NSUInteger idx, BOOL * _Nonnull stop) {
            describtionLabel.text = @"";
            describtionLabel.frame = CGRectZero;
        }];
    }
    
    [self.rectWidthArray removeAllObjects];
    for (int i = 0; i < self.dataArray.count; i ++) {
        
        CGRect rect = [self rectWidthWithStr:self.dataArray[i] AndFont:self.smallLabelFont WithStrHeight:self.smallLabelHeight];
        [self.rectWidthArray addObject:[NSString stringWithFormat:@"%f",rect.size.width]];
    }
    
    for (int i = 0; i <self.dataArray.count; i ++) {
        NSString *widthStr = self.rectWidthArray[i];
        double labelWidth =  [self stringChangeToDoubleForJingdu:widthStr] + 3;
        UILabel *describtionLabel = (UILabel *)self.containArray[i];
        if (i == 0) {
            describtionLabel.frame = CGRectMake(0, (self.frame.size.height - self.smallLabelHeight)/2.0, labelWidth , self.smallLabelHeight);
            
        }else {
            UILabel *nextDescribtionLabel = (UILabel *)self.containArray[i-1];
            describtionLabel.frame = CGRectMake(nextDescribtionLabel.frame.origin.x + nextDescribtionLabel.frame.size.width+  self.smallLabelInterval, (self.frame.size.height - self.smallLabelHeight)/2.0, labelWidth ,self.smallLabelHeight);
        }
        describtionLabel.text = self.dataArray[i];
    }
}


/**
 * 根据 字符串的长度、字体大小、已经高度 返回CGRect
 *
 */
- (CGRect)rectWidthWithStr:(NSString *)str AndFont:(CGFloat)fontFloat WithStrHeight:(CGFloat)height
{
    CGRect fcRect = [str boundingRectWithSize:CGSizeMake(1000, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontFloat]} context:nil];
    return fcRect;
}

/**
 * 字符串转化成基本数据类型
 *
 */
- (double)stringChangeToDoubleForJingdu:(NSString *)textString
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    return  [[formatter numberFromString:textString]doubleValue];
}


@end
