//
//  BookModel.h
//  CommonApp
//
//  Created by lipeng on 16/3/12.
//  Copyright © 2016年 common. All rights reserved.
//

#import "ComModel.h"
#import "TagModel.h"

@interface BookModel : ComModel

@property(nonatomic, copy) NSString *bId;
@property(nonatomic, copy) NSString *alt;
@property(nonatomic, copy) NSString *publisher;
@property(nonatomic, copy) NSString *isbn13;
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *summary;
@property(nonatomic, copy) NSString *price;
@property(nonatomic, copy) NSString *image;

//@property(nonatomic, strong) NSDictionary *images;
//@property(nonatomic, strong) NSArray<TagModel*> *tags;

@end
