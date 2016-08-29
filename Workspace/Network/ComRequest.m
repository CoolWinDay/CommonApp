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

- (NSString *)requestPath {
    return @"";
}

- (NSString *)urlPathString {
    if (!_urlPathString) {
        if ([self respondsToSelector:@selector(requestPath)]) {
            _urlPathString = [self requestPath];
        }
        else {
            _urlPathString = @"";
        }
    }
    return _urlPathString;
}

- (ComNetworking *)netWorking {
    if (!_netWorking) {
        _netWorking = [[ComNetworking alloc] initWithBaseUrl:BaseUrl path:self.urlPathString];
    }
    return _netWorking;
}

- (void)addDataParam:(NSObject *)param forKey:(NSString *)keyString {
    [self.netWorking addDataParam:param forKey:keyString];
}

- (void)addDataParamFromDictionary:(NSDictionary *)paramDic {
    [self.netWorking addDataParamFromDictionary:paramDic];
}

- (NSDictionary *)getParameters {
    return self.netWorking.parameters;
}

- (NSDictionary*)dataParams {
    return nil;
}

- (void)setParams {
//    //1, check params
//    NSDictionary *headers = [self httpHeader];
//    if (headers) {
//        [self.mtopRequest addHttpHeaders:headers];
//    }
    NSDictionary *dataParams = [self dataParams];
    if (dataParams) {
        NSLog(@"\n%@",dataParams);
        [self.netWorking addDataParamFromDictionary:dataParams];
    }
//    // 添加额外的扩展参数, 和mtop系统参数平级
//    NSDictionary *mtopParams = [self mtopParams];
//    if (mtopParams) {
//        [self.mtopRequest addExtParameters:mtopParams];
//    }
}

- (RequestType)requestType {
    return RequestPost;
}

- (ResponseType)responseType {
    return ResponseJson;
}

- (void)load {
    [self cancel];
    [self setParams];
    
    __weak __typeof(self)weakSelf = self;
    [self.netWorking postRequestOnSuccess:^(id data) {
        __strong __typeof(self)strongSelf = weakSelf;
        [strongSelf responseOnSuccess:data];
    } onFailed:^(NSError *error) {
        __strong __typeof(self)strongSelf = weakSelf;
        [strongSelf responseOnFailed:error];
    }];
}

- (void)requestSuccess:(RequestSuccessBlock)successBlock failed:(RequestFailedBlock)failedBlock {
    [self cancel];
    [self setParams];
    
    __weak __typeof(self)weakSelf = self;
    if ([self requestType] == RequestGet) {
        [self.netWorking postRequestOnSuccess:^(id data) {
            __strong __typeof(self)strongSelf = weakSelf;
            strongSelf.successBlock = successBlock;
            [strongSelf responseOnSuccess:data];
        } onFailed:^(NSError *error) {
            __strong __typeof(self)strongSelf = weakSelf;
            strongSelf.failedBlock = failedBlock;
            [strongSelf responseOnFailed:error];
        }];
    }
    else {
        [self.netWorking getRequestOnSuccess:^(id data) {
            __strong __typeof(self)strongSelf = weakSelf;
            strongSelf.successBlock = successBlock;
            [strongSelf responseOnSuccess:data];
        } onFailed:^(NSError *error) {
            __strong __typeof(self)strongSelf = weakSelf;
            [strongSelf responseOnFailed:error];
        }];
    }
}

- (void)responseOnSuccess:(id)data {
    id buildData = nil;
    if ([self respondsToSelector:@selector(buildResponse:)]) {
        buildData = [self buildResponse:data];
    }
    [self succeed:buildData];
}

- (void)responseOnFailed:(NSError *)error {
    [self failed:error];
}

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

- (void)cancel {
    [self.netWorking cancel];
}

- (id)buildResponse:(id)responseData {
    if (responseData){
        if ([self responseType] == ResponseXml) {
            NSXMLParser *parser = [[NSXMLParser alloc] initWithData:responseData];
            return parser;
        }
        else if ([self responseType] == ResponseJson) {
            NSError *error = nil;
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
            DLog(@"%@", [dic yy_modelToJSONString]);
            if (error)
                return nil;
            
            if (dic && [self respondsToSelector:@selector(modelClass)]) {
                id model = [[self modelClass] yy_modelWithDictionary:dic];
                if (model) {
                    return model;
                }
            }
            return dic;
        }
        else {
            return responseData;
        }
    }
    return nil;
}

- (Class)modelClass {
    return [BaseModel class];
}

@end
