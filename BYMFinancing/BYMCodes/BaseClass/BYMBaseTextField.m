//
//  BYMBaseTextField.m
//  BYMFinancing
//
//  Created by Administrator on 2016/11/4.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "BYMBaseTextField.h"

@implementation BYMBaseTextField

/**
 *  自定义textField
 */

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

//不能复制
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(paste:))
        return NO;
    return [super canPerformAction:action withSender:sender];
}

- (CGRect)textRectForBounds:(CGRect)bounds
{
    int margin =0;
    CGRect inset =CGRectMake(bounds.origin.x + margin, bounds.origin.y, bounds.size.width - margin, bounds.size.height);
    return inset;
}

-(CGRect)editingRectForBounds:(CGRect)bounds
{
    int margin =0;
    CGRect inset =CGRectMake(bounds.origin.x + margin, bounds.origin.y, bounds.size.width - margin, bounds.size.height);
    return inset;
}

@end
