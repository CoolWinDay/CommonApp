//
//  ComTableView.m
//  CommonApp
//
//  Created by lipeng on 16/3/30.
//  Copyright © 2016年 common. All rights reserved.
//

#import "ComTableView.h"
#import "MJRefresh.h"
#import "UIScrollView+MJRefresh.h"
#import "ComTableViewCell.h"
#import "ComErrorViewManager.h"
#import "MBProgressHUD.h"

#define CellReuseIdentifier @"Cell"

@interface ComTableView()

@property(nonatomic, strong) ComTableViewDataSource *tableDataSource;
@property(nonatomic, strong) ComTableViewDelegate *tableDelegate;
@property(nonatomic, strong) MJRefreshNormalHeader *comHeader;
@property(nonatomic, strong) MJRefreshAutoNormalFooter *comFooter;

@property(nonatomic, strong) ComTableViewCell *cell4Height;      //只创建一个cell用作测量高度
@property(nonatomic, strong) NSMutableDictionary *cellHeightCache;

@end

@implementation ComTableView

- (instancetype)init {
    if (self = [super init]) {
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
    if (self = [super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}

- (void)initView {
    self.dataSource = self.tableDataSource;
    self.delegate = self.tableDelegate;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self registerClass:[UITableViewCell class] forCellReuseIdentifier:CellReuseIdentifier];
    
    // ios8
//    self.rowHeight = UITableViewAutomaticDimension;
//    self.estimatedRowHeight = 44.0; // 设置为一个接近“平均”行高的值
}

- (ComTableViewDataSource *)tableDataSource {
    if (!_tableDataSource) {
        __weak typeof(self) weakSelf = self;
        _tableDataSource = [[ComTableViewDataSource alloc] initWithCellIdentifier:CellReuseIdentifier cellConfigureBlock:^(UITableViewCell *cell, id item, NSIndexPath *indexPath) {
            if ([cell isKindOfClass:[ComTableViewCell class]]) {
                ComTableViewCell *comCell = (ComTableViewCell *)cell;
                comCell.item = item;
                comCell.indexPath = indexPath;
                [comCell setCellData:item atIndexPath:indexPath];
            }
            if (weakSelf.cellConfigureBlock) {
                weakSelf.cellConfigureBlock(cell, item, indexPath);
            }
        }];
    }
    return _tableDataSource;
}

- (ComTableViewDelegate *)tableDelegate {
    if (!_tableDelegate) {
        __weak typeof(self) weakSelf = self;
        _tableDelegate = [[ComTableViewDelegate alloc] init];
        _tableDelegate.cellHeightBlock = ^(UITableView *tableView, NSIndexPath *indexPath) {
            CGFloat cellHeight = TableViewCellDefaultHeight;
            if (weakSelf.cellHeightBlock) {
                cellHeight = weakSelf.cellHeightBlock(tableView, indexPath);
            }
            else {
                if ([weakSelf.cell4Height isKindOfClass:[ComTableViewCell class]]) {
                    cellHeight = [weakSelf.cell4Height cellHeight:weakSelf.listModel.listArray[indexPath.row] atIndexPath:indexPath];
                }
            }
            
//            // 缓存cell
//            [weakSelf.cellHeightCache setObject:@(cellHeight) forKey:@(indexPath.row)];
            return cellHeight;
        };
        _tableDelegate.cellSelectBlock = ^(UITableView *tableView, NSIndexPath *indexPath) {
            if (weakSelf.cellSelectBlock) {
                weakSelf.cellSelectBlock(tableView, indexPath);
            }
        };
    }
    return _tableDelegate;
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

- (void)setTableViewCellClass:(Class)tableViewCellClass {
    _tableViewCellClass = tableViewCellClass;
    [self registerClass:_tableViewCellClass forCellReuseIdentifier:CellReuseIdentifier];
    
    self.cell4Height = [self dequeueReusableCellWithIdentifier:CellReuseIdentifier];
}

- (void)setListModel:(ComListModel *)listModel {
    if (_listModel == listModel) {
        return;
    }
    _listModel = listModel;
    self.tableDataSource.items = _listModel.listArray;
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
    self.tableDataSource.items = _dataArray;
    self.isPaging = NO;
    self.isRefresh = NO;
    self.isShowEmptyTip = NO;
}

- (void)setCellConfigureBlock:(CellConfigureBlock)cellConfigureBlock
{
    if (_cellConfigureBlock == cellConfigureBlock) {
        return;
    }
    _cellConfigureBlock = cellConfigureBlock;
    self.cell4Height.cellConfigureBlock = _cellConfigureBlock;
}

- (NSMutableDictionary *)cellHeightCache {
    if (!_cellHeightCache) {
        _cellHeightCache = [NSMutableDictionary dictionary];
    }
    return _cellHeightCache;
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
