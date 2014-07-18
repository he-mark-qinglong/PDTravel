//
//  MenuController.h
//  pudongapp
//
//  Created by jiangjunli on 14-1-7.
//  Copyright (c) 2014年 jiangjunli. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "NearbyViewController.h"
#import "NearbyMapViewController.h"
#import "FreeTicketViewController.h"
#import "TravelSupermarketViewController.h"
#import "FestivalViewController.h"
#import "lujiazuiViewController.h"
#import "OtherSceneViewController.h"

#import "UIView+FitVersions.h"
@interface MenuController : UIViewController<UIScrollViewDelegate>
{
    UIScrollView *_scroll;
    UINavigationBar *navBar;
//    NearbyViewController *nvc;
    FreeTicketViewController *ftvc;
    TravelSupermarketViewController *tsvc;
    FestivalViewController *fvc;
    lujiazuiViewController *lvc;
    OtherSceneViewController *osvc;
    NearbyMapViewController *mapvc;
}
@end
