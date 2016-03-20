//
//  LoginRequest.m
//  CommonApp
//
//  Created by lipeng on 16/3/8.
//  Copyright © 2016年 common. All rights reserved.
//

#import "LoginRequest.h"
#import "UserModel.h"

@implementation LoginRequest

- (NSString *)requestPath {
    return [NSString stringWithFormat:@"%@%@", Login_Url, Login_Path];
}

- (Class)modelClass {
    return [UserModel class];
}

@end
