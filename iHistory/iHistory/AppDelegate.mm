//
//  AppDelegate.m
//
//  Created by  ligh 14-12-1.
//  Copyright (c) 2014年 eks. All rights reserved.
//

#import "AppDelegate.h"
#import "TodayVC.h"
#import "MobClick.h"
#import "YouMiConfig.h"
#import "TodayEventRequest.h"

@interface AppDelegate()
{
    TodayVC *_todayVC;
    
}
@end

@implementation AppDelegate



-  (void)dealloc
{
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{


    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

    
    [MobClick startWithAppkey:@"54bf7ea5fd98c544560000e5" reportPolicy:REALTIME channelId:@"appstore"];
    [YouMiConfig launchWithAppID:@"36e1cefefc5fe220" appSecret:@"cbd3cbb95593e8d2"];
    [YouMiConfig setUserID:@"liguanghui_job@163.com"];
    [YouMiConfig setShouldGetLocation:NO];
    [YouMiConfig setIsTesting:YES];
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    _todayVC  = [[[TodayVC alloc] init] autorelease];
    _rootNavigaitonController = [[[SloppySwiperNavigationController alloc] initWithRootViewController:_todayVC] autorelease];
    _rootNavigaitonController.automaticallyAdjustsScrollViewInsets = NO;
    _rootNavigaitonController.edgesForExtendedLayout = UIRectEdgeNone;
    _rootNavigaitonController.navigationBar.hidden = YES;
    
    

    
    [self.window setRootViewController:_rootNavigaitonController];
    [self.window makeKeyAndVisible];
    


    return YES;
}



//全局控制禁止转屏
- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    

}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
 
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/**
 *  启动app store
 */
-(void) startAppStore
{
    if (IOS_VERSION_CODE  < 7)
    {
        NSString * appstoreUrlString = [NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?mt=8&onlyLatestVersion=true&pageNumber=0&sortOrdering=1&type=Purple+Software&id=%@",@"953364841"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appstoreUrlString]];
    }else
    {
        NSString * appstoreUrlString = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@",@"953364841"];
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appstoreUrlString]];
    }
    
}



@end
