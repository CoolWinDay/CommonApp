//
//  ComPageRequest.m
//  CommonApp
//
//  Created by lipeng on 16/5/25.
//  Copyright © 2016年 common. All rights reserved.
//

#import "ComPageRequest.h"
#import "BaseModel.h"

@implementation ComPageRequest

- (id)init {
    self = [super init];
    if (self) {
        self.currentPage = 1;
    }
    return self;
}

- (NSUInteger)pageSize {
    return 20;
}

- (void)load {
    [self addDataParam:[NSNumber numberWithInteger:(self.currentPage-1)*[self pageSize]] forKey:@"start"];
    [self addDataParam:[NSNumber numberWithInteger:[self pageSize]] forKey:@"count"];
    
    [super load];
}

- (void)reload {
    self.currentPage = 1;
    [self load];
}

- (void)succeed:(id)model {
    if (_currentPage == 1) {
        [self.listArray removeAllObjects];
    }
    
    NSArray *array = nil;
    NSString *pageArrayKey = [self pageArrayKey];
    if (pageArrayKey.length) {
        id pageArray = [model valueForKey:pageArrayKey];
        if ([pageArray isKindOfClass:[NSArray class]]) {
            array = [pageArray copy];
        }
    }
//    if ([model respondsToSelector:@selector(buildPageArray)]) {
//        array = [model buildPageArray];
//    }
    self.moreData = NO;
    if ([array count] > 0) {
        self.moreData = [array count] >= [self pageSize] ? YES : NO;
        self.currentPage ++;
        [self.listArray addObjectsFromArray:array];
    }
    [super succeed:model];
}

- (NSString *)pageArrayKey {
    return nil;
}

- (NSMutableArray *)listArray {
    if (!_listArray) {
        _listArray = [NSMutableArray array];
    }
    return _listArray;
}

@end
