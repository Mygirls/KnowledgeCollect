//
//  SystemNoticeTableView.m
//  BYMFinancing
//
//  Created by Administrator on 2016/11/2.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "SystemNoticeTableView.h"
#import "SystemNoticeCell.h"
#import "SystemNoticeModel.h"

@interface SystemNoticeTableView ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSMutableArray *getCellIds;
@property(nonatomic,strong)ListModel *SystemModel;
@property(nonatomic,strong)NSMutableArray *array;
@property(nonatomic, strong)NSMutableDictionary *stateDic;
@property(nonatomic, assign)NSInteger selectRow;
@end

@implementation SystemNoticeTableView
/**
 *  首页系统公告页面 TableView：消息查看以后置灰 点击cell 可以展开
 */

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor =  HMColor(240, 244, 245);
        self.backgroundView = nil;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.rowHeight = 100;
    }
    self.selectRow = -1;
    _stateDic = [[NSMutableDictionary alloc] init];
    _array = [[NSMutableArray alloc]init];
    return self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *SystemNoticeID = @"SystemNoticeCellID";
    SystemNoticeCell *cell = [tableView dequeueReusableCellWithIdentifier:SystemNoticeID];
    if (cell == nil) {
        cell = [[SystemNoticeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SystemNoticeID];
        cell.backgroundColor = [UIColor clearColor];
        UILabel *coverLabel = [[UILabel alloc] initWithFrame:CGRectMake(22, 0, 5, 50)];
        coverLabel.backgroundColor = HMColor(240, 244, 245);
        coverLabel.tag = 1;
        [cell.contentView addSubview:coverLabel];
        
    }
    cell.SystemModel = self.SystemDataList[indexPath.row];
    NSArray *getCellIds = [self getDataWithDataFilePath];
    NSString *IDstr = [NSString stringWithFormat:@"%@",cell.SystemModel.ID];
    if ([getCellIds containsObject:IDstr]){
        cell.backImg.image = [[UIImage imageNamed:@"gd_hdzx_ydxx2"] stretchableImageWithLeftCapWidth:100 topCapHeight:80];
    }else{
        cell.backImg.image = [[UIImage imageNamed:@"gd_hdzx_wdxx2"] stretchableImageWithLeftCapWidth:100 topCapHeight:80];

    }
    UILabel *coverLabel = (UILabel *)[cell.contentView viewWithTag:1];
    if (indexPath.row ==0) {
          coverLabel.hidden = NO;
    }else{
        coverLabel.hidden = YES;
    }
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //1.获取当前单元格对应的key
    NSString *key = [NSString stringWithFormat:@"%ld",indexPath.row];
    BOOL isShow = [[_stateDic objectForKey:key] boolValue];
    if (isShow == NO) {
        return 100;
    } else {
        //获取当前单元格现实的文本
        ListModel *model = (ListModel *)self.SystemDataList[indexPath.row];
        NSString *comment = [NSString stringWithFormat:@"%@",model.titleDescription];;
        UIFont *font = [UIFont systemFontOfSize:13];
        // 计算字符串显示的高度
        if ([comment isEqualToString:@"<null>"] ||[comment isEqualToString:@"(null)"] ) {
            return 100;
        }
        CGRect rect = [comment boundingRectWithSize:CGSizeMake(KScreen_Width-77, 600) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:NULL];
        CGFloat height = rect.size.height;
        return  height+100 ;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *key = [NSString stringWithFormat:@"%ld",indexPath.row];
    //2.获取当前单元格的状态
    BOOL state = [[_stateDic objectForKey:key] boolValue];
    //3.对原有的状态进行改变
    [_stateDic setObject:@(!state) forKey:key];
    //4.刷新(指定集合)单元格
    self.selectRow = indexPath.row;
    
    self.SystemModel = self.SystemDataList[indexPath.row];
    NSString *str1 = [NSString stringWithFormat:@"%@",self.SystemModel.ID];
    NSArray *getCellIds = [self getDataWithDataFilePath];
    if ([getCellIds containsObject:str1]){
    
    }else{
        [_array addObject:str1];
        [self saveDataInDataFilePath];
    }
    [self reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.SystemDataList.count;
}

- (void)saveDataInDataFilePath
{
    NSMutableData *memberdata = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]
                                 initForWritingWithMutableData:memberdata];
    [archiver encodeObject:_array forKey:@"noticeIDs"];
    [archiver finishEncoding];
    [memberdata writeToFile:[self dataFilePath] atomically:YES];
}

- (NSArray *)getDataWithDataFilePath
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:[self dataFilePath]])
    {
        NSData *data = [[NSMutableData alloc]
                        initWithContentsOfFile:[self dataFilePath]];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc]
                                         initForReadingWithData:data];
        NSArray *memfromfile = [unarchiver decodeObjectForKey:@"noticeIDs"];
        [unarchiver finishDecoding];
        _array = [memfromfile mutableCopy];
        return memfromfile;
    }
    
    return nil;
}

- (NSString *) dataFilePath
{
    NSString *result = nil;
    NSArray *folders = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsFolder = [folders objectAtIndex:0];
    result = [documentsFolder stringByAppendingPathComponent:@"saveDataOfNoticeIDs"];
    return result;
    
}


@end
