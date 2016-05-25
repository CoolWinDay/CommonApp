//
//  BookRequest.h
//  CommonApp
//
//  Created by lipeng on 16/3/12.
//  Copyright © 2016年 common. All rights reserved.
//

#import "ComRequest.h"
#import "ComPageRequest.h"

@interface BookRequest : ComRequest

@end

@interface BookListRequest : ComPageRequest

@property(nonatomic, assign) NSInteger start;
@property(nonatomic, assign) NSInteger count;
@property(nonatomic, copy)   NSString *q;

@end
