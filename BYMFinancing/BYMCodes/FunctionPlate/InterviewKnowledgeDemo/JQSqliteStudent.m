//
//  JQSqliteStudent.m
//  BYMFinancing
//
//  Created by administrator on 2016/12/14.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JQSqliteStudent.h"

@implementation JQSqliteStudent

-(instancetype)initWithName:(NSString *)name andAge:(int)age andPhone:(NSString *)phone andID:(int)ID {
    
    self = [super init];
    if (self) {
        
        self.name = name;
        self.age = age;
        self.phone = phone;
        self.ID = ID;
    }
    return self;
}
@end
