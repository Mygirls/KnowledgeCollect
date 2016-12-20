//
//  JQFMDBManager.m
//  BYMFinancing
//
//  Created by administrator on 2016/12/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JQFMDBManager.h"
#import "JQFMDBPerson.h"

#define JQFMDBPathStr @"model.sqlite"

static JQFMDBManager *_manager = nil;

@interface JQFMDBManager ()

@property(nonatomic,strong)FMDatabase *db;
@end

@implementation JQFMDBManager

//生成路径
- (NSString *)fmdbPath{
    
    // 获得Documents目录路径
    NSArray *documentArr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [documentArr firstObject];
    NSString *filePath = [documentPath stringByAppendingPathComponent:JQFMDBPathStr];
    return filePath;
}

-(void)initDataBase{
    
    // 文件路径
    NSString *filePath = [self fmdbPath];
    
    // 实例化FMDataBase对象
    
    _db = [FMDatabase databaseWithPath:filePath];
    
    BOOL flag = [_db open];
    if (flag) {
        //数据库打开成功
        NSLog(@"数据库打开成功");
    }else {
        //数据库打开失败
        NSLog(@"数据库打开失败");
    }
    
    // 初始化数据表
    NSString *personSql = @"create table if not exists person(ID integer primary key  autoincrement, name text,phone text)";
    BOOL creat = [_db executeUpdate:personSql];
    if (creat) {
        NSLog(@"创建表成功");
    }else {
        NSLog(@"创建表失败");
    }
    
    [_db close];
    
}

#pragma mark - 接口
- (void)addPerson:(JQFMDBPerson *)person{
    
    [_db open];

    NSNumber *maxID = @(0);
    
    FMResultSet *res = [_db executeQuery:@"SELECT * FROM person "];
    //获取数据库中最大的ID
    while ([res next]) {
        if ([maxID integerValue] < [[res stringForColumn:@"person_ID"] integerValue]) {
            maxID = @([[res stringForColumn:@"person_id"] integerValue] ) ;
        }
        
    }
    maxID = @([maxID integerValue] + 1);
    BOOL insertResult = [_db executeUpdate:@"insert into person(name,phone) values(?,?)",person.name,person.phone];
    if (insertResult) {
        NSLog(@"insert ok");
    }else {
        NSLog(@"insert error");
    }
    [_db close];
    
}

- (void)deleteByID:(int)ID {
    
    [_db open];
    //语句1 ： 模糊删除 、 语句2：定位删除
//    BOOL delete = [_db executeUpdate:@"delete from person where name like ?",@"77"];
    BOOL delete = [_db executeUpdate:@"delete from person where ID = ?",[NSString stringWithFormat:@"%d",ID]];
    if (delete) {
        NSLog(@"删除数据成功");
    }else{
        NSLog(@"删除数据失败");
    }
    [_db close];

}

- (void)updateStudentName:(NSString *)name andPhone:(NSString *)phone WhereIDIsEqual:(int)ID {
    
    [_db open];//如果数据库没打开，可能会显示 错误 （The FMDatabase <FMDatabase: 0x6000000921b0> is not open.）

    // 语句1 当phone = phone时，设置name， 语句2 当ID = ID 时，设置name、phone
    // 注意：DB Error:1 "near "set": syntax error"  （这个是发错误） 、  DB Error:1 "no such column:?" （可能是空格问题，逗号之前没有空格） ？ 表示字符串（******否则 会出现 也指针错误 、切记*******）
    
//    BOOL update =  [_db executeUpdate:@"update person set name = ? where phone = ?",name,phone];
    BOOL update =  [_db executeUpdate:@"update person set name = ?, phone = ? where ID = ?",name,phone,@"2"];
    if (update) {
        NSLog(@"更新数据成功");
    }else{
        NSLog(@"更新数据失败");
    }
    
    [_db close];

}

- (NSMutableArray *)getAllPerson{
    [_db open];
    
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    
    FMResultSet *res = [_db executeQuery:@"SELECT * FROM person"];
    
    while ([res next]) {
        JQFMDBPerson *person = [[JQFMDBPerson alloc] init];
        person.name = [res stringForColumn:@"name"];
        person.phone = [res stringForColumn:@"phone"];
        person.ID = [[res stringForColumn:@"ID"] intValue];

        [dataArray addObject:person];
        
    }
    
    [_db close];
    
    return dataArray;
}


#pragma mark - 单例
+(instancetype)sharedDataBase{
    
    if (_manager == nil) {
        
        _manager = [[JQFMDBManager alloc] init];
        
        [_manager initDataBase];
        
    }
    
    return _manager;
    
}

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    
    if (_manager == nil) {
        
        _manager = [super allocWithZone:zone];
        
    }
    
    return _manager;
    
}

-(id)copy{
    
    return self;
    
}

-(id)mutableCopy{
    
    return self;
    
}

-(id)copyWithZone:(NSZone *)zone{
    
    return self;
    
}

-(id)mutableCopyWithZone:(NSZone *)zone{
    
    return self;
    
}


@end
