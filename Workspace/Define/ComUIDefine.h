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

//-----------------------------------  颜色  ------------------------------------
#define HEXCOLOR(rgbValue)  [ComColorManager colorWithHex:rgbValue alpha:1.f]
#define HEXCOLORA(rgbValue,a) [ComColorManager colorWithHex:rgbValue alpha:a]

#define COLOR_COMMON_BG     [UIColor whiteColor]
#define COLOR_TEXT_DEEP     [UIColor blackColor]
#define COLOR_TEXT_NORMAL   HEXCOLOR(0x423631)
#define COLOR_TEXT_LIGHT    HEXCOLOR(0x037aff)

//-----------------------------------  旋转角度  ------------------------------------
#define DegreesToRadians(degrees)             degrees*M_PI/180
#define RadiansToDegrees(radians)             radians*180/M_PI



