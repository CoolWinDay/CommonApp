//
//  UserModel.h
//  CommonApp
//
//  Created by lipeng on 16/3/9.
//  Copyright © 2016年 common. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@interface UserModel : BaseModel <NSCoding>

@property(nonatomic, copy) NSString *userId;
@property(nonatomic, copy) NSString *userName;

@end
