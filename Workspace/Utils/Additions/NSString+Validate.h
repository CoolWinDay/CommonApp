//
//  UILabel+Price.h
//
//  Created by Andrew on 15/7/24.
//  Copyright (c) 2015年 com.iss. All rights reserved.
//

@interface NSString (Validate)

// 判断是否为整形
- (BOOL)isPureInt;

// 判断是否为浮点形
- (BOOL)isPureFloat;

// 判断是否为手机号
- (BOOL)isPhoneNumber;

// 判断是否为纯汉字
- (BOOL)isPureChiness;

// 判断是否包含表情符号
- (BOOL)isContainsEmoji;

@end
