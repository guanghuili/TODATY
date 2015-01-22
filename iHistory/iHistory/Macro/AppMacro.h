//
//  AppMacro.h
//  MinFramework
//  app相关的宏定义
//
//  Created by ligh on 14-3-10.
//
//

#ifndef MinFramework_AppMacro_h
#define MinFramework_AppMacro_h



#import "AppDelegate.h"

//正式
//#define Host_Url @"http://eks-admin.ekuaisong.com/companyopencustomer"

//测试
#define Host_Url @"http://japi.juhe.cn/toh/"

//
//#define Host_Url @"http://192.168.1.104/customer"

#define APP_VER   [AppHelper appVer]

#define API_VER  @"V2.2"

#define USER_DEFAULT [NSUserDefaults standardUserDefaults]
//AppDelegate
#define KAPP_Delegate  (AppDelegate *)[UIApplication sharedApplication].delegate



#endif
