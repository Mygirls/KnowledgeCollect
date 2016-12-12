//
//  Student.h
//  BYMFinancing
//
//  Created by administrator on 2016/12/2.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Course.h"
@interface Student : NSObject
{
    NSString *name;
    
    Course *course;
    
    NSInteger point;

    NSArray *otherStudent;

}

@property(nonatomic,copy)NSString *testKVOValue;
@end
