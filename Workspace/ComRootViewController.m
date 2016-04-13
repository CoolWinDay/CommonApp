//
//  ComRootViewController.m
//  CommonApp
//
//  Created by lipeng on 16/3/7.
//  Copyright © 2016年 common. All rights reserved.
//

#import "ComRootViewController.h"
#import "BookListModel.h"
#import "BookModel.h"
#import "UserModel.h"
#import "BookModel.h"
#import "BookTableViewCell.h"
#import "ComTableView.h"
#import "ComScrollView.h"

@interface ComRootViewController ()

@property(nonatomic, strong) BookModel *bookModel;
@property(nonatomic, strong) UserModel *userModel;
@property(nonatomic, strong) BookListModel *bookListModel;

@end

@implementation ComRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    __weak typeof(self)weakSelf = self;
    
    ComScrollView *scrollView = [[ComScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:scrollView];
    scrollView.isShowEmptyTip = NO;
    scrollView.isRefresh = NO;
    scrollView.model = [[BookModel alloc] init];
    scrollView.loadSuccessBlock = ^(BookModel *model){
        
    };
    [scrollView reLoadDataFromServer];
    
    ComTableView *table = [[ComTableView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:table];
//    table.isPaging = NO;
//    table.isShowEmptyTip = NO;
//    table.isRefresh = YES;
    table.listModel = [[BookListModel alloc] init];
    table.tableViewCellClass = [BookTableViewCell class];
//    table.configureCellBlock = ^(UITableViewCell *cell, BookModel *item, NSIndexPath *indexPath) {
//        cell.textLabel.text = item.title;
//        cell.textLabel.textColor = [UIColor redColor];
//    };
    [table loadData];
    
    
    
    
//    self.bookModel = [[BookModel alloc] init];
//    [self.bookModel loadOnSuccess:^(BookModel *model) {
//        
//    } onFailed:^(NSError *error) {
//        
//    }];
//    
//    self.bookListModel = [[BookListModel alloc] init];
//    [self.bookListModel loadOnSuccess:^(id data) {
//        
//    } onFailed:^(NSError *error) {
//        
//    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
