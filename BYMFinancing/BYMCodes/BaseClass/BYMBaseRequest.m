//
//  BYMBaseRequest.m
//  BYMFinancing
//
//  Created by Administrator on 2016/11/1.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "BYMBaseRequest.h"
#import "AFNetworking.h"

@implementation BYMBaseRequest
//AFNetworking 3.0
+ (void)requestWithURL:(NSString *)url
                params:(NSMutableDictionary *)params
            httpMethod:(NSString *)httpMethod
          blockSuccess:(CompletionLoad)blockSuccess
          blockFailure:(FailureLoad)blockFailure{
 
    NSMutableString *urlStr = [NSMutableString stringWithFormat:@"%@%@",NETWORK_URL,url];
    
    // 初始化Manager
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    // 不加上这句话，会报“Request failed: unacceptable content-type: text/plain”错误，因为我们要获取text/plain类型数据
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 30;
    
    //af设置请求头
    [manager.requestSerializer setValue:[NSString md5:@"bym@201505"] forHTTPHeaderField:@"certification"];
    
    if ([httpMethod isEqualToString:@"GET"]) {  // 如果是get请求
        [manager GET:urlStr  parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            // 这里可以获取到目前的数据请求的进度
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
            if (blockSuccess) {
                blockSuccess(dic);
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            // 请求失败
            if (blockFailure) {
                blockFailure(error);
            }
        }];
        
    }else if ([httpMethod isEqualToString:@"POST"]) {
        [manager POST:urlStr parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
            if (blockSuccess) {
                blockSuccess(dic);
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (blockFailure) {
                blockFailure(error);
            }
        }];
        
        /*
         // 使用下面这个方法时候 参数传不到服务器，会显示参数错误
         [manager POST:urlStr parameters:dic constructingBodyWithBlock:^(id  _Nonnull formData) {
         // 拼接data到请求体，这个block的参数是遵守AFMultipartFormData协议的。
         
         } progress:^(NSProgress * _Nonnull uploadProgress) {
         // 这里可以获取到目前的数据请求的进度
         
         } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         // 请求成功，解析数据NSLog(@"%@", responseObject);
         NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
         if (block) {
         block(dic);
         }
         
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         // 请求失败
         if (block) {//NSLog(@"%@", [error localizedDescription]);
         block(error);
         }
         }];
         
         */
    }
}




@end
