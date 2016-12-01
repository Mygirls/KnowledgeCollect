//
//  DrawKLineViewController.m
//  BYMFinancing
//
//  Created by administrator on 2016/12/1.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "DrawKLineViewController.h"
#import "JQKTimeLineView.h"
@interface DrawKLineViewController ()

@property(nonatomic,strong)JQKTimeLineView *timeKLineView;
@end

@implementation DrawKLineViewController

- (JQKTimeLineView *)timeKLineView{
    
    if (!_timeKLineView) {
        _timeKLineView = [[JQKTimeLineView alloc] initWithFrame:CGRectMake(0, 64 , KScreen_Width, KScreen_Height - 64 )];
    }
    
    return _timeKLineView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view .backgroundColor = [UIColor whiteColor];
    self.title = @"K线图";
    
    [self.view addSubview:self.timeKLineView];
    
    
    
    
    
}


@end
