//
//  BookListRequest.m
//  CommonApp
//
//  Created by lipeng on 16/3/30.
//  Copyright © 2016年 common. All rights reserved.
//

#import "BookListRequest.h"
#import "BookListModel.h"

@implementation BookListRequest

- (NSString *)requestPath {
    return [NSString stringWithFormat:@"%@%@", Book_Url, BookSearch_Path];
}

- (Class)modelClass {
    return [BookListModel class];
}

- (NSArray*)constructDataArray:(BookListModel *)requestData
{
    return requestData.books;
}

@end
