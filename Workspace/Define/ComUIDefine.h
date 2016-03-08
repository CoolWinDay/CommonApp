//
//  ComUIDefine.h
//  CommonApp
//
//  Created by lipeng on 16/3/8.
//  Copyright © 2016年 common. All rights reserved.
//

//-----------------------------------  设备的宽高  ------------------------------------
#define APP_SCREEN_WIDTH     [UIScreen mainScreen].bounds.size.width
#define APP_SCREEN_HEIGHT    [UIScreen mainScreen].bounds.size.height

////-----------------------------------  颜色  ------------------------------------
//// e.g. HEXCOLOR(0xCECECE);
//#define HEXCOLOR(rgbValue)  [TBCityColorManager colorWithHex:rgbValue alpha:1.f]
//
//// e.g. HEXCOLORA(0xCECECE, 0.8);
//#define HEXCOLORA(rgbValue,a) [TBCityColorManager colorWithHex:rgbValue alpha:a]

//-----------------------------------  旋转角度  ------------------------------------
#define DegreesToRadians(degrees)             degrees*M_PI/180
#define RadiansToDegrees(radians)             radians*180/M_PI



