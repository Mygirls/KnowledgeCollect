//
//  KLineViewController.m
//  BYMFinancing
//
//  Created by administrator on 2016/11/30.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "KLineViewController.h"
#import "KLineView.h"
#import "DrawKLineViewController.h"
@interface KLineViewController ()
@property(nonatomic, strong)NSArray *x_arr;//x轴数据数组
@property(nonatomic, strong)NSArray *y_arr;//y轴数据数组
@property(nonatomic, strong)KLineView *drawView;//画图的view


@end

@implementation KLineViewController

- (void)initSelBtn{
    
    NSArray *arr = @[@"柱状图", @"饼状图", @"折线图",@"椭圆",@"阴／阳线",@"K线图"];
    for (int i=0; i<6; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(30+(i%3 )*((KScreen_Width-60)/4 + (KScreen_Width-60)/8), 64 + i/3 * 40, (KScreen_Width-60)/4, 30);
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor redColor];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        btn.tag = 100+i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:btn];
    }
    
}

- (void)btnClick:(UIButton *)btn{
    
    if (btn.tag == 100) {
        [self.drawView drawZhuZhuangTu:self.x_arr and:self.y_arr];
        
    }else if (btn.tag == 101){
        [self.drawView drawBingZhuangTu:self.x_arr and:self.y_arr];
        
    }else if (btn.tag == 102){
        [self.drawView drawZheXianTu:self.x_arr and:self.y_arr];
        
    }else if (btn.tag == 103){
        [self.drawView drawTuoYuan];
        
    }else if (btn.tag == 104) {
        [self.drawView drawKlineTest];
        
    }else {
        DrawKLineViewController *drawKLineVC = [[DrawKLineViewController alloc]init];
        [self.navigationController pushViewController:drawKLineVC animated:YES];
    }
}

- (NSArray *)x_arr{
    
    if (!_x_arr) {
        _x_arr = @[@"北京", @"上海", @"广州", @"深圳", @"武汉", @"成都", @"南京"];
    }
    return _x_arr;
}

- (NSArray *)y_arr{
    if (!_y_arr) {
        _y_arr = @[@"80", @"70", @"90", @"60", @"40", @"30", @"60"];
    }
    return _y_arr;
}

- (KLineView *)drawView{
    
    if (!_drawView) {
        _drawView = [[KLineView alloc] initWithFrame:CGRectMake(0, 64 + 50 + 40, KScreen_Width, KScreen_Width )];
        
    }
    
    return _drawView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view .backgroundColor = [UIColor whiteColor];
    self.title = @"K线图相关知识";
    
    [self.view addSubview:self.drawView];
    [self.drawView drawZheXianTu:self.x_arr and:self.y_arr];

    [self initSelBtn];

    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
