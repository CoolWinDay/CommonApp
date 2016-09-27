//
//  BookRequest.m
//  CommonApp
//
//  Created by lipeng on 16/3/12.
//  Copyright © 2016年 common. All rights reserved.
//

#import "BookRequest.h"
#import "BookModel.h"
#import "BookListModel.h"

@implementation BookRequest

- (NSString *)requestUrl {
    return [NSString stringWithFormat:@"%@/%@", Book_Url, Book_Path];
}

- (Class)modelClass {
    return [BookModel class];
}

@end


@implementation BookListRequest

- (NSString *)requestUrl {
    return [NSString stringWithFormat:@"%@/%@", Book_Url, BookSearch_Path];
}

- (NSDictionary*)dataParams {
    return @{
             @"q"     : @"我的家乡"
//             @"q2" : @"我的家乡"
//             @"q" : @"+++++++++++"
             };
}

- (Class)modelClass {
    return [BookListModel class];
}

@end
