//
//  ComTableViewDelegate.h
//  CommonApp
//
//  Created by lipeng on 16/4/29.
//  Copyright © 2016年 common. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^CellSelectBlock)(UICollectionView *tableView, NSIndexPath *indexPath);

@interface ComCollectionViewDelegate : NSObject <UICollectionViewDelegate>

@property(nonatomic, copy) CellSelectBlock cellSelectBlock;

@end
