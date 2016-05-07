//
//  ComTableViewCell.h
//  CommonApp
//
//  Created by lipeng on 16/4/1.
//  Copyright © 2016年 common. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ComTableViewDataSource.h"

#define TableViewCellDefaultHeight 44.0

@interface ComTableViewCell : UITableViewCell

@property(nonatomic, assign) BOOL           isAutoHeight;
@property(nonatomic, strong) id             item;
@property(nonatomic, strong) NSIndexPath    *indexPath;
@property(nonatomic, copy  ) CellConfigureBlock cellConfigureBlock;

- (void)buildCellView;
- (void)setCellData:(id)item atIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)cellHeight:(id)item atIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)cellAutoHeight:(id)item atIndexPath:(NSIndexPath *)indexPath;

@end
