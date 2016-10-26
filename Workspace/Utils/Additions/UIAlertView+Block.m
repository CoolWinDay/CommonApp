//
//  UIButton+Block.m
//  CommonApp
//
//  Created by lipeng on 16/4/25.
//  Copyright © 2016年 common. All rights reserved.
//

#import "UIAlertView+Block.h"
#import "UIAlertView+Blocks.h"

@implementation UIAlertView(Block)

+ (void)alertWithMessage:(NSString *)message okBlock:(voidBlock)okBlock {
    [self alertWithTitle:nil message:message cancelBlock:nil okBlock:okBlock];
}

+ (void)alertWithTitle:(NSString *)title message:(NSString *)message cancelBlock:(voidBlock)cancelBlock okBlock:(voidBlock)okBlock
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message cancelButtonItem:[RIButtonItem itemWithLabel:@"取消" action:^{
        if (cancelBlock) {
            cancelBlock();
        }
    }] otherButtonItems:[RIButtonItem itemWithLabel:@"确定" action:^{
        if (okBlock) {
            okBlock();
        }
    }], nil];
    
    [alertView show];
}

+ (void)alertWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles clickBlock:(intBlock)clickBlock  {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message cancelButtonItem:[RIButtonItem itemWithLabel:cancelButtonTitle action:^{
        if (clickBlock) {
            clickBlock(0);
        }
    }] otherButtonItems:[RIButtonItem itemWithLabel:@"确定" action:^{
        
    }], nil];
    
    [alertView show];
}

@end
