//
//  ComSMSManager.h
//  CommonApp
//
//  Created by lipeng on 16/9/20.
//  Copyright © 2016年 common. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ComSMSManager : NSObject

+ (void)getVerificationCodeWithPhoneNumber:(NSString *)phoneNumber result:(ErrorBlock)block;
+ (void)commitWithPhoneNumber:(NSString *)phoneNumber verificationCode:(NSString *)verificationCode result:(ErrorBlock)block;
    
@end
