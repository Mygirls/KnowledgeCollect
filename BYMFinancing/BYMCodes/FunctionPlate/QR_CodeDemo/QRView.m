//
//  QRView.m
//  QRWeiXinDemo
//
//  Created by lovelydd on 15/4/25.
//  Copyright (c) 2015年 lovelydd. All rights reserved.
//

#import "QRView.h"
static NSTimeInterval kQrLineanimateDuration = 0.02;

@interface QRView()
{
    UIImageView *qrLine;
    CGFloat qrLineY;
    QRMenu *qrMenu;
}
@property(nonatomic,strong)NSTimer *timer;
@end


@implementation QRView
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (!qrLine) {
        [self initQRLine];
        if (_timer == nil ) {
            _timer = [NSTimer scheduledTimerWithTimeInterval:kQrLineanimateDuration target:self selector:@selector(show) userInfo:nil repeats:YES];
        }
    }
    
    if (!qrMenu) {
        [self initQrMenu];
    }
}

/**
 *  下面灰色视图《二维码 和  条形码 的选择》
 */
- (void)initQrMenu {
    
    CGFloat height = 100;
    CGFloat width = self.bounds.size.width;
    qrMenu = [[QRMenu alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - height, width, height)];
    qrMenu.backgroundColor = [UIColor orangeColor];
    [self addSubview:qrMenu];
    __weak typeof(self)weakSelf = self;
    qrMenu.didSelectedBlock = ^(QRItem *item){
        if ([weakSelf.delegate respondsToSelector:@selector(scanTypeConfig:)] ) {
            [weakSelf.delegate scanTypeConfig:item];
        }
    };
}

#pragma mark - 扫描二维码框中的移动的细线
- (void)initQRLine {
    qrLine  = [[UIImageView alloc] initWithFrame:CGRectMake((self.bounds.size.width  - self.transparentArea.width)/2, (self.bounds.size.height - self.transparentArea.height)/2, 439/2, 3/2)];
    
    NSLog(@"self.transparentArea : %f",self.transparentArea.height);
    qrLine.image = [UIImage imageNamed:@"saomiaoxian"];
    qrLine.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:qrLine];
    qrLineY = qrLine.frame.origin.y;
}

/**
 *  定时器：二维码扫描的时候，绿线上下滑动效果
 */
- (void)show {
    
    [UIView animateWithDuration:kQrLineanimateDuration animations:^{
        CGRect rect = qrLine.frame;
        rect.origin.y = qrLineY;
        qrLine.frame = rect;
        
    } completion:^(BOOL finished) {
        
        CGFloat maxBorder = self.frame.size.height / 2 + self.transparentArea.height / 2 - 4;
        if (qrLineY > maxBorder) {
            
            qrLineY = self.frame.size.height / 2 - self.transparentArea.height /2;
        }
        qrLineY++;
    }];
}

//解决当父View释放时，当前视图因为被Timer强引用而不能释放的问题
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (!newSuperview) {
        [self invalidateTimer];
    }
}

- (void)invalidateTimer
{
    [_timer invalidate];
    _timer = nil;
}

#pragma mark - 扫描区域的相关设置
- (void)drawRect:(CGRect)rect {
    
    //整个二维码扫描界面的颜色
    CGSize screenSize =[UIScreen mainScreen].bounds.size;
    CGRect screenDrawRect =CGRectMake(0, 0, screenSize.width,screenSize.height);
    
    //中间清空的矩形框
    CGRect clearDrawRect = CGRectMake(screenDrawRect.size.width / 2 - self.transparentArea.width / 2,
                                      screenDrawRect.size.height / 2 - self.transparentArea.height / 2,
                                      self.transparentArea.width,self.transparentArea.height);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [self addScreenFillRect:ctx rect:screenDrawRect];   //设置整个View 的透明度
    
    [self addCenterClearRect:ctx rect:clearDrawRect];   //clear扫描区域
    
    [self addWhiteRect:ctx rect:clearDrawRect];         //扫描区域 add 白色边框
    
    [self addCornerLineWithContext:ctx rect:clearDrawRect]; //扫描区域：画四个边角
    
    
}

- (void)addScreenFillRect:(CGContextRef)ctx rect:(CGRect)rect {
    CGContextSetRGBFillColor(ctx, 40 / 255.0,40 / 255.0,40 / 255.0,0.5);
    CGContextFillRect(ctx, rect);   //draw the transparent layer
}

- (void)addCenterClearRect :(CGContextRef)ctx rect:(CGRect)rect {
    
    CGContextClearRect(ctx, rect);  //clear the center rect  of the layer
}

- (void)addWhiteRect:(CGContextRef)ctx rect:(CGRect)rect {
    
    CGContextStrokeRect(ctx, rect);
    CGContextSetRGBStrokeColor(ctx, 1, 1, 1, 1);
    CGContextSetLineWidth(ctx, 0.8);
    CGContextAddRect(ctx, rect);
    CGContextStrokePath(ctx);
}

/**
 *  扫描区域：画四个边角
 */
- (void)addCornerLineWithContext:(CGContextRef)ctx rect:(CGRect)rect{
    CGContextSetLineWidth(ctx, 2);
    CGContextSetRGBStrokeColor(ctx, 83 /255.0, 239/255.0, 111/255.0, 1);//绿色
    
    //左上角
    CGPoint poinsTopLeftA[] = {
        CGPointMake(rect.origin.x+0.7, rect.origin.y),
        CGPointMake(rect.origin.x+0.7 , rect.origin.y + 15)
    };
    
    CGPoint poinsTopLeftB[] = {CGPointMake(rect.origin.x, rect.origin.y +0.7),CGPointMake(rect.origin.x + 15, rect.origin.y+0.7)};
    [self addLine:poinsTopLeftA pointB:poinsTopLeftB ctx:ctx];
    
    //左下角
    CGPoint poinsBottomLeftA[] = {CGPointMake(rect.origin.x+ 0.7, rect.origin.y + rect.size.height - 15),CGPointMake(rect.origin.x +0.7,rect.origin.y + rect.size.height)};
    CGPoint poinsBottomLeftB[] = {CGPointMake(rect.origin.x , rect.origin.y + rect.size.height - 0.7) ,CGPointMake(rect.origin.x+0.7 +15, rect.origin.y + rect.size.height - 0.7)};
    [self addLine:poinsBottomLeftA pointB:poinsBottomLeftB ctx:ctx];
    
    //右上角
    CGPoint poinsTopRightA[] = {CGPointMake(rect.origin.x+ rect.size.width - 15, rect.origin.y+0.7),CGPointMake(rect.origin.x + rect.size.width,rect.origin.y +0.7 )};
    CGPoint poinsTopRightB[] = {CGPointMake(rect.origin.x+ rect.size.width-0.7, rect.origin.y),CGPointMake(rect.origin.x + rect.size.width-0.7,rect.origin.y + 15 +0.7 )};
    [self addLine:poinsTopRightA pointB:poinsTopRightB ctx:ctx];
    
    CGPoint poinsBottomRightA[] = {CGPointMake(rect.origin.x+ rect.size.width -0.7 , rect.origin.y+rect.size.height+ -15),CGPointMake(rect.origin.x-0.7 + rect.size.width,rect.origin.y +rect.size.height )};
    CGPoint poinsBottomRightB[] = {CGPointMake(rect.origin.x+ rect.size.width - 15 , rect.origin.y + rect.size.height-0.7),CGPointMake(rect.origin.x + rect.size.width,rect.origin.y + rect.size.height - 0.7 )};
    [self addLine:poinsBottomRightA pointB:poinsBottomRightB ctx:ctx];
    CGContextStrokePath(ctx);
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(rect.origin.x+0.7, rect.origin.y + rect.size.height - 15+20, [UIScreen mainScreen].bounds.size.width-(rect.origin.x+0.7)*2, 60) ];
    label.text  = @"将二维码/条码放入框内，即可自动扫描";
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:10];
    [self addSubview:label];
}

- (void)addLine:(CGPoint[])pointA pointB:(CGPoint[])pointB ctx:(CGContextRef)ctx {
    CGContextAddLines(ctx, pointA, 2);
    CGContextAddLines(ctx, pointB, 2);
}


@end
