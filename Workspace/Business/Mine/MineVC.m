//
//  MineVC.m
//  CommonApp
//
//  Created by lipeng on 16/8/29.
//  Copyright © 2016年 common. All rights reserved.
//

#import "MineVC.h"

@interface MineVC ()

@property(nonatomic, weak) IBOutlet UIButton *loginBtn;

- (IBAction)doLogin:(id)sender;

@end

@implementation MineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的";
}

- (IBAction)doLogin:(id)sender {
    [AppCommon pushWithVCClassName:@"RegisterViewController"];
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
