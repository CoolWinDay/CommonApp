//
//  TestLoadingViewController.m
//  CommonApp
//
//  Created by lipeng on 2016/11/10.
//  Copyright © 2016年 common. All rights reserved.
//

#import "TestLoadingViewController.h"
#import "ComLoadingView.h"

@interface TestLoadingViewController ()

@end

@implementation TestLoadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self showRightBar:@"设置" action:^{
        
    }];
}

- (IBAction)showLoading:(id)sender {
    [AppCommon showToast:@"hheheheh"];
//    [self.view endEditing:NO];
//    [AppCommon showLoading];
//    [self performSelector:@selector(hideLoading:) withObject:nil afterDelay:3];
}

- (IBAction)hideLoading:(id)sender {
    [AppCommon hideLoading];
}

@end
