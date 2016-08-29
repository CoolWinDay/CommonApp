//
//  ComTabViewController.m
//  INongBao
//
//  Created by lipeng on 16/6/15.
//  Copyright © 2016年 common. All rights reserved.
//

#import "ComTabViewController.h"

#import "ComDemoViewController.h"
#import "HomeVC.h"
#import "MineVC.h"

@implementation ComTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBar.translucent = NO;
    // 创建页面
    [self initBarView];
}

#pragma mark - 创建页面
- (void)initBarView {
    if ([self.viewControllers count] > 0) {
        return;
    }
    
    self.viewControllers = @[[[HomeVC alloc] init], [[ComDemoViewController alloc] init], [[MineVC alloc] init]];
    
    // 标题
    NSArray *titleArray = @[@"首页", @"demo", @"我的"];
    // 图片
    NSArray *normalArray = @[@"tool_button_home_bor", @"tool_button_buy_bor", @"tool_button_user_bor"];
    NSArray *selectedArray = @[@"tool_button_home_sel", @"tool_button_buy_sel", @"tool_button_user_sel"];
    
    for (int i = 0; i < self.viewControllers.count; i++) {
        UITabBarItem *item = [self.tabBar.items objectAtIndex:i];
        item.image = [UIImage imageNamed:normalArray[i]];
        item.selectedImage = [[UIImage imageNamed:selectedArray[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        item.title = titleArray[i];
    }
    
    //改变颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:COLOR_TEXT_GRAY} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:COLOR_TEXT_THEME} forState:UIControlStateSelected];
    
    self.title = titleArray[0];
}

#pragma mark - 设置标题
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    self.title = item.title;
}

@end
