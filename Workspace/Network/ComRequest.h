//
//  ComRequest.h
//  CommonApp
//
//  Created by lipeng on 16/3/8.
//  Copyright © 2016年 common. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"

/*
 * 数据类型
 */
typedef enum {
    DATA_TYPE_JSON = 0,
    DATA_TYPE_XML
} DataType;

@class ComRequest;

//typedef void (^StartBlock)(TBSDKServer      *server);
//typedef void (^ReciveResponseHeadersBlock)(NSDictionary *responseHeaders);
typedef void (^SuccessBlock)(id data);
typedef void (^FailedBlock)(NSError *error);
//typedef void (^DidLoadCache)(TBSDKServer    *server, NSDictionary *responseHeaders, NSString *responseString);
//typedef NSArray* (^RequestCache)(TBSDKServer    *server, NSDictionary *responseHeaders, NSString *responseString);


@interface ComRequest : NSObject

#pragma mark - 回调
//@property (nonatomic, copy) StartBlock                                          onStartBlock;
//@property (nonatomic, copy) SuccessBlock                                        onSuccessBlock;
//@property (nonatomic, copy) FailedBlock                                         onFailedBlock;
//@property (nonatomic, copy) ReciveResponseHeadersBlock                          reciveResponseHeadersBlock;
//@property (nonatomic, copy) DidLoadCache                                        didLoadCache;
//@property (nonatomic, copy) RequestCache                                        requestCache;

#pragma mark -

@property(nonatomic, strong) id responseData;
@property(nonatomic, strong) NSDictionary *jsonObject;
@property(nonatomic, assign) DataType responseDataType;
@property(nonatomic, strong) UserModel *responseModel;
@property(nonatomic, strong) NSError *responseError;

- (instancetype)initWithMethod:(NSString*)method;
- (void)addDataParam:(NSObject *)param forKey:(NSString *)keyString;
- (void)sendRequestOnSuccess:(SuccessBlock)successBlock onFailed:(FailedBlock)failedBlock;
- (void)cancel;
- (id)buildResponse;
- (DataType)responseDataType;
- (Class)responseJsonModelClass;

@end
