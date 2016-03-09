//
//  ComRequest.m
//  CommonApp
//
//  Created by lipeng on 16/3/8.
//  Copyright © 2016年 common. All rights reserved.
//

#import "ComRequest.h"
#import "AFHTTPSessionManager.h"
#import "UserModel.h"

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
        
        _responseDataType = DATA_TYPE_JSON;
    }
    return self;
}

- (void)addDataParam:(NSObject *)param forKey:(NSString *)keyString
{
    [_parameters setValue:param forKey:keyString];
}

- (void)sendRequestOnSuccess:(SuccessBlock)successBlock onFailed:(FailedBlock)failedBlock
{
    [self addDataParam:@"data" forKey:[self yy_modelToJSONString]];
    
    // 初始化Manager
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    // TODO:__weak不好用，到里边就变成nil了
//    __weak __typeof(self)weakSelf = self;
    __typeof(self)weakSelf = self;
    // post请求
    _requestTask = [manager POST:_urlString parameters:_parameters constructingBodyWithBlock:^(id  _Nonnull formData) {
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseData) {
        // 请求成功
        weakSelf.responseData = responseData;
        NSLog(@"%@", responseData);
        
        id build = [weakSelf buildResponse];
        weakSelf.responseModel = build;
        
        if (successBlock) {
            successBlock(build);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        // 请求失败
        NSLog(@"%@", [error localizedDescription]);
        strongSelf.responseError = error;
        if (failedBlock) {
            failedBlock(error);
        }
    }];
}

- (void)cancel
{
    [_requestTask cancel];
}

- (id)buildResponse
{
    if (self.responseData){
        if (self.responseDataType == DATA_TYPE_JSON) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
            NSLog(@"%@", dic);
            
            if ([self respondsToSelector:@selector(responseJsonModelClass)]) {
                return [[self responseJsonModelClass] yy_modelWithDictionary:self.jsonObject];
            }
        }
        else {
            
        }
    }
    return nil;
}

- (NSDictionary *)jsonObject {
    if (self.responseData) {
        _jsonObject = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        NSLog(@"%@", _jsonObject);
        
        return _jsonObject;
    }
    return nil;
}

@end
