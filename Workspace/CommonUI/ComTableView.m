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
#import "ComListRequest.h"

@interface ComTableView() <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) ComListRequest* listRequest;

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
    
    self.dataSource = self;
    self.delegate = self;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 添加下拉/上滑刷新更多
    // 顶部下拉刷出更多
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        self.pageNum = 1;
//        [self getDoorToDoorServiceDataFromService];
        
        [weakSelf.listRequest reload];
//        [self.header endRefreshing];
    }];
    // 底部上拉刷出更多
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//        if (self.doorToDoorServiceArray.count == self.pageNum*pageSize) {
//            self.pageNum++;
//            [self getDoorToDoorServiceDataFromService];
//        }
        
        [weakSelf.listRequest load];
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
    [self.listRequest load];
}

//上拉
- (void)dragUp {
//    if (self.listModel.moreData) {
//        [self.listModel load];
//    }
//    else [self.tableView stopRefresh];
}

- (Class)listRequestClass {
    return nil;
}

- (Class)tableViewCellClass {
    return [ComTableViewCell class];
}

- (ComListRequest *)listRequest {
    Class requestClass = [self listRequestClass];
    if (!_listRequest && requestClass) {
        _listRequest = [requestClass new];
        __weak typeof(self) weakSelf = self;
        _listRequest.successBlock = ^(id data) {
            [weakSelf loadSuccess];
        };
        _listRequest.failedBlock = ^(NSError *error) {
            [weakSelf loadFail];
//            [TDDErrorViewManager showErrorViewInView:weakSelf.view withError:error];
        };
    }
    return _listRequest;
}

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
    [self reloadData];
    [self.header endRefreshing];
//    self.tableView.hasMoreData = self.listModel.moreData;
//    if ([self.listModel.listArray count] == 0) {
//        [TDDErrorViewManager showEmptyViewInView:self.view];
//    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.listRequest.listArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

//每一行的界面
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *indetify = @"Cell";
    //使用自定义的cell
    id cell = [tableView dequeueReusableCellWithIdentifier:indetify];
    if (!cell) {
        cell = [[[self tableViewCellClass] alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indetify];
    }
    
    ((ComTableViewCell*)cell).indexPath = indexPath;
    if (self.listRequest.listArray.count > indexPath.row) {
        ((ComTableViewCell*)cell).item = [self.listRequest.listArray objectAtIndex:indexPath.row];
    }
    
    return cell;
}

@end
