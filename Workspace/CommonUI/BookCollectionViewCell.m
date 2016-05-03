//
//  BookTableViewCell.m
//  CommonApp
//
//  Created by lipeng on 16/4/1.
//  Copyright © 2016年 common. All rights reserved.
//

#import "BookCollectionViewCell.h"
#import "BookModel.h"

@implementation BookCollectionViewCell

- (void)setItem:(BookModel *)item
{
    [super setItem:item];
    
    self.backgroundColor = [UIColor purpleColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 50)];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:14];
    label.numberOfLines = 0;
    label.text = [NSString stringWithFormat:@"%@", item.title];
    
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.contentView addSubview:label];
}

@end
