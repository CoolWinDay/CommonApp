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


#define RootUrl     @"https://api.douban.com/"
#define BaseUrl     RootUrl@"v2/"

// 登陆接口
#define Login_Url      @"book/"
#define Login_Path     @"1220562"

// 图书接口
#define Book_Url      @"book/"
#define Book_Path     @"1220562"
#define BookSearch_Path     @"search?q=q"

