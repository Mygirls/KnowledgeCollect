//
//  UnderstandingLevelPrivilegeViewController.m
//  BYMFinancing
//
//  Created by Administrator on 2016/11/8.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "UnderstandingLevelPrivilegeViewController.h"

@interface UnderstandingLevelPrivilegeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView    *tableView;

@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, strong) NSMutableArray *cellArray;

@end

@implementation UnderstandingLevelPrivilegeViewController

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [@[@"升级为V1会员：系统即刻自动赠送500个喵币",@"升级为V2会员：系统即刻自动赠送1000个喵币",@"升级为V3会员：系统即刻自动赠送2500个喵币，系统自动加息0.1%",@"升级为V4会员：系统即刻自动赠送4000个喵币；系统自动加息0.2%；享生日祝福及生日大礼包（888元投资券）",@"升级为V5会员：系统即刻自动赠送6000个喵币；系统自动加息0.3%；享生日祝福及生日大礼包（1888元投资券）；累计签到额外奖励喵币翻倍（详情见签到页面说明）",@"升级为V6会员：系统即刻自动赠送8000个喵币；系统自动加息0.4%；享生日祝福及生日大礼包（2888元投资券）；累计签到额外奖励喵币翻倍（详情见签到页面说明）",@"升级为V7会员：系统即刻自动赠送10000个喵币；系统自动加息0.5%；享生日祝福及生日大礼包（3888元投资券）；累计签到额外奖励喵币翻倍（详情见签到页面说明）",@""]mutableCopy];
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [super _initViewBackItem];
    
    
    self.title =@"了解等级详情";
    self.lineHad = YES;
    [self _initViewTableView];

}

-(void)setLevel:(NSInteger)level{
    _level = level;
    [_tableView reloadData];
}

- (void)_initViewTableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, KScreen_Width, KScreen_Height-64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = NO;
        _tableView.showsVerticalScrollIndicator = YES;
        _tableView.backgroundColor = HMColor(229, 229, 229);
        [self.view addSubview:self.tableView];
    }
    [self creatTableViewHeadView];
}

-(void)creatTableViewHeadView{
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,KScreen_Width, 30*(KScreen_Width/320))];
    headView.backgroundColor = HMColor(229, 229, 229);
    _tableView.tableHeaderView = headView;
    
    UILabel *headeLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(30*KScreen_Width/320,(30*(KScreen_Width/320)-15)/2.0,50, 15)];
    headeLabel1.text = @"等级";
    headeLabel1.font = [UIFont boldSystemFontOfSize:12];
    headeLabel1.textAlignment = NSTextAlignmentLeft;
    headeLabel1.textColor = HMColor(51, 51, 51);
    [headView addSubview:headeLabel1];
    UILabel *headeLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(headeLabel1.right+45*(KScreen_Width/320), (30*(KScreen_Width/320)-15)/2.0,50, 15)];
    headeLabel2.text = @"特权";
    headeLabel2.textAlignment = NSTextAlignmentLeft;
    headeLabel2.textColor = HMColor(51, 51, 51);
    headeLabel2.font = [UIFont boldSystemFontOfSize:12];
    [headView addSubview:headeLabel2];
    
}

#pragma mark-UITablewViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"PrivilegeCell";
    
    
    UITableViewCell  * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.section == self.dataArr.count-1) {          /**  添加佰亿猫图片  */
        
        CGFloat width = 129*(KScreen_Width/320);
        CGFloat height = 18*(KScreen_Width/320);
        UIImageView *footerImageView= [[UIImageView alloc]initWithFrame:CGRectMake((KScreen_Width-width)/2.0, 22*(KScreen_Width/320), width, height)];
        footerImageView.contentMode = UIViewContentModeScaleAspectFit;
        footerImageView.image = [UIImage imageNamed:@"watermark"];
        [cell.contentView addSubview:footerImageView];
        cell.backgroundColor = HMColor(229, 229, 229);
        
    }else{
        
        cell.backgroundColor = [UIColor whiteColor];
        NSArray *vipImageViewArr = @[@"vip_icon1",@"vip_icon2",@"vip_icon3",@"vip_icon4",@"vip_icon5",@"vip_icon6",@"vip_icon7"];
        /**   vip等级图片 */
        UIImageView *levelImageView = [[UIImageView alloc]initWithFrame:CGRectMake(35*KScreen_Width/320, 200,10, 10)];
        levelImageView.image = [UIImage imageNamed:vipImageViewArr[indexPath.section]];
        [cell.contentView addSubview:levelImageView];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,KScreen_Width, .5)];
        lineView.backgroundColor = HMColor(229, 229, 229);
        [cell.contentView addSubview:lineView];
        /**   对数组进行分割 */
        NSArray *listArr = [_dataArr[indexPath.section] componentsSeparatedByString:@"；"];
        _cellArray = [[NSMutableArray alloc]init];              /**  用来存储所有privilegeLabel对象  */
        
        for (NSInteger i = 0; i < listArr.count; i++) {
            
            UIView *imageView = [[UIView alloc]initWithFrame:CGRectMake(80*(KScreen_Width/320), 10*KScreen_Width/320, 5, 5)];
            [imageView.layer setCornerRadius:imageView.frame.size.width/2.0];
            if (indexPath.section+1 == _level) {
                imageView.backgroundColor = HMColor(247, 69, 69);
                
            }else{
                imageView.backgroundColor = HMColor(229, 229, 229);
                
            }
            [cell.contentView addSubview:imageView];
            
            CGSize size = [self sizeForString:listArr[i] andWidth:KScreen_Width-imageView.right-4-10 andFont:BYM_LabelFont(12)];
            
            UILabel *privilegeLabel = [[UILabel alloc]initWithFrame:CGRectMake(imageView.right+4, 16*KScreen_Width/320, KScreen_Width-imageView.right-4-10, size.height+5)];
            
            CGSize size1 = [self sizeForString:@"白云" andWidth:KScreen_Width-imageView.right-4-10 andFont:BYM_LabelFont(12)];          /** 获取到只有一行时的行高 */
            /** section为1 时的位置 */
            levelImageView.top = 16*KScreen_Width/320+(size.height+5-10)/2.0;
            imageView.top =16*KScreen_Width/320+(size1.height-5)/2.0;
           
            privilegeLabel.backgroundColor = [UIColor clearColor];
            privilegeLabel.numberOfLines = 0;
            privilegeLabel.font = BYM_LabelFont(12);
            privilegeLabel.textColor = HMColor(51, 51, 51);
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:listArr[i]];
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            [paragraphStyle setLineSpacing:5];                    /** 调整行间距  */
            [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [listArr[i] length])];
            privilegeLabel.attributedText = attributedString;
            [cell.contentView addSubview:privilegeLabel];
            
            if ( i > 0 ) {                                        /** 更新label和imageView的frame */
                UILabel *label = [_cellArray lastObject];
                privilegeLabel.top = label.bottom+6*KScreen_Width/320 ;
                imageView.top = privilegeLabel.top+(size1.height-5)/2.0;
               
            }
            [_cellArray addObject:privilegeLabel];
            if (indexPath.section >0) {                            /**  更新等级图片的位置   */
                UILabel *label = [_cellArray lastObject];
                levelImageView.top = (label.bottom+16*KScreen_Width/320-10)/2.0;
            }
        }
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == self.dataArr.count-1) {
        return 62*(KScreen_Width/320);
    }else {
        UILabel *label = [_cellArray lastObject];
        return  label.bottom+16*KScreen_Width/320;
    }
}

#pragma mark - 根据NSString的宽度和文字大小来计算label的区域
- (CGSize)sizeForString:(NSString *)str andWidth:(CGFloat)width andFont:(UIFont *)font
{
    return [str boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil].size;
}

- (void)backItemAction:(UIButton *)backButton
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
