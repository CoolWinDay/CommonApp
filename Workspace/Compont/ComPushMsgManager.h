//
//  ComPushMsgManager.h
//  CommonApp
//
//  Created by lipeng on 16/9/26.
//  Copyright © 2016年 common. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ComPushMsgManager : NSObject

+ (instancetype)instance;
+ (void)registWithOptions:(NSDictionary *)launchOptions;
+ (void)handelRemoteNotification:(NSDictionary *)userInfo;

@end
