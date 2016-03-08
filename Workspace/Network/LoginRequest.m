//
//  LoginRequest.m
//  CommonApp
//
//  Created by lipeng on 16/3/8.
//  Copyright © 2016年 common. All rights reserved.
//

#import "LoginRequest.h"

@implementation LoginRequest

- (instancetype)init
{
    if (self = [super initWithMethod:[NSString stringWithFormat:@"%@%@", Login_Url, Login_Path]]) {
        
    }
    return self;
}

- (void)sendRequest
{
    _username = @"105100050817";
    _password = @"123456";
    _deviceToken = @"";
    
    [self addDataParam:@"data" forKey:[self yy_modelToJSONString]];
    
//    [self addDataParam:@"105100050817" forKey:@"username"];
//    [self addDataParam:@"123456" forKey:@"password"];
//    [self addDataParam:@"" forKey:@"deviceToken"];
    [super sendRequest];
}

@end
