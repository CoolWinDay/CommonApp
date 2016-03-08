//
//  ComRequest.m
//  CommonApp
//
//  Created by lipeng on 16/3/8.
//  Copyright © 2016年 common. All rights reserved.
//

#import "ComRequest.h"
#import "AFHTTPSessionManager.h"

@implementation ComRequest
{
    NSString *_urlString;
    NSDictionary *_parameters;
    NSURLSessionDataTask *_requestTask;
}

- (instancetype)initWithMethod:(NSString*)method
{
    if (self = [super init]) {
        _urlString = [NSString stringWithFormat:@"%@%@", BaseUrl, method];
        _parameters = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)addDataParam:(NSObject *)param forKey:(NSString *)keyString
{
    [_parameters setValue:param forKey:keyString];
}

- (void)sendRequest
{
    // 初始化Manager
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    // post请求
    _requestTask = [manager POST:_urlString parameters:_parameters constructingBodyWithBlock:^(id  _Nonnull formData) {
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 请求成功，解析数据
        NSLog(@"%@", responseObject);
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        
        NSLog(@"%@", dic);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 请求失败
        NSLog(@"%@", [error localizedDescription]);
    }];
}

- (void)cancel
{
    [_requestTask cancel];
}

@end
