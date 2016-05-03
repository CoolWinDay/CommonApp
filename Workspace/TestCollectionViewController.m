//
//  TestCollectionViewController.m
//  CommonApp
//
//  Created by lipeng on 16/5/2.
//  Copyright © 2016年 common. All rights reserved.
//

#import "TestCollectionViewController.h"
#import "BookListModel.h"
#import "BookModel.h"
#import "ComCollectionView.h"
#import "BookCollectionViewCell.h"

@interface TestCollectionViewController ()

@property(nonatomic, strong) ComCollectionView *collectionView;
@property(nonatomic, strong) NSArray *dataArray;

@end

@implementation TestCollectionViewController

- (void)loadView {
    [super loadView];
    
    [self.view addSubview:self.collectionView];
    [self.collectionView autoPinEdgesToSuperviewEdges];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [ComCollectionView newAutoLayoutView];
        _collectionView.cellSize = CGSizeMake(100, 100);
        _collectionView.cellInset = UIEdgeInsetsMake(10, 10, 10, 10);
        _collectionView.backgroundColor = [UIColor whiteColor];
        
        _collectionView.listModel = [[BookListModel alloc] init];
        _collectionView.cellClass = [BookCollectionViewCell class];
//        _collectionView.dataArray = self.dataArray;
//        _collectionView.cellConfigureBlock = ^(UICollectionViewCell *cell, NSDictionary *data, NSIndexPath *indexPath) {
//            cell.backgroundColor = [UIColor purpleColor];
//            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 50)];
//            label.textColor = [UIColor whiteColor];
//            label.font = [UIFont systemFontOfSize:14];
//            label.numberOfLines = 0;
//            label.text = [NSString stringWithFormat:@"%@", data[@"vcName"]];
//            
//            [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
//            [cell.contentView addSubview:label];
//        };
//        _collectionView.isPaging = NO;
//        _collectionView.isRefresh = NO;
        _collectionView.cellSelectBlock = ^(UICollectionView *tableView, NSIndexPath *indexPath) {
            
        };
    }
    return _collectionView;
}

- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[@{@"title":@"TableView", @"vcName":@"TestTableViewController"},
                       @{@"title":@"CollectionView", @"vcName":@"TestCollectionViewController"},
                       @{@"title":@"CollectionView", @"vcName":@"TestCollectionViewController"},
                       @{@"title":@"CollectionView", @"vcName":@"TestCollectionViewController"},
                       @{@"title":@"ScrollView", @"vcName":@"TestScrollViewController"}];
    }
    return _dataArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
