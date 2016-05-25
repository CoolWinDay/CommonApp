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
        
        id buildData = nil;
        if ([strongSelf respondsToSelector:@selector(buildResponse:)]) {
            buildData = [strongSelf buildResponse:data];
        }
        
        if ([weakSelf respondsToSelector:@selector(succeed:)]) {
            [weakSelf succeed:buildData];
        }
        
//        if (weakSelf.successBlock) {
//            weakSelf.successBlock(buildData);
//        }
    } onFailed:^(NSError *error) {
        if ([weakSelf respondsToSelector:@selector(failed:)]) {
            [weakSelf failed:error];
        }
        
//        if (weakSelf.failedBlock) {
//            weakSelf.failedBlock(error);
//        }
    }];
}

- (void)requestSuccess:(SuccessBlock)successBlock failed:(FailedBlock)failedBlock {
    [self cancel];
    [self setParams];
    if ([self requestType] == RequestGet) {
        [self getRequestOnSuccess:successBlock onFailed:failedBlock];
    }
    else {
        [self postRequestOnSuccess:successBlock onFailed:failedBlock];
    }
}

- (void)postRequestOnSuccess:(SuccessBlock)successBlock onFailed:(FailedBlock)failedBlock {
    __weak __typeof(self)weakSelf = self;
    [self.netWorking postRequestOnSuccess:^(id data) {
        __strong __typeof(self)strongSelf = weakSelf;
        
        id buildData = nil;
        if ([strongSelf respondsToSelector:@selector(buildResponse:)]) {
            buildData = [strongSelf buildResponse:data];
        }
        
        if (successBlock) {
            successBlock(buildData ? : data);
        }
    } onFailed:^(NSError *error) {
        if (failedBlock) {
            failedBlock(error);
        }
    }];
}

- (void)getRequestOnSuccess:(SuccessBlock)successBlock onFailed:(FailedBlock)failedBlock {
    __weak __typeof(self)weakSelf = self;
    [self.netWorking getRequestOnSuccess:^(id data) {
        __strong __typeof(self)strongSelf = weakSelf;
        
        id buildData = nil;
        if ([strongSelf respondsToSelector:@selector(buildResponse:)]) {
            buildData = [strongSelf buildResponse:data];
        }
        
        if (successBlock) {
            successBlock(buildData ? : data);
        }
    } onFailed:^(NSError *error) {
        if (failedBlock) {
            failedBlock(error);
        }
    }];
}

#pragma mark - TBSDKServerDelegate
- (void)succeed:(id)response {
//    NSLog(@"\n%@",response.json);
//    [self constructSuccessData:[self responseJSONData:response]];
    if (self.successBlock) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.successBlock(response);
        });
    }
//    if (self.loadCompletionBlock) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            self.loadCompletionBlock(self,nil);
//        });
//    }
}

- (void)failed:(NSError *)error {
//    response.error.msg = [self userFriendlyErrorMsg:response.error];
//    NSLog(@"\n%@\n%@",response.error,response.json);
    if (self.failedBlock) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.failedBlock(error);
        });
    }
//    if (self.loadCompletionBlock) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            self.loadCompletionBlock(self,response.error);
//        });
//    }
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
            if (error)
                return nil;
            DLog(@"%@", dic);
            
            if ([self respondsToSelector:@selector(modelClass)]) {
                return [[self modelClass] yy_modelWithDictionary:dic];
            }
            else {
                return dic;
            }
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
