//
//  UIButton+Block.m
//  CommonApp
//
//  Created by lipeng on 16/4/25.
//  Copyright © 2016年 common. All rights reserved.
//

#import "UIButton+Block.h"

@implementation UIButton(Block)

static char overviewKey;

@dynamic event;

- (void)handleControlEvent:(UIControlEvents)event withBlock:(ButtonActionBlock)block {
    objc_setAssociatedObject(self, &overviewKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(callActionBlock:) forControlEvents:event];
}

- (void)handleClickWithBlock:(ButtonActionBlock)block {
    [self handleControlEvent:UIControlEventTouchUpInside withBlock:block];
}

- (void)callActionBlock:(id)sender {
    ButtonActionBlock block = (ButtonActionBlock)objc_getAssociatedObject(self, &overviewKey);
    if (block) {
        block(self);
    }
}

@end
