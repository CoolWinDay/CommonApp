//
//  ComRootViewController.m
//  CommonApp
//
//  Created by lipeng on 16/3/7.
//  Copyright © 2016年 common. All rights reserved.
//

#import "ComRootViewController.h"
#import "LoginRequest.h"

@interface ComRootViewController ()

@end

@implementation ComRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    LoginRequest *request = [[LoginRequest alloc] init];
    [request sendRequest];
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
