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
    
    
    _tableDataSource = [[ComTableViewDataSource alloc] initWithItems:self.listModel.listArray cellIdentifier:CellReuseIdentifier configureCellBlock:^(UITableViewCell *cell, id item) {
        if ([cell isKindOfClass:[ComTableViewCell class]]) {
//            ((ComTableViewCell*)cell).indexPath = indexPath;
            ((ComTableViewCell*)cell).item = item;
        }
    }];
    
    self.dataSource = _tableDataSource;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 添加下拉/上滑刷新更多
    // 顶部下拉刷出更多
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        self.pageNum = 1;
//        [self getDoorToDoorServiceDataFromService];
        
        [weakSelf.listModel reload];
//        [self.header endRefreshing];
    }];
    // 底部上拉刷出更多
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//        if (self.doorToDoorServiceArray.count == self.pageNum*pageSize) {
//            self.pageNum++;
//            [self getDoorToDoorServiceDataFromService];
//        }
        
        [weakSelf.listModel load];
//        [self.footer endRefreshing];
    }];
//    header.lastUpdatedTimeLabel.hidden = YES;
    self.header = header;
    self.footer = footer;
}

//下拉
- (void)dragDown {
//    [TDDErrorViewManager removeErrorViewFromView:self.view];
//    self.tableView.hasMoreData = NO;
    [self.listModel load];
}

//上拉
- (void)dragUp {
//    if (self.listModel.moreData) {
//        [self.listModel load];
//    }
//    else [self.tableView stopRefresh];
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
//            [TDDErrorViewManager showErrorViewInView:weakSelf.view withError:error];
    };
}

//- (ComListModel *)listModel {
//    Class requestClass = [self listModelClass];
//    if (!_listModel && requestClass) {
//        _listModel = [requestClass new];
//        __weak typeof(self) weakSelf = self;
//        _listModel.successBlock = ^(id data) {
//            [weakSelf loadSuccess];
//        };
//        _listModel.failedBlock = ^(NSError *error) {
//            [weakSelf loadFail];
////            [TDDErrorViewManager showErrorViewInView:weakSelf.view withError:error];
//        };
//    }
//    return _listModel;
//}

- (void)autoLoad {
//    [self autoRefresh];
}

- (void)startUpLoad {
//    [self.listRequest load];
}

- (void)loadFail {
    [self.header endRefreshing];
    [self reloadData];
}

- (void)loadSuccess {
//    [TDDErrorViewManager removeErrorViewFromView:self.view];
    self.tableDataSource.items = self.listModel.listArray;
    [self reloadData];
    [self.header endRefreshing];
//    self.tableView.hasMoreData = self.listModel.moreData;
//    if ([self.listModel.listArray count] == 0) {
//        [TDDErrorViewManager showEmptyViewInView:self.view];
//    }
}



@end
