//
//  ComNetManager.m
//  CommonApp
//
//  Created by lipeng on 16/9/21.
//  Copyright © 2016年 common. All rights reserved.
//

#import "ComNetManager.h"
#import "Reachability.h"

@implementation ComNetManager

+ (BOOL)isNetwork {
    return [Reachability reachabilityForInternetConnection].currentReachabilityStatus != NotReachable;
}

+ (BOOL)isWifi {
    NetworkStatus status = [Reachability reachabilityForInternetConnection].currentReachabilityStatus;
    if (status == ReachableViaWiFi) {
        return YES;
    }
    return NO;
}

@end
