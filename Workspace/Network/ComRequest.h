//
//  ComRequest.h
//  CommonApp
//
//  Created by lipeng on 16/3/8.
//  Copyright © 2016年 common. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ComRequest : NSObject

- (instancetype)initWithMethod:(NSString*)method;

- (void)addDataParam:(NSObject *)param forKey:(NSString *)keyString;
- (void)sendRequest;
- (void)cancel;

@end
