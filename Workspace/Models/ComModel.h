//
//  ComModel.h
//  CommonApp
//
//  Created by lipeng on 16/3/9.
//  Copyright © 2016年 common. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^SuccessBlock)(id data);
typedef void (^FailedBlock)(NSError *error);

@interface ComModel : NSObject

@property(nonatomic, assign) NSInteger              status;
@property(nonatomic, copy)   NSString*              statusInfo;

@property(nonatomic, copy)   SuccessBlock           successBlock;
@property(nonatomic, copy)   FailedBlock            failedBlock;

- (void)load;
- (void)cancel;
- (void)loadOnSuccess:(SuccessBlock)successBlock onFailed:(FailedBlock)failedBlock;

- (void)succeed:(id)response;
- (void)failed:(NSError *)error;

@end
