//
//  UIButton+Block.h
//  CommonApp
//
//  Created by lipeng on 16/4/25.
//  Copyright © 2016年 common. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>


typedef void (^ButtonActionBlock)();

@interface UIAlertView(Block)

@property (readonly) NSMutableDictionary *event;

//- (void) handleControlEvent:(UIControlEvents)controlEvent withBlock:(ButtonActionBlock)action;
//- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION aaa:(NSString *)bbb;

@end
