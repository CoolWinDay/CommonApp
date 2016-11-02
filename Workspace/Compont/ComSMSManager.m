//
//  ComSMSManager.m
//  CommonApp
//
//  Created by lipeng on 16/9/20.
//  Copyright © 2016年 common. All rights reserved.
//

#import "ComSMSManager.h"
#import <SMS_SDK/SMSSDK.h>

#define ChinaTelZone @"+86"

@implementation ComSMSManager

+ (void)getVerificationCodeWithPhoneNumber:(NSString *)phoneNumber result:(ErrorBlock)block {
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:phoneNumber zone:ChinaTelZone customIdentifier:nil result:^(NSError *error) {
        if (block) {
            block(error);
        }
    }];
}

+ (void)commitWithPhoneNumber:(NSString *)phoneNumber verificationCode:(NSString *)verificationCode result:(ErrorBlock)block {
    [SMSSDK commitVerificationCode:verificationCode phoneNumber:phoneNumber zone:ChinaTelZone result:^(NSError *error) {
        if (block) {
            block(error);
        }
    }];
}

@end
