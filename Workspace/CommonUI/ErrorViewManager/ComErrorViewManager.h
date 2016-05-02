//
//  ComErrorViewManager.h
//  CommonApp
//
//  Created by lipeng on 16/4/8.
//  Copyright © 2016年 common. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ComErrorViewManager : NSObject

+ (UIView*)showErrorViewInView:(UIView*)view withError:(NSError*)error;

+ (UIView*)showErrorViewInView:(UIView*)view withError:(NSError*)error clickBlock:(voidBlock)block;

+ (void)removeErrorViewFromView:(UIView*)view;

+ (UIView*)showEmptyViewInView:(UIView*)view;

+ (UIView*)showEmptyViewInView:(UIView*)view clickBlock:(voidBlock)block;

+ (UIView*)showErrorString:(NSString*)string inView:(UIView*)view;

@end
