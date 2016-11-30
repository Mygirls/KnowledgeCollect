//
//  SystemNoticeModel.h
//  BYMFinancing
//
//  Created by Administrator on 2016/11/2.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "BYMBaseModel.h"

@class ListModel;

@protocol ListModel;//官方是这么写的 不需要@end


@interface SystemNoticeModel : BYMBaseModel

@property(nonatomic,strong)NSString *end;
@property(nonatomic,strong)NSString *message;
@property(nonatomic)NSArray<ListModel> *list;
@end



@interface ListModel : BYMBaseModel

@property(nonatomic,copy)NSString *ID;
@property(nonatomic,copy)NSString *type;
@property(nonatomic,copy)NSString *titleUrl;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *titleDescription;
@property(nonatomic,copy)NSString *noticeUrl;
@property(nonatomic,copy)NSString *insertTime;
@end

