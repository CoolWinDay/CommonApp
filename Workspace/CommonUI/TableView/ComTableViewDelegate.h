//
//  ComTableViewDelegate.h
//  CommonApp
//
//  Created by lipeng on 16/4/29.
//  Copyright © 2016年 common. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^CellSelectBlock)(UITableView *tableView, NSIndexPath *indexPath);
typedef CGFloat (^CellHeightBlock)(UITableView *tableView, NSIndexPath *indexPath);

@interface ComTableViewDelegate : NSObject <UITableViewDelegate>

@property(nonatomic, copy) CellHeightBlock cellHeightBlock;
@property(nonatomic, copy) CellSelectBlock cellSelectBlock;

@end
