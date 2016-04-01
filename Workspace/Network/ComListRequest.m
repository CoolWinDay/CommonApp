//
//  ComListRequest.m
//  CommonApp
//
//  Created by lipeng on 16/4/1.
//  Copyright © 2016年 common. All rights reserved.
//

#import "ComListRequest.h"
#import "ComListModel.h"

@implementation ComListRequest

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

- (void)reload {
    self.currentPage = 1;
    [self load];
}

- (NSDictionary*)dataParams {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    //    [dic setObject:@(self.currentPage) forKey:@"pageNum"];
    //    [dic setObject:@(2) forKey:@"from"];
    //    [dic setObject:@(self.status) forKey:@"status"];
    //    if (self.status == TDDWMChooseOrderStatusWait) {
    //        [dic setObject:@(1) forKey:@"pageSize"];
    //    }
    //    else {
    //        [dic setObject:@([self pageSize]) forKey:@"pageSize"];
    //    }
    //    if ([self.shopId length]>0) {
    //        [dic setObject:self.shopId forKey:@"shopId"];
    //    }
    //    if ([self.buyerPhone length]>0) {
    //        [dic setObject:self.buyerPhone forKey:@"buyerPhone"];
    //    }
    return dic;
}

- (void)succeed:(ComListModel *)response {
    if (_currentPage == 1) {
        self.listArray = [NSMutableArray array];
    }
    NSArray *array = [self constructDataArray:response];
    self.moreData = NO;
    if ([array count]>0) {
        self.moreData = [array count]>= [self pageSize] ? YES : NO;
        self.currentPage ++;
        [self.listArray addObjectsFromArray:array];
    }
    [super succeed:response];
}

- (NSArray*)constructDataArray:(ComListModel *)requestData
{
    return nil;
}

@end
