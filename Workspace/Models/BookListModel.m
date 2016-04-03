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

- (NSString *)requestPath {
    return [NSString stringWithFormat:@"%@%@", Book_Url, BookSearch_Path];
}

- (void)buildResponse:(id)responseData {
    if (responseData){
        NSError *error = nil;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
        if (!error) {
            DLog(@"%@", dic);
            [self yy_modelSetWithDictionary:dic];
        }
    }
}

- (NSArray*)constructDataArray
{
    return self.books;
}

@end
