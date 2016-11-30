//
//  SystemNoticeViewController.m
//  BYMFinancing
//
//  Created by Administrator on 2016/11/2.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "SystemNoticeViewController.h"
#import "SystemNoticeTableView.h"
#import "SystemNoticeModel.h"
@interface SystemNoticeViewController ()

@property(nonatomic,strong) SystemNoticeTableView *noticeTableView;
@property(nonatomic,strong)NSArray *dataList;
@property(nonatomic,assign)NSInteger page;

@end

@implementation SystemNoticeViewController
/**
 *  首页系统公告页面：消息查看以后置灰 点击cell 可以展开
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"系统公告";
    
    [super _initViewBackItem];
    self.view.backgroundColor =HMColor(254, 254, 254);
    _page = 1;
    //初始化
    [self.view addSubview:self.noticeTableView];
    [self SystemNoticeLoadData];
    
}
//系统消息
- (SystemNoticeTableView *)noticeTableView
{
    if (_noticeTableView ==nil) {
        _noticeTableView = [[SystemNoticeTableView alloc] initWithFrame:CGRectMake(0, 64, KScreen_Width, KScreen_Height-64) style:UITableViewStylePlain ];
        BYM_WeakSelf(weakSelf);
        _noticeTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [weakSelf SystemNoticeloadMoreData];
        }];
    }
    return _noticeTableView;
}
//  系统公告  请求数据
- (void)SystemNoticeLoadData
{
    // 活动中心 4  // 系统消息3
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    NSString *str = [NSString stringWithFormat:  @"{\"pageSize\":\"%@\",\"currentPage\":\"%@\",\"type\":\"%@\"}",@"10", @"1",@"3"];
    [params setObject:str forKey:@"parameters"];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"Loading...";

    NSMutableArray *models = [[NSMutableArray alloc] init];
    [BYMBaseRequest requestWithURL:@"showNotice" params:params httpMethod:@"POST" blockSuccess:^(id result) {
        
        [hud hideAnimated:YES];
        if ([[result objectForKey:@"end"] isEqualToString:@"ok"]) {
            
            NSError *error;
            SystemNoticeModel *systemNoticeModel = [[SystemNoticeModel alloc] initWithDictionary:result error:&error];
            for (int i = 0; i < systemNoticeModel.list.count; i ++) {
                [models addObject:systemNoticeModel.list[i]];
            }
            self.dataList = models;
            _noticeTableView.SystemDataList = self.dataList;
            [_noticeTableView reloadData];
            
        } else  if ([[result objectForKey:@"end"] isEqualToString:@"error_code"]) {
            NSDictionary *obj = [result objectForKey:@"obj"];
            NSString *message = [obj objectForKey:@"message"];
            
        } else if ([[result objectForKey:@"end"] isEqualToString:@"error"]){
            
        }

    } blockFailure:^(id result) {
        hud.label.text = @"网络或服务器异常";
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                sleep(1);
                [hud hideAnimated:YES];
            });
        });
    }];
    
    
    
}


//系统公告 上拉刷新
- (void)SystemNoticeloadMoreData
{
    _page ++;
    NSString *pramStr = [NSString stringWithFormat:  @"{\"pageSize\":\"%d\",\"currentPage\":\"%ld\",\"type\":\"%d\"}",10,_page,3];
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    [params setObject:pramStr forKey:@"parameters"];
    NSMutableArray *models = [[NSMutableArray alloc] init];
    [BYMBaseRequest requestWithURL:@"showNotice" params:params httpMethod:@"POST" blockSuccess:^(id result) {
        [_noticeTableView.mj_footer endRefreshing];
        
        if ([result isKindOfClass:[NSError class]]) {
            
            _page--;
        }else if ([[result objectForKey:@"end"] isEqualToString:@"ok"]) {
            
            NSError *error;
            SystemNoticeModel *systemNoticeModel = [[SystemNoticeModel alloc] initWithDictionary:result error:&error];
            for (int i = 0; i < systemNoticeModel.list.count; i ++) {
                [models addObject:systemNoticeModel.list[i]];
            }
            self.dataList = [self.dataList arrayByAddingObjectsFromArray:models];
            _noticeTableView.SystemDataList = self.dataList;
            [_noticeTableView reloadData];
            
        } else if ([[result objectForKey:@"end"] isEqualToString:@"error"]) {
            _page--;
        } else if ([[result objectForKey:@"end"] isEqualToString:@"noData"]) {
            
            _page--;
        } else if ([[result objectForKey:@"end"] isEqualToString:@"paramError"]) {
            _page--;
        }else if ([[result objectForKey:@"end"] isEqualToString:@"noLogin"]) {
            _page--;
        } else {
            _page--;
        }

    } blockFailure:^(id result) {
        
    }];
    
    
}



- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}


- (void)backItemAction:(UIButton *)backButton
{
    [self.navigationController popViewControllerAnimated:YES];
}



@end
