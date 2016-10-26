//
//  ComDemoViewController.m
//  CommonApp
//
//  Created by lipeng on 16/5/4.
//  Copyright © 2016年 common. All rights reserved.
//

#import "ComDemoViewController.h"
#import "ComTableView.h"
#import "UIAlertView+Blocks.h"
#import "RIButtonItem.h"
#import "BookRequest.h"
#import "BookModel.h"
#import "BookListModel.h"

@interface ComDemoViewController ()

@property(nonatomic, strong) ComTableView *tableView;
@property(nonatomic, strong) NSArray *dataArray;

@property(nonatomic, strong) BookRequest *request;
@property(nonatomic, strong) BookListRequest *listRequest;

@end

@implementation ComDemoViewController

- (void)dealloc {
    
}

- (void)loadView {
    [super loadView];
    
    [self.view addSubview:self.tableView];
    [self.tableView autoPinEdgesToSuperviewEdges];
    
//    [[[UIAlertView alloc] initWithTitle:@"aaaa" message:@"bbb" cancelButtonItem:[RIButtonItem itemWithLabel:@"ccc"] otherButtonItems:[RIButtonItem itemWithLabel:@"aaa" action:^{
//        
//    }], nil] show];
    
//    [NSArray arrayWithObjects:[@"sss"] count:0];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.request = [[BookRequest alloc] init];
    [_request requestSuccess:^(id data) {
        
    } failed:^(NSError *error) {
        
    }];
    
//    self.listRequest = [[BookListRequest alloc] init];
//    [self.listRequest requestSuccess:^(id data) {
//        
//    } failed:^(NSError *error) {
//        
//    }];
}

- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[@{@"title":@"TableView", @"vcName":@"TestTableViewController"},
                       @{@"title":@"CollectionView", @"vcName":@"TestCollectionViewController"},
                       @{@"title":@"ScrollView", @"vcName":@"TestScrollViewController"},
                       @{@"title":@"AlertView", @"vcName":@"TestAlertViewController"}];
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
                [AppCommon pushWithVCClassName:vcName];
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
