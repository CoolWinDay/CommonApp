//
//  ComNetworking.h
//  CommonApp
//
//  Created by lipeng on 16/3/10.
//  Copyright © 2016年 common. All rights reserved.
//

#import "ComRequest.h"

typedef enum {
    RequestGet,
    RequestPost
} RequestType;

@interface ComNetworking : NSObject

@property(nonatomic, copy) NSString *urlBaseString;
@property(nonatomic, copy) NSString *urlPathString;
@property(nonatomic, strong) NSMutableDictionary *parameters;

- (instancetype)initWithBaseUrl:(NSString *)baseString path:(NSString *)pathString;
- (void)addDataParam:(NSObject *)param forKey:(NSString *)keyString;
- (void)addDataParamFromDictionary:(NSDictionary *)paramDic;
- (void)requestWithType:(RequestType)type onSuccess:(RequestSuccessBlock)successBlock onFailed:(RequestFailedBlock)failedBlock;
- (void)cancel;

@end
