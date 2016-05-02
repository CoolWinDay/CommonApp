//
//  ComRootViewController.m
//  CommonApp
//
//  Created by lipeng on 16/3/7.
//  Copyright © 2016年 common. All rights reserved.
//

#import "ComRootViewController.h"
#import "ComTableView.h"

@interface ComRootViewController () {
    
}

@property(nonatomic, strong) ComTableView *tableView;
@property(nonatomic, strong) NSArray *dataArray;

@end

@implementation ComRootViewController

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

- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[@{@"title":@"TableView", @"vcName":@"TestTableViewController"},
                       @{@"title":@"ScrollView", @"vcName":@"TestTableViewController"}];
    }
    return _dataArray;
}

- (ComTableView *)tableView {
    if (!_tableView) {
        _tableView = [ComTableView newAutoLayoutView];
        _tableView.dataArray = self.dataArray;
        
        __weak typeof(self) weakSelf = self;
        
        _tableView.cellConfigureBlock = ^(UITableViewCell *cell, NSDictionary *item, NSIndexPath *indexPath) {
            cell.textLabel.text = item[@"title"];
            cell.textLabel.textColor = [UIColor redColor];
        };
        
        _tableView.cellHeightBlock = ^(UITableView *tableView, NSIndexPath *indexPath) {
            return 60.0;
        };
        
        _tableView.cellSelectBlock = ^(UITableView *tableView, NSIndexPath *indexPath) {
            if (weakSelf.dataArray.count > indexPath.row) {
                NSString *vcName = weakSelf.dataArray[indexPath.row][@"vcName"];
                id ctro = [NSClassFromString(vcName) new];
                [weakSelf.navigationController pushViewController:ctro animated:YES];
            }
        };
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
