//
//  LoginRequest.m
//  CommonApp
//
//  Created by lipeng on 16/3/8.
//  Copyright © 2016年 common. All rights reserved.
//

#import "LoginRequest.h"
#import "ComJsonResponseAdapter.h"

@implementation LoginRequest

- (instancetype)init
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@", Login_Url, Login_Path];
    if (self = [super initWithMethod:urlString]) {
        self.responseDelegate = [[ComJsonResponseAdapter alloc] initWithModelClass:[UserModel class]];
    }
    return self;
}

//- (void)sendRequest
//{
//    [self addDataParam:@"data" forKey:[self yy_modelToJSONString]];
//}

@end
