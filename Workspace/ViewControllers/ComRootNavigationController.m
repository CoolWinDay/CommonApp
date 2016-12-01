//
//  ComRootNavigationController.h.m
//  CommonApp
//
//  Created by lipeng on 16/3/7.
//  Copyright © 2016年 common. All rights reserved.
//

#import "ComRootNavigationController.h"

@interface ComRootNavigationController ()

@end

@implementation ComRootNavigationController

- (void)dealloc {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBar.barTintColor = COLOR_BG_THEME;
    self.navigationBar.translucent = NO;
    
    // 设置导航默认标题的颜色及字体大小
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor],
                                               NSFontAttributeName : [UIFont systemFontOfSize:17]};
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
}

#pragma mark -- 改变状态栏文字颜色为白色
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
