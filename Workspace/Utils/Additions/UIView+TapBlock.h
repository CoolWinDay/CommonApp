//
//  UIButton+Block.h
//  CommonApp
//
//  Created by lipeng on 16/4/25.
//  Copyright © 2016年 common. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>


typedef void (^ViewTapBlock)();

@interface UIView(TapBlock)

@property(readonly) NSMutableDictionary *event;

- (void)handleTapEventWithBlock:(ViewTapBlock)block;

@end
