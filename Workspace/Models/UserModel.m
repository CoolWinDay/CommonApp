//
//  UserModel.m
//  CommonApp
//
//  Created by lipeng on 16/3/9.
//  Copyright © 2016年 common. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_userId forKey:@"userId"];
    [aCoder encodeObject:_userName forKey:@"userName"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        _userId = [aDecoder decodeObjectForKey:@"userId"];
        _userName = [aDecoder decodeObjectForKey:@"userName"];
    }
    return self;
}

@end
