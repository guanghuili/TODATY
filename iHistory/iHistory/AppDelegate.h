//
//  AppDelegate.h
//  iTotemMinFramework
//
//  Created by  on 12-8-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SloppySwiperNavigationController.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate> {

}

@property (strong, nonatomic)    UIWindow *window;
@property (strong, nonatomic)    SloppySwiperNavigationController *rootNavigaitonController;




-(void) startAppStore;


@end
