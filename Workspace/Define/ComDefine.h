//
//  ComDefine.h
//  CommonApp
//
//  Created by SunX on 15/7/15.
//  Copyright (c) 2015年 SunX. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  一些公共属性define
 */

//----------------------------------- 网络环境设置 ------------------------------------
//默认是正式环境  上线必需注释这两项  优先选择DEBUG的环境

// 设置测试环境
#define APP_DAILY

// 设置预发环境
//#define APP_PRERELEASE


//----------------------------------- 是否会打印log ------------------------------------
#if defined APP_DAILY

#define APP_SHOW_LOG_DEBUG

#elif defined APP_PRERELEASE

#define APP_SHOW_LOG_DEBUG

#else

#endif


#ifdef APP_SHOW_LOG_DEBUG
#define NSLog(...)  NSLog(__VA_ARGS__)
#define DLog(fmt, ...)  NSLog((@"[File:%@][Line: %d]%s " fmt),[[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, __PRETTY_FUNCTION__, ##__VA_ARGS__)
#else
#define NSLog(...)
#define DLog(...)
#endif


//----------------------------------- block ------------------------------------
typedef void (^VoidBlock)();
typedef void (^IdBlock)(id value);
typedef void (^IntBlock)(NSInteger value);
typedef void (^BoolBlock)(BOOL value);
typedef void (^ErrorBlock) (NSError *error);

//----------------------------------- block ------------------------------------
// 弱引用
#define AppWeakSelf __weak typeof(self) weakSelf = self;

//----------------------------------- notifation ------------------------------------

//----------------------------------- 各种第三方key ------------------------------------
// SMSSDK官网公共key
//#define appkey @"f3fc6baa9ac4"
//#define app_secrect @"7f3dedcb36d92deebcb373af921d635a"
// SMSSDK我的测试key
#define appkey @"173f87709381d"
#define app_secrect @"69988802391e4d4be0214cbfd1dc7299"

#define kUmengAppKey @"561b44cf67e58e6189001c30"



//----------------------------------- 其他的 ------------------------------------
#define AppDelegate [UIApplication sharedApplication].delegate
#define AppNavigationController ((UINavigationController*)[[[[UIApplication sharedApplication] windows] objectAtIndex:0] rootViewController])


