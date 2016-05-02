//
//  UIButton+Block.m
//  CommonApp
//
//  Created by lipeng on 16/4/25.
//  Copyright © 2016年 common. All rights reserved.
//

#import "UIView+TapBlock.h"

@implementation UIView(TapBlock)

static char overviewKey;

@dynamic event;

- (void)handleTapEventWithBlock:(ViewTapBlock)block {
    objc_setAssociatedObject(self, &overviewKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(callActionBlock:)];
    [self addGestureRecognizer:tapGes];
    self.userInteractionEnabled = YES;
}

- (void)callActionBlock:(id)sender {
    ViewTapBlock block = (ViewTapBlock)objc_getAssociatedObject(self, &overviewKey);
    if (block) {
        block();
    }
}

@end
