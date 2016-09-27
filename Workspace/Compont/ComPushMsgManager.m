//
//  ComPushMsgManager.m
//  CommonApp
//
//  Created by lipeng on 16/9/26.
//  Copyright © 2016年 common. All rights reserved.
//

#import "ComPushMsgManager.h"
#import "UMessage.h"

@implementation ComPushMsgManager

+ (instancetype)instance {
    static ComPushMsgManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

+ (void)registWithOptions:(NSDictionary *)launchOptions {
    //设置 AppKey 及 LaunchOptions
    [UMessage startWithAppkey:kUmengAppKey launchOptions:launchOptions];
    //注册通知
    [UMessage registerForRemoteNotifications];
    
    //iOS10必须加下面这段代码。
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
//    center.delegate = self;
    UNAuthorizationOptions types10 = UNAuthorizationOptionBadge|UNAuthorizationOptionAlert|UNAuthorizationOptionSound;
    [center requestAuthorizationWithOptions:types10 completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            //点击允许
            
        } else {
            //点击不允许
            
        }
    }];
    
    
    {
//        //如果你期望使用交互式(只有iOS 8.0及以上有)的通知，请参考下面注释部分的初始化代码
//        UIMutableUserNotificationAction *action1 = [[UIMutableUserNotificationAction alloc] init];
//        action1.identifier = @"action1_identifier";
//        action1.title=@"打开应用";
//        action1.activationMode = UIUserNotificationActivationModeForeground;//当点击的时候启动程序
//        
//        UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc] init];  //第二按钮
//        action2.identifier = @"action2_identifier";
//        action2.title=@"忽略";
//        action2.activationMode = UIUserNotificationActivationModeBackground;//当点击的时候不启动程序，在后台处理
//        action2.authenticationRequired = YES;//需要解锁才能处理，如果action.activationMode = UIUserNotificationActivationModeForeground;则这个属性被忽略；
//        action2.destructive = YES;
//        UIMutableUserNotificationCategory *actionCategory1 = [[UIMutableUserNotificationCategory alloc] init];
//        actionCategory1.identifier = @"category1";//这组动作的唯一标示
//        [actionCategory1 setActions:@[action1,action2] forContext:(UIUserNotificationActionContextDefault)];
//        NSSet *categories = [NSSet setWithObjects:actionCategory1, nil];
//        
//        //如果要在iOS10显示交互式的通知，必须注意实现以下代码
//        if ([[[UIDevice currentDevice] systemVersion]intValue]>=10) {
//            UNNotificationAction *action1_ios10 = [UNNotificationAction actionWithIdentifier:@"action1_ios10_identifier" title:@"打开应用" options:UNNotificationActionOptionForeground];
//            UNNotificationAction *action2_ios10 = [UNNotificationAction actionWithIdentifier:@"action2_ios10_identifier" title:@"忽略" options:UNNotificationActionOptionForeground];
//            
//            //UNNotificationCategoryOptionNone
//            //UNNotificationCategoryOptionCustomDismissAction  清除通知被触发会走通知的代理方法
//            //UNNotificationCategoryOptionAllowInCarPlay       适用于行车模式
//            UNNotificationCategory *category1_ios10 = [UNNotificationCategory categoryWithIdentifier:@"category101" actions:@[action1_ios10,action2_ios10]   intentIdentifiers:@[] options:UNNotificationCategoryOptionCustomDismissAction];
//            NSSet *categories_ios10 = [NSSet setWithObjects:category1_ios10, nil];
//            [center setNotificationCategories:categories_ios10];
//        }else
//        {
//            [UMessage registerForRemoteNotifications:categories];
//        }
//        
//        //如果对角标，文字和声音的取舍，请用下面的方法
//        //UIRemoteNotificationType types7 = UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound;
//        //UIUserNotificationType types8 = UIUserNotificationTypeAlert|UIUserNotificationTypeSound|UIUserNotificationTypeBadge;
//        //[UMessage registerForRemoteNotifications:categories withTypesForIos7:types7 withTypesForIos8:types8];
    }
    
#ifdef DEBUG
    //打开日志，方便调试
    [UMessage setLogEnabled:YES];
#endif
}

+ (void)handelRemoteNotification:(NSDictionary *)userInfo {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"userInfoNotification" object:self userInfo:@{@"userinfo":[NSString stringWithFormat:@"%@",userInfo]}];
    //关闭友盟自带的弹出框
//    [UMessage didReceiveRemoteNotification:userInfo];
    
    [UMessage setAutoAlert:NO];
    //定制自定的的弹出框
    if([UIApplication sharedApplication].applicationState == UIApplicationStateActive)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"标题"
                                                            message:@"Test On ApplicationStateActive"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];

        [alertView show];

    }
}

////iOS10新增：处理前台收到通知的代理方法
//-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
//    NSDictionary * userInfo = notification.request.content.userInfo;
//    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
//        //应用处于前台时的远程推送接受
//        //必须加这句代码
//        [UMessage didReceiveRemoteNotification:userInfo];
//
//    }else{
//        //应用处于前台时的本地推送接受
//    }
//
//}
//
////iOS10新增：处理后台点击通知的代理方法
//-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler{
//    NSDictionary * userInfo = response.notification.request.content.userInfo;
//    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
//        //应用处于后台时的远程推送接受
//        //必须加这句代码
//        [UMessage didReceiveRemoteNotification:userInfo];
//
//    }else{
//        //应用处于后台时的本地推送接受
//    }
//
//}

@end
