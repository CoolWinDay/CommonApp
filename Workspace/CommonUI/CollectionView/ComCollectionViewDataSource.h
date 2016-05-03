//
//  ComTableViewDataSource.h
//  CommonApp
//
//  Created by lipeng on 16/4/3.
//  Copyright © 2016年 common. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^CellConfigureBlock)(id cell, id data, NSIndexPath *indexPath);

@interface ComCollectionViewDataSource : NSObject <UICollectionViewDataSource>

@property(nonatomic, strong) NSArray *items;

- (instancetype)initWithItems:(NSArray *)items cellIdentifier:(NSString *)cellIdentifier cellConfigureBlock:(CellConfigureBlock)cellConfigureBlock;

- (instancetype)initWithCellIdentifier:(NSString *)cellIdentifier cellConfigureBlock:(CellConfigureBlock)cellConfigureBlock;

@end
