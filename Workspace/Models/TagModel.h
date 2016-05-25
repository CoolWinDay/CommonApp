//
//  TagModel.h
//  CommonApp
//
//  Created by lipeng on 16/3/12.
//  Copyright © 2016年 common. All rights reserved.
//

#import "BaseModel.h"

@interface TagModel : BaseModel

@property(nonatomic, assign) NSInteger count;
@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *title;

@end
