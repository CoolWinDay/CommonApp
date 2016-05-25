//
//  BookListModel.m
//  CommonApp
//
//  Created by lipeng on 16/3/30.
//  Copyright © 2016年 common. All rights reserved.
//

#import "BookListModel.h"
#import "BookModel.h"
#import "BookRequest.h"

@implementation BookListModel

#pragma mark - build
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"books" : [BookModel class]};
}

#pragma mark - PageDelegate
- (NSArray *)buildPageArray {
    return self.books;
}

@end
