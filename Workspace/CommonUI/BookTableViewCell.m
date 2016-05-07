//
//  BookTableViewCell.m
//  CommonApp
//
//  Created by lipeng on 16/4/1.
//  Copyright © 2016年 common. All rights reserved.
//

#import "BookTableViewCell.h"
#import "BookModel.h"

@interface BookTableViewCell ()


@end

@implementation BookTableViewCell

//- (void)buildCellView {
//    [self.contentView addSubview:self.titleLabel];
//    [self.titleLabel autoPinEdgesToSuperviewEdges];
//    self.titleLabel.preferredMaxLayoutWidth = self.contentView.width;
//}

//- (void)setCellData:(BookModel *)item atIndexPath:(NSIndexPath *)indexPath
//{
//    self.titleLabel.text = item.title;
//}

- (CGFloat)cellHeight:(id)item atIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0  || indexPath.row == 1) {
        return [super cellAutoHeight:item atIndexPath:indexPath];
    }
    return 180;
}

- (BOOL)isAutoHeight {
    return YES;
}

//- (UILabel *)titleLabel {
//    if (!_titleLabel) {
//        _titleLabel = [UILabel newAutoLayoutView];
//        _titleLabel.numberOfLines = 0;
//        
//    }
//    return _titleLabel;
//}



@end
