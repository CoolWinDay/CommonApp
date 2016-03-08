//
//  ComDefine.h
//  CommonApp
//
//  Created by SunX on 15/7/15.
//  Copyright (c) 2015年 SunX. All rights reserved.
//

#if defined APP_DAILY

////-----------------------------------  测试环境  ------------------------------------

#define Service_Address     @"http://wx.bjyijiequ.com/yjqapp/"

// **********************************************************************************

#else

////-----------------------------------  生产环境  ------------------------------------

#define Service_Address     @"http://d.bjyijiequ.com/qpi/"


#endif


#define RootUrl     @"http://yidongguoyi.zonetime.net/"
#define BaseUrl     RootUrl@"Api/"


// 登陆接口
#define Login_Url      @"Login/"
#define Login_Path     @"checkNamePwd"

