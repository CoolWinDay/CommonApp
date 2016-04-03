//
//  ComTableViewDataSource.h
//  CommonApp
//
//  Created by lipeng on 16/4/3.
//  Copyright © 2016年 common. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ConfigureCell)(UITableViewCell *cell, id data);

@interface ComTableViewDataSource : NSObject <UITableViewDataSource>

@property(nonatomic, strong) NSArray *items;

- (instancetype)initWithItems:(NSArray *)items cellIdentifier:(NSString *)cellIdentifier configureCellBlock:(ConfigureCell)configureCell;

@end
