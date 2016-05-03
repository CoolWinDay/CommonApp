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
//        _collectionView.cellConfigureBlock = ^(UICollectionViewCell *cell, BookModel *data, NSIndexPath *indexPath) {
//            cell.backgroundColor = [UIColor colorWithRed:((10 * indexPath.row) / 255.0) green:((20 * indexPath.row)/255.0) blue:((30 * indexPath.row)/255.0) alpha:1.0f];
//            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
//            label.textColor = [UIColor redColor];
//            label.text = [NSString stringWithFormat:@"%zd",indexPath.row];
//            
//            for (id subView in cell.contentView.subviews) {
//                [subView removeFromSuperview];
//            }
//            [cell.contentView addSubview:label];
//        };
        _collectionView.cellSelectBlock = ^(UICollectionView *tableView, NSIndexPath *indexPath) {
            
        };
    }
    return _collectionView;
}

//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = (collectionView.width)/2.0-5;
    CGFloat height = width + 50.0;
    
    return CGSizeMake(width, height);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsZero;
//    return UIEdgeInsetsMake(0, 5, 5, 5);
}

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    //临时改变个颜色，看好，只是临时改变的。如果要永久改变，可以先改数据源，然后在cellForItemAtIndexPath中控制。（和UITableView差不多吧！O(∩_∩)O~）
    cell.backgroundColor = [UIColor greenColor];
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
