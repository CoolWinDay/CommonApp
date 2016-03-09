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
        self.responseDataType = DATA_TYPE_JSON;
    }
    return self;
}

//- (void)sendRequest
//{
//    [self addDataParam:@"data" forKey:[self yy_modelToJSONString]];
//}

// json
- (Class)responseJsonModelClass
{
    return [UserModel class];
}

// userself
- (id)buildResponse
{
    if (self.responseData){
        
    }
    return nil;
}

@end
