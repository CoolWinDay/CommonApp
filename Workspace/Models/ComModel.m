//
//  ComModel.m
//  CommonApp
//
//  Created by lipeng on 16/3/9.
//  Copyright © 2016年 common. All rights reserved.
//

#import "ComModel.h"
#import "ComNetworking.h"

@interface ComModel()

@property(nonatomic, strong) ComNetworking *netWorking;

@end

@implementation ComModel

- (NSString *)requestPath {
    return @"";
}

- (ComNetworking *)netWorking {
    if (!_netWorking) {
        _netWorking = [[ComNetworking alloc] initWithBaseUrl:BaseUrl path:[self requestPath]];
    }
    return _netWorking;
}

- (void)buildResponse:(id)responseData {
    
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
        [self.netWorking setValuesForKeysWithDictionary:dataParams];
    }
    //    // 添加额外的扩展参数, 和mtop系统参数平级
    //    NSDictionary *mtopParams = [self mtopParams];
    //    if (mtopParams) {
    //        [self.mtopRequest addExtParameters:mtopParams];
    //    }
}

- (void)loadOnSuccess:(SuccessBlock)successBlock onFailed:(FailedBlock)failedBlock {
    __weak __typeof(self)weakSelf = self;
    [self.netWorking postRequestOnSuccess:^(id data) {
        __strong __typeof(self)strongSelf = weakSelf;
        
        if ([strongSelf respondsToSelector:@selector(buildResponse:)]) {
            [strongSelf buildResponse:data];
        }
        
        if (successBlock) {
            successBlock(strongSelf);
        }
    } onFailed:^(NSError *error) {
        if (failedBlock) {
            failedBlock(error);
        }
    }];
}

- (void)load {
    [self cancel];
    [self setParams];
    
    __weak __typeof(self)weakSelf = self;
    [self.netWorking postRequestOnSuccess:^(id data) {
        __strong __typeof(self)strongSelf = weakSelf;
        
        if ([strongSelf respondsToSelector:@selector(buildResponse:)]) {
            [strongSelf buildResponse:data];
        }
        
        if ([weakSelf respondsToSelector:@selector(succeed:)]) {
            [weakSelf succeed:weakSelf];
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

@end
