//
//  ComNetworking.m
//  CommonApp
//
//  Created by lipeng on 16/3/10.
//  Copyright © 2016年 common. All rights reserved.
//

#import "ComNetworking.h"
#import "AFHTTPSessionManager.h"

@implementation ComNetworking
{
    NSString *_urlString;
    NSDictionary *_parameters;
    NSURLSessionDataTask *_requestTask;
}

- (instancetype)initWithUrl:(NSString *)urlString
{
    if (self = [super init]) {
        _urlString = urlString;
        _parameters = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)addDataParam:(NSObject *)param forKey:(NSString *)keyString
{
    [_parameters setValue:param forKey:keyString];
}

- (void)sendRequestOnSuccess:(SuccessBlock)successBlock onFailed:(FailedBlock)failedBlock
{
    // 初始化Manager
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    // post请求
    _requestTask = [manager POST:_urlString parameters:_parameters constructingBodyWithBlock:^(id  _Nonnull formData) {
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseData) {
        if (successBlock) {
            successBlock(responseData);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 请求失败
        NSLog(@"%@", [error localizedDescription]);
        if (failedBlock) {
            failedBlock(error);
        }
    }];
}

- (void)cancel
{
    [_requestTask cancel];
}

@end
