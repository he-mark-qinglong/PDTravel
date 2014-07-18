//
//  AppDelegate.h
//  pudongapp
//
//  Created by jiangjunli on 14-1-7.
//  Copyright (c) 2014年 jiangjunli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "DDMenuController.h"

@class DDMenuController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) DDMenuController *menuController;
@property (strong, nonatomic) UIWindow *window;
+(void)showLogin;

+(void)showRight;
+(void)showLeft;
+(void)showMiddle;
@end
