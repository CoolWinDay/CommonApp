//
//  ComTableViewDataSource.h
//  CommonApp
//
//  Created by lipeng on 16/4/3.
//  Copyright © 2016年 common. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^CellConfigureBlock)(UITableViewCell *cell, id data, NSIndexPath *indexPath);

@interface ComTableViewDataSource : NSObject <UITableViewDataSource>

@property(nonatomic, strong) NSArray *items;

- (instancetype)initWithItems:(NSArray *)items cellIdentifier:(NSString *)cellIdentifier cellConfigureBlock:(CellConfigureBlock)cellConfigureBlock;

- (instancetype)initWithCellIdentifier:(NSString *)cellIdentifier cellConfigureBlock:(CellConfigureBlock)cellConfigureBlock;

@end
