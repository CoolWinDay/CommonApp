//
//  ComRequest.m
//  CommonApp
//
//  Created by lipeng on 16/3/8.
//  Copyright © 2016年 common. All rights reserved.
//

#import "ComRequest.h"
#import "ComNetworking.h"
#import "BaseModel.h"

@interface ComRequest()

@property(nonatomic, strong) ComNetworking *netWorking;

@end

@implementation ComRequest

#pragma mark - 子类继承方法
- (NSString *)baseUrl {
    return BaseUrl;
}

- (NSString *)requestUrl {
    return @"";
}

- (NSDictionary*)dataParams {
    return nil;
}

- (Class)modelClass {
    return [BaseModel class];
}

#pragma mark - 请求和参数

- (void)addDataParam:(NSObject *)param forKey:(NSString *)keyString {
    [self.netWorking addDataParam:param forKey:keyString];
}

- (void)addDataParamFromDictionary:(NSDictionary *)paramDic {
    [self.netWorking addDataParamFromDictionary:paramDic];
}

- (void)setParams {
    NSDictionary *dataParams = [self dataParams];
    if (dataParams) {
        NSLog(@"\n%@",dataParams);
        [self.netWorking addDataParamFromDictionary:dataParams];
    }
}

- (void)setRequestUrl {
    self.netWorking.urlBaseString = [self baseUrl];
    self.netWorking.urlPathString = [self requestUrl];
}

- (void)load {
    [self cancel];
    [self setRequestUrl];
    [self setParams];
    
    [AppCommon showLoading];
    __weak __typeof(self)weakSelf = self;
    [self.netWorking postRequestOnSuccess:^(id responseData) {
        [AppCommon hideLoading];
        __strong __typeof(self)strongSelf = weakSelf;
        
        id buildData = nil;
        NSError *error = nil;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
        if (!error) {
            buildData = dic;
            if ([strongSelf respondsToSelector:@selector(buildResponse:)]){
                buildData = [self buildResponse:dic];
            }
        }
        
        [self succeed:buildData];
    } onFailed:^(NSError *error) {
        [AppCommon hideLoading];
        __strong __typeof(self)strongSelf = weakSelf;
        [strongSelf failed:error];
    }];
}

- (void)requestSuccess:(RequestSuccessBlock)successBlock failed:(RequestFailedBlock)failedBlock {
    self.successBlock = successBlock;
    self.failedBlock = failedBlock;
    [self load];
}

- (void)cancel {
    [self.netWorking cancel];
}

#pragma mark - 请求结果

- (void)succeed:(id)response {
    if (self.successBlock) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.successBlock(response);
        });
    }
    if (self.completionBlock) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.completionBlock();
        });
    }
}

- (void)failed:(NSError *)error {
    if (error.code == -999) {
        // -999是cancel的情况，不予处理
        return;
    }
    if (self.failedBlock) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.failedBlock(error);
        });
    }
    if (self.completionBlock) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.completionBlock();
        });
    }
}

- (id)buildResponse:(NSDictionary *)dic {
    if (dic && [self respondsToSelector:@selector(modelClass)]) {
        NSDictionary *modelDic = [dic copy];
        if ([[dic allKeys] containsObject:@"data"]) {
            modelDic = dic[@"data"];
        }
        id model = [[self modelClass] yy_modelWithDictionary:modelDic];
        if (model) {
            return model;
        }
    }
    return dic;
}

#pragma mark -

- (ComNetworking *)netWorking {
    if (!_netWorking) {
        _netWorking = [[ComNetworking alloc] init];
    }
    return _netWorking;
}


@end
