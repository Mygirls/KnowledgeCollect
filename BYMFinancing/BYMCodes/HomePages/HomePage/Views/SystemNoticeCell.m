//
//  SystemNoticeCell.m
//  BYMFinancing
//
//  Created by Administrator on 2016/11/2.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "SystemNoticeCell.h"

@interface SystemNoticeCell ()

@property (nonatomic, strong)    UILabel *timeLabel;
@property (nonatomic, strong)    UILabel *titleLabel;
@property (nonatomic, strong)    UILabel *detailLabel;

@end
@implementation SystemNoticeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initSubViews];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews
{
    _backImg = [[UIImageView alloc]init];
    [self.contentView addSubview:_backImg];
    
    _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 8, KScreen_Width, 21)];
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_timeLabel];
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(70, 37, KScreen_Width-90, 21)];
    [self.contentView addSubview:_titleLabel];
    
    _detailLabel = [[UILabel alloc]init];
    [self.contentView addSubview:_detailLabel];
    
    _timeLabel.textColor = HMColor(128, 128, 128);
    _timeLabel.font = [UIFont systemFontOfSize:13];
    
    _titleLabel.textColor = HMColor(51, 51, 51);
    _titleLabel.font = [UIFont systemFontOfSize:15];
    
    _detailLabel.textColor = HMColor(128, 128, 128);
    _detailLabel.font = [UIFont systemFontOfSize:13];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //距离上下左右 55 15 58 28
    [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView.mas_leading).with.offset(58);
        make.top.equalTo(self.contentView.mas_top).with.offset(55);
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-15);
        make.trailing.equalTo(self.contentView.mas_trailing).with.offset(-28);
    }];
    
    _timeLabel.text = [NSString stringWithFormat:@"%@",[UtilityClass dateStringWithstring:self.SystemModel.insertTime]];
    _titleLabel.text = [NSString stringWithFormat:@"%@",self.SystemModel.title];
    _backImg.frame = CGRectMake(21, 0, KScreen_Width-36, self.height);

    //html5转z
    NSString * htmlString =  [NSString stringWithFormat:@"%@",self.SystemModel.titleDescription];;
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    
    _detailLabel.attributedText = attrStr;
    if (self.height == 100) {
        _detailLabel.numberOfLines = 1;
        
    } else {
        _detailLabel.numberOfLines = 0;
    }
    
    NSString *comment = [NSString stringWithFormat:@"%@",self.SystemModel.titleDescription];;
    if ([comment isEqualToString:@"<null>"] ||[comment isEqualToString:@"(null)"] ) {
        _detailLabel.text = @"";
    }
    
}

-(void)setSystemModel:(ListModel *)SystemModel
{
    _SystemModel = SystemModel;
    
}

@end
