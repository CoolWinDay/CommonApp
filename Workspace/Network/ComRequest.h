//
//  ComRequest.h
//  CommonApp
//
//  Created by lipeng on 16/3/8.
//  Copyright © 2016年 common. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    RequestGet,
    RequestPost
} RequestType;

typedef enum {
    ResponseJson,
    ResponseXml,
    ResponseNone
} ResponseType;

@class ComRequest;

typedef void (^SuccessBlock)(id data);
typedef void (^FailedBlock)(NSError *error);

@interface ComRequest : NSObject

@property(nonatomic, copy) NSString *urlPathString;

@property(nonatomic, copy) SuccessBlock successBlock;
@property(nonatomic, copy) FailedBlock failedBlock;

- (void)addDataParam:(NSObject *)param forKey:(NSString *)keyString;
- (void)addDataParamFromDictionary:(NSDictionary *)paramDic;
- (NSDictionary *)getParameters;
- (void)requestSuccess:(SuccessBlock)successBlock failed:(FailedBlock)failedBlock;
- (void)load;
- (void)cancel;
- (RequestType)requestType;
- (ResponseType)responseType;

- (void)succeed:(id)response;
- (void)failed:(NSError *)error;

@end
