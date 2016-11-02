//
//  UserHelper.h
//  INongBao
//
//  Created by lipeng on 16/6/21.
//  Copyright © 2016年 common. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"

@interface UserManager : NSObject

+ (instancetype)sharedInstance;
+ (void)userLogin:(UserModel *)userModel;
+ (void)userLogout;
+ (BOOL)isLogedin;

@property(nonatomic, strong) UserModel *userModel;

@end
