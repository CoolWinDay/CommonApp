//
//  ComTableViewDataSource.m
//  CommonApp
//
//  Created by lipeng on 16/4/3.
//  Copyright © 2016年 common. All rights reserved.
//

#import "ComCollectionViewDataSource.h"

@interface ComCollectionViewDataSource()

@property(nonatomic, copy) NSString *cellIdentifier;
@property(nonatomic, strong) CellConfigureBlock cellConfigureBlock;

@end

@implementation ComCollectionViewDataSource

- (instancetype)initWithItems:(NSArray *)items cellIdentifier:(NSString *)cellIdentifier cellConfigureBlock:(CellConfigureBlock)cellConfigureBlock
{
    self = [super init];
    if (self) {
        _items = items;
        _cellIdentifier = cellIdentifier;
        _cellConfigureBlock = cellConfigureBlock;
    }
    return self;
}

- (instancetype)initWithCellIdentifier:(NSString *)cellIdentifier cellConfigureBlock:(CellConfigureBlock)cellConfigureBlock
{
    self = [super init];
    if (self) {
        _cellIdentifier = cellIdentifier;
        _cellConfigureBlock = cellConfigureBlock;
    }
    return self;
}

- (id)itemAtIndexPath:(NSIndexPath*)indexPath {
    return _items[indexPath.row];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_items count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    id cell = [collectionView dequeueReusableCellWithReuseIdentifier:_cellIdentifier forIndexPath:indexPath];
    if (_cellConfigureBlock) {
        id item = [self itemAtIndexPath:indexPath];
        _cellConfigureBlock(cell, item, indexPath);
    }
    
    return cell;
}

- (void)setItems:(NSArray *)items
{
    _items = items;
}

@end
