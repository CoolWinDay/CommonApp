//
//  ComCollectionView.h
//  CommonApp
//
//  Created by lipeng on 16/5/2.
//  Copyright © 2016年 common. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ComCollectionViewDataSource.h"
#import "ComCollectionViewDelegate.h"
#import "ComPageRequest.h"

@interface ComCollectionView : UICollectionView

@property(nonatomic, strong) ComPageRequest*    pageRequest;
@property(nonatomic, strong) NSArray*           dataArray;
@property(nonatomic, strong) Class              listModelClass;
@property(nonatomic, strong) Class              cellClass;
@property(nonatomic, copy  ) CellConfigureBlock cellConfigureBlock;
@property(nonatomic, copy  ) CellSelectBlock    cellSelectBlock;
@property(nonatomic, assign) CGSize             cellSize;
@property(nonatomic, assign) UIEdgeInsets       cellInset;

@property(nonatomic, assign) BOOL           isPaging;
@property(nonatomic, assign) BOOL           isRefresh;
@property(nonatomic, assign) BOOL           isShowEmptyTip;

- (void)loadDataFromServer;
- (void)reLoadDataFromServer;


@end
