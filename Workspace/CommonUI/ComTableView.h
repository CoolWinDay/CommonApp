//
//  ComTableView.h
//  CommonApp
//
//  Created by lipeng on 16/3/30.
//  Copyright © 2016年 common. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ComListModel.h"

@interface ComTableView : UITableView

@property (nonatomic, strong) ComListModel* listModel;
@property (nonatomic, strong) Class tableViewCellClass;

@end
