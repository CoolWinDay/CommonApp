//
//  ComRequest.h
//  CommonApp
//
//  Created by lipeng on 16/3/8.
//  Copyright © 2016年 common. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"

@protocol ResponseDelegate <NSObject>

- (id)buildResponse:(id)responseData;

@end

@class ComRequest;

typedef void (^SuccessBlock)(id data);
typedef void (^FailedBlock)(NSError *error);
//typedef void (^StartBlock)(TBSDKServer      *server);
//typedef void (^ReciveResponseHeadersBlock)(NSDictionary *responseHeaders);
//typedef void (^DidLoadCache)(TBSDKServer    *server, NSDictionary *responseHeaders, NSString *responseString);
//typedef NSArray* (^RequestCache)(TBSDKServer    *server, NSDictionary *responseHeaders, NSString *responseString);

@interface ComRequest : NSObject

@property(nonatomic, strong) id<ResponseDelegate> responseDelegate;

- (instancetype)initWithMethod:(NSString*)method;
- (void)addDataParam:(NSObject *)param forKey:(NSString *)keyString;
- (void)sendRequestOnSuccess:(SuccessBlock)successBlock onFailed:(FailedBlock)failedBlock;
- (void)cancel;

@end
