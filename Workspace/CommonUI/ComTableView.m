//
//  ComTableView.m
//  CommonApp
//
//  Created by lipeng on 16/3/30.
//  Copyright © 2016年 common. All rights reserved.
//

#import "ComTableView.h"
#import "MJRefresh.h"

@implementation ComTableView

//- (void)initView {
//    // 添加下拉/上滑刷新更多
//    // 顶部下拉刷出更多
//    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        self.pageNum = 1;
//        [self getDoorToDoorServiceDataFromService];
//    }];
//    // 底部上拉刷出更多
//    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//        if (self.doorToDoorServiceArray.count == self.pageNum*pageSize) {
//            self.pageNum++;
//            [self getDoorToDoorServiceDataFromService];
//        }
//    }];
//    header.lastUpdatedTimeLabel.hidden = YES;
//    self.header = header;
//    self.footer = footer;
//}

@end
