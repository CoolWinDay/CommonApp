//
//  UILabel+Price.h
//
//  Created by Andrew on 15/7/24.
//  Copyright (c) 2015年 com.iss. All rights reserved.
//

@interface NSString (Additions)

// 去掉收尾多余空格
- (NSString *)trimSpace;

// 如果是nil则返回@""
- (NSString *)safeString;

@end
