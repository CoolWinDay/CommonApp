//
//  SXCommon.m
//  Forum
//
//  Created by SunX on 14-5-7.
//  Copyright (c) 2014年 SunX. All rights reserved.
//

#import "AppCommon.h"
#import "Reachability.h"
#import <sys/sysctl.h>
#import <Security/Security.h>
#import "ComLoadingView.h"
#import "RegisterViewController.h"
#import "LogInPprotocol.h"
#import <CoreLocation/CLLocationManager.h>

#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <CoreLocation/CoreLocation.h>
#import "UIView+Toast.h"

#import "ComApplication.h"

UIWindow *mainWindow() {
    id appDelegate = [UIApplication sharedApplication].delegate;
    if (appDelegate && [appDelegate respondsToSelector:@selector(window)]) {
        return [appDelegate window];
    }
    
    NSArray *windows = [UIApplication sharedApplication].windows;
    if ([windows count] == 1) {
        return [windows firstObject];
    }
    else {
        for (UIWindow *window in windows) {
            if (window.windowLevel == UIWindowLevelNormal) {
                return window;
            }
        }
    }
    return nil;
}

UIViewController *topMostViewController() {
    UIViewController *topViewController = mainWindow().rootViewController;
    UIViewController *temp = nil;
    while (YES) {
        temp = nil;
        if ([topViewController isKindOfClass:[UINavigationController class]]) {
            temp = ((UINavigationController *)topViewController).visibleViewController;
            
        } else if ([topViewController isKindOfClass:[UITabBarController class]]) {
            temp = ((UITabBarController *)topViewController).selectedViewController;
        }
        else if (topViewController.presentedViewController != nil) {
            temp = topViewController.presentedViewController;
        }
        
        if (temp != nil) {
            topViewController = temp;
        } else {
            break;
        }
    }
    return topViewController;
}


@implementation AppCommon

+ (void)pushViewController:(UIViewController*)vc animated:(BOOL)animated {
    BOOL isNeedLogin = [vc conformsToProtocol:@protocol(LogInPprotocol)] && [vc performSelector:@selector(isNeedLogin)] && ![UserManager isLogedin];
    
    if (isNeedLogin) {
        [AppCommon showLogin:^(BOOL isSuccess) {
            if (isSuccess) {
                [AppCommon pushViewController:vc animated:animated];
            }
        }];
    }
    else {
        [AppNavigationController pushViewController:vc animated:animated];
    }
}

+ (void)pushWithVCClass:(Class)vcClass properties:(NSDictionary*)properties {
    id obj = [vcClass new];
    if(properties)
        [obj yy_modelSetWithDictionary:properties];
    [self pushViewController:obj animated:YES];
}

+ (void)pushWithVCClassName:(NSString*)className properties:(NSDictionary*)properties {
    [self pushWithVCClass:NSClassFromString(className) properties:properties];
}

+ (void)pushWithVCClass:(Class)vcClass {
    [self pushWithVCClass:vcClass properties:nil];
}

+ (void)pushWithVCClassName:(NSString*)className {
    [self pushWithVCClass:NSClassFromString(className) properties:nil];
}

+ (void)popViewController {
    [AppNavigationController popViewControllerAnimated:YES];
}

+ (void)presentViewController:(UIViewController*)vc {
    [self presentViewController:vc animated:YES];
}

+ (void)presentViewController:(UIViewController*)vc animated:(BOOL)animated {
    [((UINavigationController*)[[[[UIApplication sharedApplication] windows] objectAtIndex:0] rootViewController]) presentViewController:vc animated:animated completion:nil];
}

+ (void)presentWithVCClassName:(NSString*)className {
    id obj = [NSClassFromString(className) new];
    [self presentViewController:obj];
}

+ (void)showLogin:(BoolBlock)block {
    RegisterViewController *loginVC = [[RegisterViewController alloc] init];
    loginVC.resultBlock = block;
    [self presentViewController:loginVC animated:YES];
}

+ (void)showLoading {
    [self showLoadingMsg:@"正在加载..."];
}

+ (void)showWindowLoading {
    [self showWindowLoadingMsg:@"正在加载..."];
}

+ (void)showLoadingMsg:(NSString *)msg {
    [ComLoadingView showLoadingHUD:msg onWindow:NO];
}

+ (void)showWindowLoadingMsg:(NSString *)msg {
    [ComLoadingView showLoadingHUD:msg onWindow:YES];
}

+ (void)hideLoading {
    [ComLoadingView hideLoadingHUD];
}

+ (void)showToast:(NSString *)message {
    [AppDelegate.window makeToast:message];
}

+ (void)showToast:(NSString *)message position:(ToastPosition)position {
    id positionId = CSToastPositionBottom;
    switch (position) {
        case ToastPositionTop:
            positionId = CSToastPositionTop;
            break;
        case ToastPositionCenter:
            positionId = CSToastPositionCenter;
            break;
        case ToastPositionBottom:
            positionId = CSToastPositionBottom;
            break;
        default:
            break;
    }
    [AppDelegate.window makeToast:message duration:[CSToastManager defaultDuration] position:positionId];
}

+ (BOOL)isRightLocation {
    // 定位权限
    // locationServicesEnabled：用户是否打开了定位功能
    CLAuthorizationStatus authStatus = [CLLocationManager authorizationStatus];
    return [CLLocationManager locationServicesEnabled] && (authStatus == kCLAuthorizationStatusAuthorizedAlways || authStatus == kCLAuthorizationStatusAuthorizedWhenInUse);
}

+ (BOOL)isRightMessage {
    UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
    return UIUserNotificationTypeNone != setting.types;
}

+ (BOOL)isRightCamera {
    //相机权限、
    // AVAuthorizationStatusRestricted：此应用程序没有被授权相机访问数据。可能是家长控制权限
    // AVAuthorizationStatusDenied：用户已经明确否认了这一相机数据的应用程序访问
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    return authStatus != AVAuthorizationStatusRestricted && authStatus != AVAuthorizationStatusDenied;
}

+ (BOOL)isRightPhoto {
    //相册权限
    ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
    return author != kCLAuthorizationStatusRestricted && author != kCLAuthorizationStatusDenied;
}

//
//+ (BOOL)removeDir:(NSString*)path
//{
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    return [fileManager removeItemAtPath:path error:nil];
//}
//
//+ (BOOL)mkdir:(NSString*)path
//{
//    BOOL isDir = NO;
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    BOOL existed = [fileManager fileExistsAtPath:path isDirectory:&isDir];
//    if ( !(isDir == YES && existed == YES) )
//    {
//        return [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
//    }
//    return NO;
//}
//
//+ (NSString *)device{
//	size_t size;
//	sysctlbyname("hw.machine", NULL, &size, NULL, 0);
//	char *machine = malloc(size);
//	sysctlbyname("hw.machine", machine, &size, NULL, 0);
//	NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
//	free(machine);
//	return platform;
//}
//
//+ (NSString *)bundleID{
//    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"];
//}
//
//+ (NSString*)appVersion{
//    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
//}
//
//+ (NSString*)buildVersion
//{
//    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
//}
//
//+ (NSString*)writeImageTofile:(UIImage*)image
//                     filePath:(NSString*)filePath
//           compressionQuality:(CGFloat)compressionQuality
//{
//    if (image == nil)
//        return nil;
//    @try
//    {
//        NSData *imageData = nil;
//        NSString *ext = [filePath pathExtension];
//        if ([ext isEqualToString:@"png"])
//            imageData = UIImagePNGRepresentation(image);
//        else
//        {
//            imageData = UIImageJPEGRepresentation(image, compressionQuality);
//        }
//        if ((imageData == nil) || ([imageData length] <= 0))
//            return nil;
//        
//        [imageData writeToFile:filePath atomically:YES];
//        return filePath;
//    }
//    @catch (NSException *e)
//    {
//        NSLog(@"创建分享的临时图片错误：%@",e);
//    }
//    return nil;
//}
//
//
//+ (long long)getMicroTime
//{
//    struct timeval tvStart;
//    gettimeofday (&tvStart,NULL);
//    long long tStart = (long long)1000000*tvStart.tv_sec+tvStart.tv_usec;
//    return tStart;
//}
//
//+ (TDDManagerEnvironment)currentEnvironment {
//    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"mtop_environment"]) {
//        return [[[NSUserDefaults standardUserDefaults] objectForKey:@"mtop_environment"] intValue];
//    }
//#if defined  MTOP_DAILY
//    return TDDManagerEnvironmentDaily;
//#elif defined MTOP_PRERELEASE
//    return TDDManagerEnvironmentPreRelease;
//#else
//    return TDDManagerEnvironmentRelease;
//#endif
//}
//
//+ (void)saveEnvironment:(TDDManagerEnvironment)environment {
//    [[NSUserDefaults standardUserDefaults] setObject:@(environment) forKey:@"mtop_environment"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//}
//
//+ (void)setDeviceToken:(NSString *)deviceToken {
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setObject:deviceToken forKey:@"tddmanager_device_token"];
//    [defaults synchronize];
//}
//
//+ (NSString *)deviceToken {
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSString *token = [defaults stringForKey:@"tddmanager_device_token"];
//    return token ?: nil;
//}
//
//+ (void)setDeviceTokenData:(NSData *)deviceToken {
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setObject:deviceToken forKey:@"tddmanager_device_token_data"];
//    [defaults synchronize];
//}
//
//+ (NSData *)deviceTokenData {
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSData *token = [defaults objectForKey:@"tddmanager_device_token_data"];
//    return token ?: nil;
//}
//
//+ (BOOL)isJailbroken {
//    static int jailbroken = -1;
//    
//    static NSString* cydiaPath = @"/Applications/Cydia.app";
//    static NSString* aptPath = @"/private/var/lib/apt/";
//    
//    if (-1 == jailbroken)
//    {
//        if([[NSFileManager defaultManager] fileExistsAtPath:cydiaPath]
//           || [[NSFileManager defaultManager] fileExistsAtPath:aptPath])
//        {
//            jailbroken = 1;
//        }
//        else
//        {
//            jailbroken = 0;
//        }
//    }
//    
//    return (1 == jailbroken) ? YES : NO;
//}
//
//
//+ (UIImage *)createImageWithColor:(UIColor *)color size:(CGSize)size {
//    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
//    UIGraphicsBeginImageContext(rect.size);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetFillColorWithColor(context, [color CGColor]);
//    CGContextFillRect(context, rect);
//    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    
//    return theImage;
//}

@end

