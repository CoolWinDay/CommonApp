//
//  ComRegistManager.m
//  CommonApp
//
//  Created by lipeng on 16/9/26.
//  Copyright © 2016年 common. All rights reserved.
//

#import "ComRegistManager.h"
#import "ComPushMsgManager.h"

#import <SMS_SDK/SMSSDK.h>
#import <SMS_SDK/Extend/SMSSDK+AddressBookMethods.h>

@implementation ComRegistManager

+ (void)registWithOptions:(NSDictionary *)launchOptions {
    [ComPushMsgManager registWithOptions:launchOptions];
    
    [SMSSDK registerApp:appkey withSecret:app_secrect];
    [SMSSDK enableAppContactFriends:NO];
}

@end
