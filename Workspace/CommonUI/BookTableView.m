//
//  BookTableView.m
//  CommonApp
//
//  Created by lipeng on 16/4/1.
//  Copyright © 2016年 common. All rights reserved.
//

#import "BookTableView.h"
#import "BookListRequest.h"
#import "BookTableViewCell.h"

@implementation BookTableView

- (Class)listRequestClass {
    return [BookListRequest class];
}

- (Class)tableViewCellClass {
    return [BookTableViewCell class];
}

@end
