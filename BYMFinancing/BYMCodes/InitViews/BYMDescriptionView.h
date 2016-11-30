//
//  BYMDescriptionView.h
//  BYMFinancing
//
//  Created by Administrator on 2016/11/2.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BYMDescriptionView : UIView

@property(nonatomic,strong)UIColor *smallLabelTextColol;
@property(nonatomic,strong)UIColor *smallLabelBackgroundColor;
@property(nonatomic,strong)UIColor *smallLabelBorderColor;      /***  set BorderColor   ***/
@property(nonatomic,assign)double   smallLabelCornerRadius;     /***  set CornerRadius  ***/
@property(nonatomic,assign)double   smallLabelHeight;           /***  set Height        ***/
@property(nonatomic,assign)double   smallLabelBorderWidth;      /***  set BorderWidth   ***/
@property(nonatomic,assign)BOOL     smallLabelMasksToBounds;    /***  是否可以圆角(默认为YES) ***/
@property(nonatomic,assign)double   smallLabelFont;             /***  set UIFont        ***/
@property(nonatomic,assign)double   smallLabelInterval;         /***  每个label之间的间隔  ***/


- (void)setupWithOrderDataItemsArray:(NSArray *)array;  //从左至右

- (void)setupWithReverseDataItemsArray:(NSArray *)array;//从右至左

@end
