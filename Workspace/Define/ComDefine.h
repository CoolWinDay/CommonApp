//
//  ComDefine.h
//  CommonApp
//
//  Created by SunX on 15/7/15.
//  Copyright (c) 2015年 SunX. All rights reserved.
//

#import "ComServerDefine.h"

/**
 *  一些公共属性define
 */

////-----------------------------------  颜色  ------------------------------------
//// e.g. HEXCOLOR(0xCECECE);
//#define HEXCOLOR(rgbValue)  [TBCityColorManager colorWithHex:rgbValue alpha:1.f]
//
//// e.g. HEXCOLORA(0xCECECE, 0.8);
//#define HEXCOLORA(rgbValue,a) [TBCityColorManager colorWithHex:rgbValue alpha:a]

//-----------------------------------  旋转角度  ------------------------------------
#define DegreesToRadians(degrees)             degrees*M_PI/180
#define RadiansToDegrees(radians)             radians*180/M_PI

//-----------------------------------  设备的宽高  ------------------------------------
#define APP_SCREEN_WIDTH     [UIScreen mainScreen].bounds.size.width
#define APP_SCREEN_HEIGHT    [UIScreen mainScreen].bounds.size.height
