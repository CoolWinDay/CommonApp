//
//  ComTableView.m
//  CommonApp
//
//  Created by lipeng on 16/3/30.
//  Copyright © 2016年 common. All rights reserved.
//

#import "ComTableView.h"
#import "MJRefresh.h"
#import "ComTableViewCell.h"
#import "ComTableViewDataSource.h"
#import "ComErrorViewManager.h"

#define CellReuseIdentifier @"Cell"

@interface ComTableView()

@property(nonatomic, strong) ComTableViewDataSource *tableDataSource;

@end

@implementation ComTableView

- (instancetype)init {
    if (self = [super init]) {
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
    __weak typeof(self) weakSelf = self;
    
    _tableDataSource = [[ComTableViewDataSource alloc] initWithItems:self.listModel.listArray cellIdentifier:CellReuseIdentifier configureCellBlock:^(UITableViewCell *cell, id item, NSIndexPath *indexPath) {
        if ([cell isKindOfClass:[ComTableViewCell class]]) {
            ComTableViewCell *comCell = (ComTableViewCell *)cell;
            comCell.indexPath = indexPath;
            comCell.item = item;
        }
        
        if (self.configureCellBlock) {
            self.configureCellBlock(cell, item, indexPath);
        }
    }];
    
    self.dataSource = _tableDataSource;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 添加下拉/上滑刷新更多
    // 顶部下拉刷出更多
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [ComErrorViewManager removeErrorViewFromView:self.superview];
        self.listModel.moreData = NO;
        [weakSelf.listModel reload];
    }];
    // 底部上拉刷出更多
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf.listModel load];
    }];
    
    header.lastUpdatedTimeLabel.hidden = YES;
    self.header = header;
    self.footer = footer;
}

- (void)setTableViewCellClass:(Class)tableViewCellClass {
    _tableViewCellClass = tableViewCellClass;
    [self registerClass:_tableViewCellClass forCellReuseIdentifier:CellReuseIdentifier];
}

- (void)setListModel:(ComListModel *)listModel {
    _listModel = listModel;
    
    __weak typeof(self) weakSelf = self;
    _listModel.successBlock = ^(id data) {
        [weakSelf loadSuccess];
    };
    
    _listModel.failedBlock = ^(NSError *error) {
        [weakSelf loadFail];
        [ComErrorViewManager showErrorViewInView:weakSelf.superview withError:error];
    };
}

- (void)reLoadData {
    [self.listModel reload];
}

- (void)loadData {
    [self.listModel load];
}

- (void)loadFail {
    [self.header endRefreshing];
    [self.footer endRefreshing];
    [self reloadData];
}

- (void)loadSuccess {
    [ComErrorViewManager removeErrorViewFromView:self.superview];
    self.tableDataSource.items = self.listModel.listArray;
    [self.header endRefreshing];
    [self.footer endRefreshing];
    if (!self.listModel.moreData) {
        [self.footer noticeNoMoreData];
    }
    [self reloadData];
    if ([self.listModel.listArray count] == 0) {
        [ComErrorViewManager showEmptyViewInView:self.superview];
    }
}



@end
