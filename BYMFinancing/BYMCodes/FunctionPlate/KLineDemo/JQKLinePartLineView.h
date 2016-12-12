//
//  JQKLinePartLineView.h
//  BYMFinancing
//
//  Created by administrator on 2016/12/2.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JQKLinePartLineView : UIView
@property (nonatomic, strong) NSMutableArray *drawPositionModels;//位置数组

- (NSArray *)drawViewWithXPosition:(CGFloat)xPosition drawModels:(NSArray *)drawLineModels  maxValue:(CGFloat)maxValue minValue:(CGFloat)minValue ;

@end
