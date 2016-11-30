//
//  GradeProgressBar.m
//  BYMFinancing
//
//  Created by Administrator on 2016/11/8.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "GradeProgressBar.h"

@interface GradeProgressBar ()
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIView *viewTop;
@property (nonatomic, strong) UIView *viewBottom;
@end
@implementation GradeProgressBar

-(id)initWithFrame:(CGRect)aFrame upperPartColor:(UIColor*)upColor lowerPartColor:(UIColor*)lowerColor
{
    self = [super initWithFrame:aFrame];
    
    if (self)
    {
        self.backgroundColor=[UIColor clearColor];
        _lineView = [[UIView alloc]initWithFrame:CGRectZero];
        _lineView.frame = CGRectMake( 0 ,0, self.width , self.height);
        [_lineView.layer setCornerRadius:_lineView.height/2.0];
        [_lineView.layer setMasksToBounds:YES];
        [self addSubview:_lineView];
        
        _viewTop = [[UIView alloc]initWithFrame:CGRectMake( 0 ,0, self.width , self.height/2.0)];
        _viewTop.backgroundColor = upColor;
        [_lineView addSubview:_viewTop];
        
        _viewBottom = [[UIView alloc]initWithFrame:CGRectMake( 0, _viewTop.bottom, self.width , self.height/2.0)];
        _viewBottom.backgroundColor = lowerColor;
        [_lineView addSubview:_viewBottom];
        
    }
    return self;
}

-(void)setWidthLine:(CGFloat)widthLine {
    
    _widthLine = widthLine;
    
    _lineView.width = _widthLine;
    _viewTop.width = _widthLine;
    _viewBottom.width = _widthLine;
}

@end
