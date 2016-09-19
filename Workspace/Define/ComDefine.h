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
typedef void (^voidBlock)();
typedef void (^idBlock)(id value);
typedef void (^intBlock)(int value);
typedef void (^boolBlock)(id value);

//----------------------------------- block ------------------------------------
// 弱引用
#define WeakSelf __weak typeof(self) weakSelf = self;

//----------------------------------- notifation ------------------------------------
#define NotiApplicationStateBackground @"NotiApplicationStateBackground"
#define NotiApplicationStateForeground @"NotiApplicationStateForeground"


//SMSSDK官网公共key
#define appkey @"f3fc6baa9ac4"
#define app_secrect @"7f3dedcb36d92deebcb373af921d635a"

