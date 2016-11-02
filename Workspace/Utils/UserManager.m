//
//  UserHelper.m
//  INongBao
//
//  Created by lipeng on 16/6/21.
//  Copyright © 2016年 common. All rights reserved.
//

#import "UserManager.h"

#define UDK_USER_MODEL @"UDK_USER_MODEL"
@implementation UserManager

+ (instancetype)sharedInstance {
    static UserManager *sharedInstance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    if (self = [super init]) {
        _userModel = [[UserModel alloc] init];
    }
    return self;
}

+ (void)userLogin:(UserModel *)userModel {
    [UserManager sharedInstance].userModel = userModel;
    [self saveLocalUser:userModel];
}

+ (void)userLogout {
    [UserManager sharedInstance].userModel = nil;
    [self removeLocalUser];
}

+ (void)saveLocalUser:(UserModel *)userModel {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:[UserManager sharedInstance].userModel];
    [userDefaults setObject:data forKey:UDK_USER_MODEL];
    [userDefaults synchronize];
}

+ (void)removeLocalUser {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:UDK_USER_MODEL];
    [userDefaults synchronize];
}

+ (void)initWithLocalUser {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    UserModel *user = [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:UDK_USER_MODEL]];
    [UserManager sharedInstance].userModel = user;
    
}

+ (BOOL)isLogedin {
    return [UserManager sharedInstance].userModel;
}

@end
