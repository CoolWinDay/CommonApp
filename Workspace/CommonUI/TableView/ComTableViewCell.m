//
//  ComTableViewCell.m
//  CommonApp
//
//  Created by lipeng on 16/4/1.
//  Copyright © 2016年 common. All rights reserved.
//

#import "ComTableViewCell.h"

@interface ComTableViewCell ()

@end

@implementation ComTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self buildCellView];
    }
    return self;
}

- (void)buildCellView {
    
}

- (void)setCellData:(id)item atIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)cellHeight:(id)item atIndexPath:(NSIndexPath *)indexPath
{
    if (self.isAutoHeight) {
        return [self cellAutoHeight:item atIndexPath:indexPath];
    }
    else {
        return TableViewCellDefaultHeight;
    }
}

- (CGFloat)cellAutoHeight:(id)item atIndexPath:(NSIndexPath *)indexPath
{
    if (_cellConfigureBlock) {
        _cellConfigureBlock(self, item, indexPath);
    }
    else {
        [self setCellData:item atIndexPath:indexPath];
    }
    
    [self layoutIfNeeded];
    [self updateConstraintsIfNeeded];
    
    CGFloat height = [self.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    return height;
}

@end
