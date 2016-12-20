//
//  JQFMDBManager.h
//  BYMFinancing
//
//  Created by administrator on 2016/12/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JQFMDBPerson;

@interface JQFMDBManager : NSObject

+(instancetype)sharedDataBase;

//add
- (void)addPerson:(JQFMDBPerson *)person;

//delete
- (void)deleteByID:(int)ID;

//update
- (void)updateStudentName:(NSString *)name andPhone:(NSString *)phone WhereIDIsEqual:(int)ID ;

//select
- (NSMutableArray *)getAllPerson;

@end
