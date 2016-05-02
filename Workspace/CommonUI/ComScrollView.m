//
//  ComScrollView.m
//  CommonApp
//
//  Created by lipeng on 16/4/13.
//  Copyright © 2016年 common. All rights reserved.
//

#import "ComScrollView.h"
#import "MJRefreshNormalHeader.h"
#import "ComErrorViewManager.h"
#import "UIScrollView+MJRefresh.h"

@interface ComScrollView ()

@property(nonatomic, strong) MJRefreshStateHeader *comHeader;

@end

@implementation ComScrollView

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
    self.scrollEnabled = YES;
    self.model = [[ComModel alloc] init];
}

- (MJRefreshStateHeader *)comHeader {
    if (!_comHeader) {
        __weak typeof(self) weakSelf = self;
        _comHeader = [MJRefreshStateHeader headerWithRefreshingBlock:^{
            [ComErrorViewManager removeErrorViewFromView:self.superview];
            [weakSelf.model load];
        }];
        _comHeader.lastUpdatedTimeLabel.hidden = YES;
    }
    return _comHeader;
}

- (void)setModel:(ComModel *)model {
    if (_model == model) {
        return;
    }
    _model = model;
    
    self.isShowEmptyTip = YES;
    self.isRefresh = YES;
    
    __weak typeof(self) weakSelf = self;
    _model.successBlock = ^(id data) {
        [weakSelf loadSuccess];
    };
    
    _model.failedBlock = ^(NSError *error) {
        [weakSelf loadFail:error];
    };
    
    [self reLoadDataFromServer];
}

- (void)reLoadDataFromServer {
    [self.model load];
}

- (void)loadFail:(NSError *)error {
    [self.mj_header endRefreshing];
    if (self.isShowEmptyTip) {
        __weak typeof(self) weakSelf = self;
        [ComErrorViewManager showErrorViewInView:self.superview withError:error clickBlock:^{
            [weakSelf reLoadDataFromServer];
        }];
    }
}

- (void)loadSuccess {
    [ComErrorViewManager removeErrorViewFromView:self.superview];
    [self.mj_header endRefreshing];
    if (self.loadSuccessBlock) {
        self.loadSuccessBlock(self.model);
    }
}

- (void)setIsRefresh:(BOOL)isRefresh {
    _isRefresh = isRefresh;
    self.mj_header = _isRefresh ? self.comHeader : nil;
}

@end
