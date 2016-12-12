//
//  DrawKLineViewController.m
//  BYMFinancing
//
//  Created by administrator on 2016/12/1.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "DrawKLineViewController.h"
#import "JQKTimeLineView.h"
#import "JQKTimeLineModel.h"

#import "AppDelegate.h"

@interface DrawKLineViewController ()

@property(nonatomic,strong)JQKTimeLineView *timeKLineView;
@property (strong, nonatomic) NSMutableArray *stockDataArray;//分时 数据

@end

@implementation DrawKLineViewController


- (BOOL)shouldAutorotate{
    return NO;
}


-(void) viewDidAppear:(BOOL) animated{
    [super viewDidAppear:animated];
    NSLog(@"%@",self.navigationController);
    BYMNavgationController *nav = (BYMNavgationController *)self.navigationController;
}

-(void) viewDidDisappear:(BOOL) animated{
    [super viewDidAppear:animated];
    BYMNavgationController *nav = (BYMNavgationController *)self.navigationController;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view .backgroundColor = [UIColor whiteColor];
    self.title = @"K线图";

    [self setUpViews];
    
  }


- (void)setUpViews
{
    
    //[self loadFiveDataSource];
    //[self loadDayDataSource];
    [self loadMinuteDataSource];
    
    self.timeKLineView = [[JQKTimeLineView alloc] initWithTimeLineModels:self.stockDataArray];
    [self.view addSubview:self.timeKLineView];
    
    //距离上下左右 55 15 58 28
    [self.timeKLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view.mas_leading).with.offset(0);
        make.top.equalTo(self.view.mas_top).with.offset(64);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-100);
        make.trailing.equalTo(self.view.mas_trailing).with.offset(0);
    }];


}

- (void)loadFiveDataSource {
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"fiveData" ofType:@"plist"];
    NSMutableDictionary *fiveDataDic = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    NSLog(@"%@",fiveDataDic);
}

//日K 数据
- (void)loadDayDataSource {
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"dayData" ofType:@"plist"];
    NSMutableDictionary *dayDataDic = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    NSLog(@"%@",dayDataDic);
}

//分时 数据
- (void)loadMinuteDataSource {
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"minuteData" ofType:@"plist"];
    NSMutableDictionary *minuteDataDic = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    //NSLog(@"%@",minuteDataDic);
    
    NSMutableArray *array = [NSMutableArray array];
    [minuteDataDic[@"minutes"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        JQKTimeLineModel *model = [[JQKTimeLineModel alloc]initWithDict:obj];
        [array addObject: model];
    }];
    self.stockDataArray = array;
}

- (NSMutableArray *)stockDataArray {
    if (!_stockDataArray) {
        _stockDataArray = [NSMutableArray new];
    }
    return _stockDataArray;
}
@end
