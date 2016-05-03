//
//  ComCollectionView.m
//  CommonApp
//
//  Created by lipeng on 16/5/2.
//  Copyright © 2016年 common. All rights reserved.
//

#import "ComCollectionView.h"
#import "MJRefresh.h"
#import "UIScrollView+MJRefresh.h"
#import "ComErrorViewManager.h"
#import "ComCollectionViewCell.h"

#define CellReuseIdentifier @"CollectionCell"

@interface ComCollectionView()

@property(nonatomic, strong) ComCollectionViewDataSource    *comDataSource;
@property(nonatomic, strong) ComCollectionViewDelegate      *comDelegate;
@property(nonatomic, strong) MJRefreshNormalHeader          *comHeader;
@property(nonatomic, strong) MJRefreshAutoNormalFooter      *comFooter;
@property(nonatomic, strong) UICollectionViewFlowLayout     *comLayout;

@end

@implementation ComCollectionView

- (instancetype)init {
    if (self = [super initWithFrame:CGRectZero collectionViewLayout:self.comLayout]) {
        [self initView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame collectionViewLayout:self.comLayout]) {
        [self initView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        [self initView];
    }
    return self;
}

- (void)initView {
    self.dataSource = self.comDataSource;
    self.delegate = self.comDelegate;
    
    [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:CellReuseIdentifier];
}

- (UICollectionViewFlowLayout *)comLayout {
    if (!_comLayout) {
        _comLayout = [[UICollectionViewFlowLayout alloc] init];
        [_comLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        _comLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    }
    return _comLayout;
}

- (void)setCellSize:(CGSize)cellSize {
    _cellSize = cellSize;
    self.comLayout.itemSize = _cellSize;
}

- (void)setCellInset:(UIEdgeInsets)cellInset {
    _cellInset = cellInset;
    self.comLayout.sectionInset = _cellInset;
}

- (ComCollectionViewDataSource *)comDataSource {
    if (!_comDataSource) {
        __weak typeof(self) weakSelf = self;
        _comDataSource = [[ComCollectionViewDataSource alloc] initWithCellIdentifier:CellReuseIdentifier cellConfigureBlock:^(id cell, id item, NSIndexPath *indexPath) {
            if ([cell isKindOfClass:[ComCollectionViewCell class]]) {
                ComCollectionViewCell *comCell = (ComCollectionViewCell *)cell;
                comCell.indexPath = indexPath;
                comCell.item = item;
            }
            if (weakSelf.cellConfigureBlock) {
                weakSelf.cellConfigureBlock(cell, item, indexPath);
            }
        }];
    }
    return _comDataSource;
}

- (ComCollectionViewDelegate *)comDelegate {
    if (!_comDelegate) {
        __weak typeof(self) weakSelf = self;
        _comDelegate = [[ComCollectionViewDelegate alloc] init];
        _comDelegate.cellSelectBlock = ^(UICollectionView *tableView, NSIndexPath *indexPath) {
            if (weakSelf.cellSelectBlock) {
                weakSelf.cellSelectBlock(tableView, indexPath);
            }
        };
    }
    return _comDelegate;
}

- (MJRefreshNormalHeader *)comHeader {
    if (!_comHeader) {
        __weak typeof(self) weakSelf = self;
        _comHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [ComErrorViewManager removeErrorViewFromView:self.superview];
            self.listModel.moreData = NO;
            [weakSelf.listModel reload];
        }];
        
        _comHeader.lastUpdatedTimeLabel.hidden = YES;
    }
    return _comHeader;
}

- (MJRefreshAutoNormalFooter *)comFooter {
    if (!_comFooter) {
        __weak typeof(self) weakSelf = self;
        _comFooter = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [weakSelf.listModel load];
        }];
    }
    return _comFooter;
}

- (void)setCellClass:(Class)cellClass {
    _cellClass = cellClass;
    [self registerClass:_cellClass forCellWithReuseIdentifier:CellReuseIdentifier];
}

- (void)setListModel:(ComListModel *)listModel {
    if (_listModel == listModel) {
        return;
    }
    _listModel = listModel;
    self.comDataSource.items = _listModel.listArray;
    self.isPaging = YES;
    self.isRefresh = YES;
    self.isShowEmptyTip = YES;
    
    __weak typeof(self) weakSelf = self;
    _listModel.successBlock = ^(id data) {
        [weakSelf loadSuccess];
    };
    _listModel.failedBlock = ^(NSError *error) {
        [weakSelf loadFail:error];
    };
    
    [self reLoadDataFromServer];
}

- (void)setDataArray:(NSArray *)dataArray {
    if (_dataArray == dataArray) {
        return;
    }
    _dataArray = dataArray;
    self.comDataSource.items = _dataArray;
    self.isPaging = NO;
    self.isRefresh = NO;
    self.isShowEmptyTip = NO;
}

- (void)reLoadDataFromServer {
    [self.listModel reload];
}

- (void)loadDataFromServer {
    [self.listModel load];
}

- (void)loadFail:(NSError *)error {
    [self.mj_header endRefreshing];
    [self.mj_footer endRefreshing];
    [self reloadData];
    
    if (self.isShowEmptyTip) {
        __weak typeof(self) weakSelf = self;
        [ComErrorViewManager showErrorViewInView:self.superview withError:error clickBlock:^{
            [weakSelf reLoadDataFromServer];
        }];
    }
}

- (void)loadSuccess {
    [ComErrorViewManager removeErrorViewFromView:self.superview];
    
    [self.mj_header endRefreshing];
    [self.mj_footer endRefreshing];
    if (!self.listModel.moreData) {
        [self.mj_footer endRefreshingWithNoMoreData];
    }
    [self reloadData];
    if ([self.listModel.listArray count] == 0) {
        if (self.isShowEmptyTip) {
            __weak typeof(self) weakSelf = self;
            [ComErrorViewManager showEmptyViewInView:self.superview clickBlock:^{
                [weakSelf reLoadDataFromServer];
            }];
        }
    }
}

- (void)setIsPaging:(BOOL)isPaging {
    _isPaging = isPaging;
    self.mj_footer = _isPaging ? self.comFooter : nil;
}

- (void)setIsRefresh:(BOOL)isRefresh {
    _isRefresh = isRefresh;
    self.mj_header = _isRefresh ? self.comHeader : nil;
}

@end
