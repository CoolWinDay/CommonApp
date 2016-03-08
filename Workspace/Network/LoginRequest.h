//
//  LoginRequest.h
//  CommonApp
//
//  Created by lipeng on 16/3/8.
//  Copyright © 2016年 common. All rights reserved.
//

#import "ComRequest.h"

@interface LoginRequest : ComRequest

@property(nonatomic, copy) NSString *username;
@property(nonatomic, copy) NSString *password;
@property(nonatomic, copy) NSString *deviceToken;

@end
