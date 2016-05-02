//
//  TestTableViewController.m
//  CommonApp
//
//  Created by lipeng on 16/4/16.
//  Copyright © 2016年 common. All rights reserved.
//

#import "TestTableViewController.h"
#import "BookListModel.h"
#import "BookModel.h"
#import "BookTableViewCell.h"
#import "ComTableView.h"
#import "MBProgressHUD.h"

@interface TestTableViewController () <UITableViewDelegate> {
    BOOL _isUpdateConstraints;
}

@property(nonatomic, strong) ComTableView *tableView;
@property(nonatomic, strong) NSArray *dataArray;

@end

@implementation TestTableViewController

- (void)dealloc {
    
}

- (void)loadView {
    [super loadView];
    
    [self.view addSubview:self.tableView];
    [self.tableView autoPinEdgesToSuperviewEdges];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (ComTableView *)tableView {
    if (!_tableView) {
        _tableView = [ComTableView newAutoLayoutView];
        
        _tableView.listModel = [[BookListModel alloc] init];
        _tableView.tableViewCellClass = [BookTableViewCell class];
//        _tableView.cellConfigureBlock = ^(UITableViewCell *cell, BookModel *data, NSIndexPath *indexPath) {
//            cell.textLabel.text = data.title;
//        };
//        _tableView.cellSelectBlock = ^(UITableView *tableView, NSIndexPath *indexPath) {
//            
//        };
//        _tableView.isPaging = NO;
//        _tableView.isShowEmptyTip = NO;
//        _tableView.isRefresh = NO;
        
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
