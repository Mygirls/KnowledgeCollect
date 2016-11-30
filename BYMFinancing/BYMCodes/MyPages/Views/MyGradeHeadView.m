//
//  MyGradeHeadView.m
//  BYMFinancing
//
//  Created by Administrator on 2016/11/8.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "MyGradeHeadView.h"
#import "GradeProgressBar.h"

@interface MyGradeHeadView ()

@property (nonatomic, strong) UILabel           *levelLabel;         /**    等级    */
@property (nonatomic, strong) UIImageView       *portraitImageView;  /**   个人头像  */
@property (nonatomic, assign) NSInteger         index;               /** 记录当前等级 */
@property (nonatomic, strong) NSArray           *bottonColorArr;
@property (nonatomic, strong) NSArray           *topColorArr;
@property (nonatomic, strong) UIImageView       *backGroupImageView;
@property (nonatomic, assign) NSUInteger        timerTeger;          /**  计数器  */
@property (nonatomic, strong) GradeProgressBar  *bar;

@end

@implementation MyGradeHeadView
/**
 *   自定义我的等级页面之头试图
 */
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        _topColorArr = [@[HMColor(254, 182, 164),HMColor(252, 162, 150),HMColor(250, 146, 139),HMColor(249, 131, 129),HMColor(247, 110, 110),HMColor(244, 97, 97),HMColor(244, 97, 97)]copy];                                                 /** 上部分颜色 */
        
        _bottonColorArr = [@[HMColor(254, 161, 138),HMColor(252, 136, 121),HMColor(249, 115, 106),HMColor(248, 96, 93),HMColor(247, 69, 69),HMColor(243, 48, 48),HMColor(243, 48, 48)]copy];                                                       /** 下部分颜色 */
        
        [self creatSubviews];
    }
    return self;
    
}
-(UIImageView *)portraitImageView{
    
    if (!_portraitImageView) {
        CGFloat width = 52*KScreen_Width/320;
        _portraitImageView = [[UIImageView alloc] initWithFrame:CGRectMake((KScreen_Width-width)/2.0,28*KScreen_Width/320,width,width)];
        [_portraitImageView.layer setCornerRadius:(_portraitImageView.frame.size.height/2.0)];
        [_portraitImageView.layer setMasksToBounds:YES];
        [_portraitImageView setContentMode:UIViewContentModeScaleAspectFill];
        [_portraitImageView setClipsToBounds:YES];
    }
    return _portraitImageView;
}

-(UILabel *)levelLabel{
    
    if (!_levelLabel) {
        _levelLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _portraitImageView.bottom+10, KScreen_Width, 15)];
        _levelLabel.font = BYM_LabelFont(13);
        _levelLabel.textAlignment = NSTextAlignmentCenter;
        _levelLabel.textColor = HMColor(51, 51, 51);
    }
    return _levelLabel;
}

- (void)creatSubviews{
    
    
    [self addSubview:self.portraitImageView];
    [self addSubview:self.levelLabel];
    
    CGFloat width = KScreen_Width;
    CGFloat height =25 * KScreen_Width / 320;
    
    _backGroupImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, _portraitImageView.bottom+32*KScreen_Width/320, width, height)];
    _backGroupImageView.contentMode = UIViewContentModeScaleAspectFit;
    _backGroupImageView.image = [UIImage imageNamed:@"jdt_icon"];
    [self addSubview:_backGroupImageView];
    
}


-(void)setDic:(NSDictionary *)dic{
    _dic = dic;
    _index =[[_dic objectForKey:@"level"] integerValue];
    
    //    _index = 2;
    [self.portraitImageView  sd_setImageWithURL:[NSURL URLWithString:[_dic objectForKey:@"userPhotos"]] placeholderImage:[UIImage imageNamed:@"3_01tx3"]];
    self.levelLabel.text = [NSString stringWithFormat:@"当前等级:  LV%ld",_index];
}


-(void)setValue:(CGFloat)value
{
    _value = value;
    
    [self setAnimationOfLineView];                              /** 等级进度条 */
    
}


- (void)setAnimationOfLineView
{
    
    NSInteger index = _index;
    /**  添加等级浮标 */
    UIImageView *fbImageView = [[UIImageView alloc]init];
    fbImageView.image = [UIImage imageNamed:@"fb_icon"];
    if (index==0) {
        fbImageView.frame = CGRectMake(7*KScreen_Width/320 , 0, 11, 14);
    }else if(index == 7){
        fbImageView.frame = CGRectMake((KScreen_Width-7*KScreen_Width/320)-11 , 0, 11, 14);
    }else{
        fbImageView.frame = CGRectMake((3 +index * (34+9.3))*KScreen_Width/320 , 0, 11, 14);
    }
    
    [_backGroupImageView addSubview:fbImageView];
    
    for (NSInteger i =0; i <=7; i++) {
        UILabel *allLevelLabel = [[UILabel alloc]init];
        allLevelLabel.textAlignment = NSTextAlignmentCenter;
        if (i==0) {
            allLevelLabel.frame = CGRectMake(7*KScreen_Width/320 , 0, 11, 14);
        }else if(i == 7){
            allLevelLabel.frame = CGRectMake((KScreen_Width-7*KScreen_Width/320)-11 , 0, 11, 14);
        }else{
            allLevelLabel.frame = CGRectMake((3 +i * (34+9.3))*KScreen_Width/320 , 0, 11, 14);
        }
        if (i == index) {
            allLevelLabel.textColor = [UIColor whiteColor];
        }else{
            allLevelLabel.textColor = [UIColor blackColor];
        }
        allLevelLabel.font = BYM_LabelFont(8);
        allLevelLabel.text = [NSString stringWithFormat:@"%ld",i];
        [_backGroupImageView addSubview:allLevelLabel];
    }
    _timerTeger = 0;
    [self creatWProgressIndex:index];
    
}
/**
 *  等级进度条动画效果
 */
- (void)creatWProgressIndex:(NSInteger)index
{
    CGFloat lineWidth  = 34*KScreen_Width/320;
    CGFloat lineHeight = 6.5 * KScreen_Width/320;
    _timerTeger++;
    
    if (index ==0) {
        if (_value > 0) {
            _bar=[[GradeProgressBar alloc]initWithFrame:CGRectMake((13.5  + _index * (34+9.3))*KScreen_Width/320 ,(_backGroupImageView.height+0.7*KScreen_Width/320)/2.0,0, lineHeight) upperPartColor:_topColorArr[0] lowerPartColor:_bottonColorArr[0]];
            [_backGroupImageView addSubview:_bar];
            
            [UIView animateWithDuration:0.9f  animations:^{
                _bar.widthLine = _value*lineWidth;
                
            }];
            return ;
        }else {
            return;
        }
    }else {
        _bar=[[GradeProgressBar alloc]initWithFrame:CGRectMake((13.5 +  (_timerTeger -1 ) * (34+9.3))*KScreen_Width/320 ,(_backGroupImageView.height+0.7*KScreen_Width/320)/2.0,1, lineHeight) upperPartColor:_topColorArr[_timerTeger-1] lowerPartColor:_bottonColorArr[_timerTeger-1]];
        [_backGroupImageView addSubview:_bar];
        
        [UIView animateWithDuration:0.2f delay:0.0f options: UIViewAnimationOptionCurveLinear    animations:^{
            
            _bar.widthLine = lineWidth;
            
        } completion:^(BOOL finished) {
            
            if (_timerTeger == index) {
                
                if (_value > 0 && index < 7) {
                    
                    _bar=[[GradeProgressBar alloc]initWithFrame:CGRectMake((13.5  + _index * (34+9.3))*KScreen_Width/320 ,(_backGroupImageView.height+0.7*KScreen_Width/320)/2.0,0, lineHeight) upperPartColor:_topColorArr[index] lowerPartColor:_bottonColorArr[index]];
                    [_backGroupImageView addSubview:_bar];
                    
                    [UIView animateWithDuration:0.2f animations:^{
                        _bar.widthLine = _value*lineWidth;
                        
                    }];
                    return ;
                }else{
                    return ;
                }
                
            }else {
                [self creatWProgressIndex:index];
            }
            
        }];  
    }
}


@end
