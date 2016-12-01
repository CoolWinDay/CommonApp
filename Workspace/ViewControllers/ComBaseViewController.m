//
//  ComBaseViewController.m
//  CommonApp
//
//  Created by lipeng on 16/5/2.
//  Copyright © 2016年 common. All rights reserved.
//

#import "ComBaseViewController.h"

@interface ComBaseViewController ()

@property(nonatomic, copy) VoidBlock rightItemBlock;

@end

@implementation ComBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_BG_COMMON;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 49)];
    [backButton setTitle:@"  返回" forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"common_back"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"common_back"] forState:UIControlStateHighlighted];
    backButton.titleLabel.font = FONT_NORMAL;
    [backButton addTarget:self action:@selector(navigateBack) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backItem;
}

- (void)showRightBar:(NSString *)title action:(VoidBlock)block {
    _rightItemBlock = block;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClicked)];
    [rightItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:FONT_NORMAL, NSFontAttributeName, nil] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = rightItem;
}

#pragma mark - 自定义返回按钮
- (void)navigateBack {
    [AppCommon popViewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)rightItemClicked {
    if (_rightItemBlock) {
        _rightItemBlock();
    }
}

- (BOOL)isNeedLogin {
    return NO;
}

@end
