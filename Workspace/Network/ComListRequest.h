//
//  ComListRequest.h
//  CommonApp
//
//  Created by lipeng on 16/4/1.
//  Copyright © 2016年 common. All rights reserved.
//

#import "JsonRequest.h"

@interface ComListRequest : JsonRequest

/**
 *  当前页数
 */
@property (nonatomic, assign) NSUInteger                currentPage;
/**
 *  最终结果
 */
@property (nonatomic, strong) NSMutableArray*           listArray;
/**
 *  是否还有数据，只要有数据返回，就认为还有下一页
 */
@property (nonatomic, assign) BOOL                      moreData;

/**
 *  清空listArray，currentPage = 0
 */
- (void)reload;
/**
 *  每页多少条数据，默认20
 */
- (NSUInteger)pageSize;

@end
