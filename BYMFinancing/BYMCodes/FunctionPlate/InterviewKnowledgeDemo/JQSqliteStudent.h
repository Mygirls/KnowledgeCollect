//
//  JQSqliteStudent.h
//  BYMFinancing
//
//  Created by administrator on 2016/12/14.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JQSqliteStudent : NSObject
// 四个属性分别对应数据库里面的四个字段
@property (nonatomic, assign)int ID;
@property (nonatomic, assign)int age;
@property (nonatomic, retain)NSString *name;
@property (nonatomic, retain)NSString *phone;

- (instancetype)initWithName:(NSString *)name andAge:(int)age andPhone:(NSString *)phone andID:(int)ID;
@end
