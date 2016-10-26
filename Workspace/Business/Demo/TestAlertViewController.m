//
//  TestAlertViewController.m
//  CommonApp
//
//  Created by lipeng on 16/10/8.
//  Copyright © 2016年 common. All rights reserved.
//

#import "TestAlertViewController.h"
#import "ComTableView.h"
#import "UIAlertView+Block.h"

@interface TestAlertViewController () <UIAlertViewDelegate>

@property(nonatomic, weak) IBOutlet UIButton *btn1;

@end

@implementation TestAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.btn1 handleClickWithBlock:^(UIButton *btn) {
        [UIAlertView alertWithMessage:@"hi" okBlock:^{
            
        }];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
