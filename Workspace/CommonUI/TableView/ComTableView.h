//
//  ComTableView.h
//  CommonApp
//
//  Created by lipeng on 16/3/30.
//  Copyright © 2016年 common. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ComListModel.h"
#import "ComTableViewDataSource.h"
#import "ComTableViewDelegate.h"

@interface ComTableView : UITableView

@property(nonatomic, strong) ComListModel*      listModel;
@property(nonatomic, strong) NSArray*           dataArray;
@property(nonatomic, strong) Class              listModelClass;
@property(nonatomic, strong) Class              tableViewCellClass;
@property(nonatomic, copy  ) CellConfigureBlock cellConfigureBlock;
@property(nonatomic, copy  ) CellHeightBlock    cellHeightBlock;
@property(nonatomic, copy  ) CellSelectBlock    cellSelectBlock;

@property(nonatomic, assign) BOOL           isPaging;
@property(nonatomic, assign) BOOL           isRefresh;
@property(nonatomic, assign) BOOL           isShowEmptyTip;
@property(nonatomic, assign) BOOL           isHeightCache;

- (void)loadDataFromServer;
- (void)reLoadDataFromServer;

@end
