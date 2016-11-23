//
//  SXCommon.h
//  Forum
//
//  Created by SunX on 14-5-7.
//  Copyright (c) 2014年 SunX. All rights reserved.
//
#import <UIKit/UIKit.h>

UIWindow *mainWindow();

UIViewController *topMostViewController();

typedef enum {
    TDDManagerEnvironmentDaily,
    TDDManagerEnvironmentPreRelease,
    TDDManagerEnvironmentRelease
} TDDManagerEnvironment;

@interface AppCommon : NSObject
//统一调用此方法来push
+ (void)pushViewController:(UIViewController*)vc animated:(BOOL)animate;
+ (void)presentViewController:(UIViewController*)vc animated:(BOOL)animated;
+ (void)presentViewController:(UIViewController*)vc;
+ (void)pushWithVCClass:(Class)vcClass properties:(NSDictionary*)properties;
+ (void)pushWithVCClassName:(NSString*)className properties:(NSDictionary*)properties;
+ (void)pushWithVCClass:(Class)vcClass;
+ (void)pushWithVCClassName:(NSString*)className;
+ (void)presentWithVCClassName:(NSString*)classNam;

+ (void)showLogin:(BoolBlock)block;

+ (void)showLoading;
+ (void)showLoadingMsg:(NSString *)msg;
+ (void)showWindowLoading;
+ (void)showWindowLoadingMsg:(NSString *)msg;
+ (void)hideLoading;

//Toast
+ (void)showToast:(NSString *)message;

+ (BOOL)isRightLocation;
+ (BOOL)isRightMessage;
+ (BOOL)isRightCamera;
+ (BOOL)isRightPhoto;

//
////删除文件或文件夹
//+ (BOOL)removeDir:(NSString*)path;
////新增文件夹
//+ (BOOL)mkdir:(NSString*)path;
////当前机器的编码 如 iPad2,1
//+ (NSString *)device;
////当前系统的bundleID plist的CFBundleIdentifier字段 (显示为 Bundle identifier)
//+ (NSString*)bundleID;
////当前系统的的版本号 plist的CFBundleShortVersionString字段（显示为Bundle Version）
//+ (NSString*)appVersion;
////当前系统的的版本号 plist的CFBundleVersion字段（显示为Build Version）
//+ (NSString*)buildVersion;
//
//+ (NSString*)writeImageTofile:(UIImage*)image
//                     filePath:(NSString*)filePath
//           compressionQuality:(CGFloat)compressionQuality;
//
////获取当前时间的microtie
//+ (long long)getMicroTime;
//
////当前API环境
//+ (TDDManagerEnvironment)currentEnvironment;
//
//+ (void)saveEnvironment:(TDDManagerEnvironment)environment;
//
//+ (void)setDeviceToken:(NSString*)deviceToken;
//
//+ (NSString*)deviceToken;
//
//+ (void)setDeviceTokenData:(NSData *)deviceToken;
//
//+ (NSData *)deviceTokenData;
//
//+ (BOOL)isJailbroken;
//
//+ (UIImage *)createImageWithColor:(UIColor *)color size:(CGSize)size;

@end





