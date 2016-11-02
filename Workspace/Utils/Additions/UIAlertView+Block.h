//
//  UIButton+Block.h
//  CommonApp
//
//  Created by lipeng on 16/4/25.
//  Copyright © 2016年 common. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIAlertView(Block)

+ (void)alertWithMessage:(NSString *)message okBlock:(VoidBlock)okBlock;
+ (void)alertWithTitle:(NSString *)title message:(NSString *)message cancelBlock:(VoidBlock)cancelBlock okBlock:(VoidBlock)okBlock;

@end
