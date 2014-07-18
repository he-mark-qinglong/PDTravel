//
//  AppDelegate.m
//  pudongapp
//
//  Created by jiangjunli on 14-1-7.
//  Copyright (c) 2014年 jiangjunli. All rights reserved.
//

#import <ShareSDK/ShareSDK.h>
#import "AppDelegate.h"
#import "CommonHeader.h"

#import "DDMenuController.h"
#import "MenuController.h"

#import "EmbedReaderViewController.h"
#import "ReadeViewController.h"
#import "RightViewController.h"
#import "UIImage+loadImage.h"
#import "BaiDuMapManager.h"

#import "CustomNavigationController.h"
#import "ReadeViewController.h"


@implementation AppDelegate
@synthesize menuController = _menuController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [ShareSDK registerApp:@"1a48dc7f38c8"]; //你注册的sharesdk的appkey
    {
        /**
         连接新浪微博开放平台应用以使用相关功能，此应用需要引用SinaWeiboConnection.framework
         http://open.weibo.com上注册新浪微博开放平台应用，并将相关信息填写到以下字段
         **/
        [ShareSDK connectSinaWeiboWithAppKey:@"568898243"
                                   appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
                                 redirectUri:@"http://www.sharesdk.cn"];
        /**
         连接腾讯微博开放平台应用以使用相关功能，此应用需要引用TencentWeiboConnection.framework
         http://dev.t.qq.com上注册腾讯微博开放平台应用，并将相关信息填写到以下字段
         
         如果需要实现SSO，需要导入libWeiboSDK.a，并引入WBApi.h，将WBApi类型传入接口
         **/
        [ShareSDK connectTencentWeiboWithAppKey:@"801307650"
                                      appSecret:@"ae36f4ee3946e1cbb98d6965b0b2ff5c"
                                    redirectUri:@"http://www.sharesdk.cn"];
        /**
         连接人人网应用以使用相关功能，此应用需要引用RenRenConnection.framework
         http://dev.renren.com上注册人人网开放平台应用，并将相关信息填写到以下字段
         **/
        [ShareSDK connectRenRenWithAppKey:@"fc5b8aed373c4c27a05b712acba0f8c3"
                                appSecret:@"f29df781abdd4f49beca5a2194676ca4"];
        
        /**
         连接开心网应用以使用相关功能，此应用需要引用KaiXinConnection.framework
         http://open.kaixin001.com上注册开心网开放平台应用，并将相关信息填写到以下字段
         **/
        [ShareSDK connectKaiXinWithAppKey:@"358443394194887cee81ff5890870c7c"
                                appSecret:@"da32179d859c016169f66d90b6db2a23"
                              redirectUri:@"http://www.sharesdk.cn/"];
        
    }
    
    [application setStatusBarStyle:UIStatusBarStyleLightContent];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    if (IOS7) {
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageWithResourceName:@"top_background.png"]
                                           forBarMetrics:UIBarMetricsDefault];
        [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    } else {
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageWithResourceName:@"top44.png"]
                                           forBarMetrics:UIBarMetricsDefault];
   
        [[UINavigationBar appearance] setTitleVerticalPositionAdjustment:4.0f forBarMetrics:UIBarMetricsDefault];

        [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:51.0/255.0 green:143.0/255.0 blue:210.0/255.0 alpha:1]];
    }
    
  
    CustomNavigationController *navController = [[CustomNavigationController alloc]
                                             initWithRootViewController: [[MenuController alloc]init]];
    DDMenuController *rootController      = [[DDMenuController alloc] initWithRootViewController: navController];
    _menuController                        = rootController;
    rootController.leftViewController      = [[EmbedReaderViewController alloc] init];
    rootController.rightViewController     = [[RightViewController alloc] init];
    self.window.rootViewController         = rootController;
    self.window.backgroundColor            = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [BaiDuMapManager ShareInstrance];
    
    return YES;
}

+(void)showLogin{
    DDMenuController *ddMenuController = [(AppDelegate *)[UIApplication sharedApplication].delegate menuController];
    [ddMenuController showRightController:YES];
    User *user = [[LocalCache sharedCache] cachedObjectForKey:@"user"];
    if(user == nil || user.isLoginSuccess == NO){
        [(RightViewController*)(ddMenuController.rightViewController) loginBtnClick:nil];
    }
}

+(void)showRight{
    DDMenuController *ddMenuController = [(AppDelegate *)[UIApplication sharedApplication].delegate menuController];
    [ddMenuController showRightController:YES];
}
+(void)showLeft{
    DDMenuController *ddMenuController = [(AppDelegate *)[UIApplication sharedApplication].delegate menuController];
    [ddMenuController showLeftController:YES];
}
+(void)showMiddle{
    DDMenuController *ddMenuController = [(AppDelegate *)[UIApplication sharedApplication].delegate menuController];
    [ddMenuController showRootController:YES];
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

@end
