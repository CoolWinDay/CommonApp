//
//  ComRequest.m
//  CommonApp
//
//  Created by lipeng on 16/3/8.
//  Copyright © 2016年 common. All rights reserved.
//

#import "ComRequest.h"
#import "ComNetworking.h"
#import "UserModel.h"

@interface ComRequest()

@property(nonatomic, strong) ComNetworking *netWorking;
@property(nonatomic, copy) NSString *urlString;

@end

@implementation ComRequest

- (instancetype)initWithMethod:(NSString*)method
{
    if (self = [super init]) {
        _urlString = [NSString stringWithFormat:@"%@%@", BaseUrl, method];
        _netWorking = [[ComNetworking alloc] initWithUrl:_urlString];
    }
    return self;
}

- (void)addDataParam:(NSObject *)param forKey:(NSString *)keyString
{
    [_netWorking setValue:param forKey:keyString];
}

- (void)sendRequestOnSuccess:(SuccessBlock)successBlock onFailed:(FailedBlock)failedBlock
{
//    __weak __typeof(self)weakSelf = self;
    [_netWorking sendRequestOnSuccess:^(id data) {
//        __strong __typeof(self)strongSelf = weakSelf;
        
        id buildData = nil;
        if ([self.responseDelegate respondsToSelector:@selector(buildResponse:)]) {
            buildData = [self.responseDelegate buildResponse:data];
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

- (void)cancel
{
    [_netWorking cancel];
}


@end
