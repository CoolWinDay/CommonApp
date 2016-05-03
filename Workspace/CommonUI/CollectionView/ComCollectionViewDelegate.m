//
//  ComTableViewDelegate.m
//  CommonApp
//
//  Created by lipeng on 16/4/29.
//  Copyright © 2016年 common. All rights reserved.
//

#import "ComCollectionViewDelegate.h"
#import "ComTableViewCell.h"

@interface ComCollectionViewDelegate()

@property(nonatomic, copy) NSString *cellIdentifier;

@end

@implementation ComCollectionViewDelegate

- (instancetype)initWithCellIdentifier:(NSString *)cellIdentifier {
    self = [super init];
    if (self) {
        _cellIdentifier = cellIdentifier;
    }
    return self;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_cellSelectBlock) {
        _cellSelectBlock(collectionView, indexPath);
    }
}

@end
