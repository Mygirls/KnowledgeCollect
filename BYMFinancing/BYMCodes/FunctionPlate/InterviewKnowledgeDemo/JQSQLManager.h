//
//  JQManager.h
//  BYMFinancing
//
//  Created by administrator on 2016/12/14.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JQSqliteStudent.h"
#import <sqlite3.h>

@interface JQSQLManager : NSObject


/**
 *  打开数据库
 */
+ (sqlite3 *)openDB;

/**
 *  关闭数据库
 */
+ (void)closeDB;

/**
 *  数据库insert 数据
 */
+ (BOOL)addStudent:(JQSqliteStudent *)stu;

/**
 *  数据库select 数据
 */
+ (NSMutableArray *)findAllStudent;

/**
 *  数据库update 数据
 */
+ (BOOL)updateStudentName:(NSString *)name andAge:(int)age andPhone:(NSString *)phone WhereIDIsEqual:(int)ID;

/**
 *  数据库delete 数据
 */
+ (BOOL)deleteByID:(int)ID;









@end
