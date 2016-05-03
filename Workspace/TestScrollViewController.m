//
//  TestScrollViewController.m
//  CommonApp
//
//  Created by lipeng on 16/5/2.
//  Copyright © 2016年 common. All rights reserved.
//

#import "TestScrollViewController.h"
#import "ComScrollView.h"
#import "BookListModel.h"

@interface TestScrollViewController ()

@property(nonatomic, strong) ComScrollView* scrollView;

@end

@implementation TestScrollViewController

- (void)loadView {
    [super loadView];
    
    [self.view addSubview:self.scrollView];
    [self.scrollView autoPinEdgesToSuperviewEdges];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (ComScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [ComScrollView newAutoLayoutView];
        _scrollView.model = [[BookListModel alloc] init];
        _scrollView.loadSuccessBlock = ^(BookListModel *model) {
            
        };
    }
    return _scrollView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
