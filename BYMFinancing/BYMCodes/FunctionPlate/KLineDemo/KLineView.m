//
//  KLineView.m
//  BYMFinancing
//
//  Created by administrator on 2016/11/30.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "KLineView.h"
#define margin      30
#define zzWidth     self.bounds.size.width
#define zzHeight    self.bounds.size.height

@implementation KLineView


- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor grayColor];
        
        
        }
    
    return self;
}

- (void)setUpRemoveButton
{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(KScreen_Width- 80, 0, 80, 40);
    [button setTitle:@"remove" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor orangeColor];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
}

- (void)buttonAction:(UIButton *)btn
{
    CGContextClearRect(UIGraphicsGetCurrentContext(), self.frame);
    
    self.clearsContextBeforeDrawing = YES;

    [self initDrawView];
    [self removeFromSuperview];
}

// TODO: 注意：
/**
 *  当- (void)drawRect:(CGRect)rect 调用时，默认的背景颜色是 black ；
 *  设置self.backgroundColor 即可得到自己想要的背景颜色
 */
//- (void)drawRect:(CGRect)rect
//{
////    [self drawOneZhuxing];
//}

#pragma mark - ----------------------
- (void)drawZhuZhuangTu:(NSArray *)x_itemArr and:(NSArray *)y_itemArr{
    [self initDrawView];
    
    [self drawZuoBiaoXi:x_itemArr];

    //画柱状图
    for (int i=0; i<x_itemArr.count; i++) {
        
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(2*margin+1.5*margin*i, zzHeight-margin-3*[y_itemArr[i] floatValue], 0.8*margin, 3*[y_itemArr[i] floatValue])];
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.path = path.CGPath;
        layer.fillColor = BYM_testColor.CGColor;
        layer.strokeColor = [UIColor redColor].CGColor;//可以省略的
        [self.layer addSublayer:layer];
    }
    //给x轴加标注
    for (int i=0; i<x_itemArr.count; i++) {
        
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(2*margin+1.5*margin*i, zzHeight-margin, 0.8*margin, 20)];
        lab.text = x_itemArr[i];
        lab.textColor = [UIColor blackColor];
        lab.font = [UIFont boldSystemFontOfSize:12];
        lab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:lab];
    }
}

- (void)drawBingZhuangTu:(NSArray *)x_itemArr and:(NSArray *)y_itemArr{
    [self initDrawView];
    
    CGPoint yPoint = CGPointMake(zzWidth/2, zzHeight/2);
    CGFloat startAngle = 0;
    CGFloat endAngle;
    float r = 100.0;
    
    //求和
    float sum=0;
    for (NSString *str in y_itemArr) {
        
        sum += [str floatValue];
    }
    for (int i=0; i<x_itemArr.count; i++) {
        
        //求每一个的占比
        float zhanbi = [y_itemArr[i] floatValue]/sum;
        
        endAngle = startAngle + zhanbi*2*M_PI;
        
        CAShapeLayer *layer = [CAShapeLayer layer];
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:yPoint radius:r startAngle:startAngle endAngle:endAngle clockwise:YES];
        [path addLineToPoint:yPoint];
        [path closePath];
        
        
        CGFloat lab_x = yPoint.x + (r + 30/2) * cos((startAngle + (endAngle - startAngle)/2)) - 30/2;
        CGFloat lab_y = yPoint.y + (r + 20/2) * sin((startAngle + (endAngle - startAngle)/2)) - 20/2;
        
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(lab_x, lab_y, 30, 20)];
        lab.text = x_itemArr[i];
        lab.textColor = [UIColor blackColor];
        lab.font = [UIFont boldSystemFontOfSize:12];
        lab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:lab];
        
        
        layer.path = path.CGPath;
        layer.fillColor = BYM_testColor.CGColor;
        layer.strokeColor = [UIColor clearColor].CGColor;
        [self.layer addSublayer:layer];
        
        startAngle = endAngle;
    }
}

- (void)drawZheXianTu:(NSArray *)x_itemArr and:(NSArray *)y_itemArr{

    [self initDrawView];
    
    [self drawZuoBiaoXi:x_itemArr];//建立坐标轴
    
    CGPoint startPoint = CGPointMake(2*margin, zzHeight-margin-3*[y_itemArr[0] floatValue]);
    CGPoint endPoint;

    for (int i=0; i<x_itemArr.count; i++) {
        
        endPoint = CGPointMake(2*margin+1.5*margin*i, zzHeight-margin-3*[y_itemArr[i] floatValue]);
        //NSLog(@" %f %f %f %f",zzHeight,[y_itemArr[i] floatValue],2*margin+1.5*margin*i,  zzHeight-margin-3*[y_itemArr[i] floatValue]);
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:startPoint];
        
        /*
         - (void)addArcWithCenter:(CGPoint)center radius:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle clockwise:(BOOL)clockwise
        画圆弧:
            可以画出一段弧线。
            看下各个参数的意义：
            center：圆心的坐标
            radius：半径
            startAngle：起始的弧度
            endAngle：圆弧结束的弧度
            clockwise：YES为顺时针，No为逆时针
         */
        [path addArcWithCenter:endPoint radius:1.5 startAngle:0 endAngle:2*M_PI clockwise:YES];
        [path addLineToPoint:endPoint];
        
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.path = path.CGPath;
        layer.strokeColor = [UIColor redColor].CGColor;
        layer.lineWidth = 1.0;
        [self.layer addSublayer:layer];
        //NSLog(@"%f  %f",layer.frame.size.height,layer.frame.size.width);
        
        //        CAShapeLayer *layer1 = [CAShapeLayer layer];
        //        layer1.frame = CGRectMake(endPoint.x, endPoint.y, 5, 5);
        //        layer1.backgroundColor = [UIColor blackColor].CGColor;
        //        [self.layer addSublayer:layer1];
        
        //绘制虚线
        [self drawXuxian:endPoint];
        
        startPoint = endPoint;  //保留上一个折线图位置 过渡 到下一个折点
    }
    
    //给x轴加标注
    for (int i=0; i<x_itemArr.count; i++) {
        
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(2*margin+1.5*margin*i-0.4*margin, zzHeight-margin, 0.8*margin, 20)];
        lab.text = x_itemArr[i];
        lab.textColor = [UIColor blackColor];
        lab.font = [UIFont boldSystemFontOfSize:12];
        lab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:lab];
    }
}

//绘制虚线
- (void)drawXuxian:(CGPoint)point{
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    
    [shapeLayer setStrokeColor:[UIColor blackColor].CGColor];
    
    [shapeLayer setLineWidth:1];
    [shapeLayer setLineJoin:kCALineJoinRound];
    
    //设置虚线的线宽及间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:2], [NSNumber numberWithInt:3], nil]];
    
    //创建虚线绘制路径
    CGMutablePathRef path = CGPathCreateMutable();
    
    //设置y轴方向的虚线
    CGPathMoveToPoint(path, NULL, point.x, point.y);
    CGPathAddLineToPoint(path, NULL, point.x, zzHeight-margin);
    
    //设置x轴方向的虚线
    CGPathMoveToPoint(path, NULL, point.x, point.y);
    CGPathAddLineToPoint(path, NULL, margin, point.y);
    
    //设置虚线绘制路径
    [shapeLayer setPath:path];
    CGPathRelease(path);
    
    [self.layer addSublayer:shapeLayer];
}

#pragma mark - 移除self.layer.sublayers
- (void)initDrawView{
    [self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    
    [self setUpRemoveButton];//添加一下：button
    //    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
}

//画坐标轴
- (void)drawZuoBiaoXi:(NSArray *)x_itemArr{
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    //坐标轴原点:起始点设置为(30,zzHeight - 30):注意这是上下文对应区域中的相对坐标，
    CGPoint rPoint = CGPointMake(margin, zzHeight-margin);
    
    //画y轴
    [path moveToPoint:rPoint];  // 相当于画布的   CGContextMoveToPoint(context, 64 + 10, 64 + 64);
    [path addLineToPoint:CGPointMake(margin, margin)];
    
    //画y轴的箭头
    [path moveToPoint:CGPointMake(margin, margin)];
    [path addLineToPoint:CGPointMake(margin-5, margin+5)];
    [path moveToPoint:CGPointMake(margin, margin)];
    [path addLineToPoint:CGPointMake(margin+5, margin+5)];
    
    //画x轴
    [path moveToPoint:rPoint];
    [path addLineToPoint:CGPointMake(zzWidth-margin, zzHeight-margin)];
    
    //画x轴的箭头
    [path moveToPoint:CGPointMake(zzWidth-margin, zzHeight-margin)];
    [path addLineToPoint:CGPointMake(zzWidth-margin-5, zzHeight-margin-5)];
    [path moveToPoint:CGPointMake(zzWidth-margin, zzHeight-margin)];
    [path addLineToPoint:CGPointMake(zzWidth-margin-5, zzHeight-margin+5)];
    
    
    //画x轴上的标度:也是画一条线 长度为3
    for (int i=0; i<x_itemArr.count; i++) {
        
        [path moveToPoint:CGPointMake(2*margin+1.5*margin*i, zzHeight-margin)];
        [path addLineToPoint:CGPointMake(2*margin+1.5*margin*i, zzHeight-margin-3)];
        
    }
    
    //画y轴上的标度
    for (int i=0; i<10; i++) {
        
        [path moveToPoint:CGPointMake(margin, zzHeight-2*margin-margin*i)];
        [path addLineToPoint:CGPointMake(margin+3, zzHeight-2*margin-margin*i)];
    }
    
    layer.path = path.CGPath;
    /* The color to fill the path, or nil for no fill. Defaults to opaque
     * black. Animatable. 颜色填充路径，或无填充。默认为不透明 *黑色*/
    layer.fillColor = [UIColor clearColor].CGColor;
    
    /* The color to fill the path's stroked outline, or nil for no stroking.
     * Defaults to nil. Animatable. 描边轮廓*/
    layer.strokeColor = [UIColor blackColor].CGColor;
    layer.lineWidth = 2.0;
    [self.layer addSublayer:layer];
    
    //给y轴加标注
    for (int i=0; i<11; i++) {
        
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(margin-25, zzHeight-margin-margin*i-10, 25, 20)];
        lab.text = [NSString stringWithFormat:@"%d", 10*i];
        lab.textColor = [UIColor blackColor];
        lab.font = [UIFont boldSystemFontOfSize:12];
        lab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:lab];
    }
}



#pragma mark - 绘制柱形的第二种方法(自己练习的)  椭圆
- (void)drawOneZhuxing
{
    //绘制柱子
    CGContextRef ctr = UIGraphicsGetCurrentContext();
    [self drawMyRectWithCornerX:220 andY:150 andRadius:5 andWidth:10 andHeight:120 andCtr:ctr andColor:[UIColor redColor]];
    
    //+ 文字
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.alignment = NSTextAlignmentCenter;
    NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:12],NSParagraphStyleAttributeName:paragraph,NSForegroundColorAttributeName:[UIColor colorWithRed:187.0/255.0 green:187.0/255.0 blue:187.0/255.0 alpha:1.0]};
    
    [@"7月" drawInRect:CGRectMake(220, 150 , 30, 22) withAttributes:attribute];
    
}

/**
 *  绘制圆弧矩形
 *
 *  @param x      起始点的横坐标
 *  @param y      起始点的纵坐标
 *  @param radius 圆角弧形的半径
 *  @param width  矩形的宽度
 *  @param height 矩形的高度
 *  @param ctr    绘图上下文
 *  @param color  背景颜色
 */
- (void)drawMyRectWithCornerX:(CGFloat)x andY:(CGFloat)y andRadius:(CGFloat)radius andWidth:(CGFloat)width andHeight:(CGFloat)height andCtr:(CGContextRef)ctr andColor:(UIColor *)color{
    
    [color set];
    CGContextMoveToPoint(ctr, x, y);
    if(radius > fabs(height)){
        CGContextAddArc(ctr, x, y, fabs(height), M_PI * 2, M_PI, 1);
    }else{
        CGContextAddLineToPoint(ctr, x, y - fabs(height) + radius);
        CGContextAddArc(ctr, x + width / 2, y - fabs(height) + radius, radius, - M_PI , 0, 0);//柱形头上的椭圆
        CGContextAddLineToPoint(ctr, x + width,  y - fabs(height) + radius);
        CGContextAddLineToPoint(ctr, x + width, y);
        CGContextAddLineToPoint(ctr, x, y);
    }
    
    //    CGContextFillPath(ctr);   //填充的方式
    CGContextStrokePath(ctr);
}

- (void)drawTuoYuan {
    
    [self initDrawView];
    
    //求每一个的占比
    CGFloat endAngle;
    CGFloat startAngle = 0;
    CGPoint yPoint = CGPointMake(zzWidth/2, zzHeight/2);
    
    endAngle = startAngle + 0.35*2*M_PI;
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:yPoint radius:100 startAngle:startAngle endAngle:endAngle clockwise:YES];
    [path addLineToPoint:yPoint];
    [path closePath];
    
    
    CGFloat lab_x = yPoint.x + (100 + 30/2) * cos((startAngle + (endAngle - startAngle)/2)) - 30/2;
    CGFloat lab_y = yPoint.y + (100 + 20/2) * sin((startAngle + (endAngle - startAngle)/2)) - 20/2;
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(lab_x, lab_y, 50, 20)];
    lab.text = @"beijing";
    lab.textColor = [UIColor blackColor];
    lab.font = [UIFont boldSystemFontOfSize:12];
    lab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:lab];
    
    
    layer.path = path.CGPath;
    layer.fillColor = BYM_testColor.CGColor;
    layer.strokeColor = [UIColor clearColor].CGColor;
    [self.layer addSublayer:layer];
    
    startAngle = endAngle;
}

- (void)drawKlineTest{

    [self initDrawView];

    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(100, 100, 20, 100)];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    layer.fillColor = BYM_testColor.CGColor;
    layer.strokeColor = [UIColor redColor].CGColor;//可以省略的
    [self.layer addSublayer:layer];


    UIBezierPath *path2 = [UIBezierPath bezierPathWithRect:CGRectMake(109, 90, 2, 120)];
    CAShapeLayer *layer2 = [CAShapeLayer layer];
    layer2.path = path2.CGPath;
    layer2.fillColor = BYM_testColor.CGColor;
    layer2.strokeColor = [UIColor redColor].CGColor;//可以省略的
    [self.layer addSublayer:layer2];

}



@end
