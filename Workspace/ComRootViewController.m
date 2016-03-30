//
//  ComRootViewController.m
//  CommonApp
//
//  Created by lipeng on 16/3/7.
//  Copyright © 2016年 common. All rights reserved.
//

#import "ComRootViewController.h"
#import "BookListRequest.h"
#import "BookListModel.h"
#import "BookRequest.h"
#import "UserModel.h"
#import "BookModel.h"

@interface ComRootViewController ()

@property(nonatomic, strong) BookRequest *request;
@property(nonatomic, strong) UserModel *userModel;
@property(nonatomic, strong) BookListRequest *booksRequest;

@end

@implementation ComRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    self.request = [[BookRequest alloc] init];
    
    __weak typeof(self)weakSelf = self;
    [_request sendRequestOnSuccess:^(BookModel *userModel) {
        
    } onFailed:^(NSError *error) {
        
    }];
    
    
    self.booksRequest = [[BookListRequest alloc] init];
    [_booksRequest getRequestOnSuccess:^(BookListModel *bookListModel) {
        
    } onFailed:^(NSError *error) {
        
    }];
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
