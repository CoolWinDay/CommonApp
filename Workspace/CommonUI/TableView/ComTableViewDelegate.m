//
//  ComTableViewDelegate.m
//  CommonApp
//
//  Created by lipeng on 16/4/29.
//  Copyright © 2016年 common. All rights reserved.
//

#import "ComTableViewDelegate.h"
#import "ComTableViewCell.h"

@interface ComTableViewDelegate()

@property(nonatomic, copy) NSString *cellIdentifier;

@end

@implementation ComTableViewDelegate

- (instancetype)initWithCellIdentifier:(NSString *)cellIdentifier {
    self = [super init];
    if (self) {
        _cellIdentifier = cellIdentifier;
    }
    return self;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_cellSelectBlock) {
        _cellSelectBlock(tableView, indexPath);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_cellHeightBlock) {
        return _cellHeightBlock(tableView, indexPath);
    }
    return TableViewCellDefaultHeight;
}

@end
