//
//  BYMBaseRequest.h
//  BYMFinancing
//
//  Created by Administrator on 2016/11/1.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CompletionLoad)(id result);
typedef void(^FailureLoad)(id result);

@interface BYMBaseRequest : NSObject

+ (void)requestWithURL:(NSString *)url
                params:(NSMutableDictionary *)params
            httpMethod:(NSString *)httpMethod
          blockSuccess:(CompletionLoad)blockSuccess
          blockFailure:(FailureLoad)blockFailure;
@end
