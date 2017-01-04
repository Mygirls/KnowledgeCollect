//
//  JQVolumeUtil.h
//  BYMFinancing
//
//  Created by administrator on 2016/12/22.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JQVolumeUtil : NSObject
{
    float _sliderVolumeValue;
}

@property(nonatomic,assign)float sliderVolumeValue;



/**
 *  单例
 */
+ (JQVolumeUtil *) shareInstance;

-(void)loadMPVolumeView;

- (void)registerVolumeChangeEvent;

- (void)unregisterVolumeChangeEvent;

@end
