//
//  SXSubmitLoadingView.h
//  TPORoot
//
//  Created by SunX on 14-7-9.
//  Copyright (c) 2014年 SunX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComLoadingView : NSObject

/**
 *  显示一个只有文字的框
 *
 *  @param aString  内容
 *  @param duration 显示时间
 */
+ (void)showMsgHUD:(NSString *)aString duration:(CGFloat)duration;
/**
 *  显示一个只有文字的框
 *
 *  @param aString  内容
 *  @param duration 显示时间
 *  @param close    是否支持点击关闭
 */
+ (void)showMsgHUD:(NSString *)aString duration:(CGFloat)duration touchClose:(BOOL)close;
/**
 *  显示一个有菊花，有文字，自动消失的框
 *
 *  @param aString  文字内容，如果是nil，则只有文字，
 *  @param duration 显示时间
 */
+ (void)showLoadingHUD:(NSString *)aString duration:(CGFloat)duration;
/**
 *  显示一个有菊花，有文字的框，需要调用hideLoadingHUD消失
 *
 *  @param aString 内容
 */
+ (void)showLoadingHUD:(NSString *)aString;
/**
 *  隐藏loading
 */
+ (void)hideLoadingHUD;
/**
 *  更新loading里面的内容
 *
 *  @param aString 内容
 */
+ (void)updateLoadingHUD:(NSString*)aString;

@end
