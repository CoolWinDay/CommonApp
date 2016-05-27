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

typedef void (^RequestSuccessBlock)(id data);
typedef void (^RequestFailedBlock)(NSError *error);
typedef void (^RequestCompletionBlock)();

@interface ComRequest : NSObject

@property(nonatomic, copy) NSString *urlPathString;

@property(nonatomic, copy) RequestSuccessBlock successBlock;
@property(nonatomic, copy) RequestFailedBlock failedBlock;
@property(nonatomic, copy) RequestCompletionBlock completionBlock;

- (void)addDataParam:(NSObject *)param forKey:(NSString *)keyString;
- (void)addDataParamFromDictionary:(NSDictionary *)paramDic;
- (NSDictionary *)getParameters;
- (void)requestSuccess:(RequestSuccessBlock)successBlock failed:(RequestFailedBlock)failedBlock;
- (void)load;
- (void)cancel;
- (RequestType)requestType;
- (ResponseType)responseType;

- (void)succeed:(id)response;
- (void)failed:(NSError *)error;

@end
