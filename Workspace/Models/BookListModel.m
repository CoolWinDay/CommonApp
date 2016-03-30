//
//  BookListModel.m
//  CommonApp
//
//  Created by lipeng on 16/3/30.
//  Copyright © 2016年 common. All rights reserved.
//

#import "BookListModel.h"
#import "BookModel.h"

@implementation BookListModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"books" : [BookModel class]};
}

@end
