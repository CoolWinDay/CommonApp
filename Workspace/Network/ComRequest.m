//
//  ComRequest.m
//  CommonApp
//
//  Created by lipeng on 16/3/8.
//  Copyright © 2016年 common. All rights reserved.
//

#import "ComRequest.h"
#import "ComNetworking.h"

@interface ComRequest()

@property(nonatomic, strong) ComNetworking *netWorking;

@end

@implementation ComRequest

- (instancetype)init {
    if (self = [super init]) {
        _requestDelegate = self;
    }
    return self;
}

- (NSString *)requestPath {
    return @"";
}

- (NSString *)urlPathString {
    if (!_urlPathString) {
        if ([self.requestDelegate respondsToSelector:@selector(requestPath)]) {
            _urlPathString = [self.requestDelegate requestPath];
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
    [self.netWorking setValue:param forKey:keyString];
}

- (void)sendRequestOnSuccess:(SuccessBlock)successBlock onFailed:(FailedBlock)failedBlock {
    __weak __typeof(self)weakSelf = self;
    [self.netWorking sendRequestOnSuccess:^(id data) {
        __strong __typeof(self)strongSelf = weakSelf;
        
        id buildData = nil;
        if ([strongSelf.responseDelegate respondsToSelector:@selector(buildResponse:)]) {
            buildData = [strongSelf.responseDelegate buildResponse:data];
        }
        
        if (successBlock) {
            successBlock(buildData);
        }
    } onFailed:^(NSError *error) {
        if (failedBlock) {
            failedBlock(error);
        }
    }];
}

- (void)cancel {
    [self.netWorking cancel];
}


@end
