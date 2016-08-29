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
#import "BookModel.h"
#import "BookRequest.h"

@interface TestScrollViewController ()

@property(nonatomic, strong) ComScrollView* scrollView;
@property(nonatomic, strong) UILabel *labelView;
@property(nonatomic, strong) BookModel* bookModel;


@end

@implementation TestScrollViewController

- (void)loadView {
    [super loadView];
    
    [self.view addSubview:self.scrollView];
//    [self.scrollView autoPinEdgesToSuperviewEdges];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (ComScrollView *)scrollView {
    if (!_scrollView) {
//        _scrollView = [ComScrollView newAutoLayoutView];
        _scrollView = [[ComScrollView alloc] initWithFrame:self.view.bounds];
        _scrollView.request = [[BookRequest alloc] init];
        __weak typeof(self)weakSelf = self;
        _scrollView.loadSuccessBlock = ^(BookModel *model) {
            [weakSelf makeScrollView:model];
        };
    }
    return _scrollView;
}

- (void)makeScrollView:(BookModel *)model {
    [self.labelView removeFromSuperview];
    [self.scrollView addSubview:self.labelView];
//    [label autoPinEdgesToSuperviewEdges];
    self.labelView.text = [model yy_modelToJSONString];
    
//    [self.view setNeedsUpdateConstraints];
}

- (UILabel *)labelView {
    if (!_labelView) {
        _labelView = [[UILabel alloc] initWithFrame:self.scrollView.bounds];
        _labelView.numberOfLines = 0;
    }
    return _labelView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
