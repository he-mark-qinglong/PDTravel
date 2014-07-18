//
//  ScenicSpotViewController.h
//  pudongapp
//
//  Created by jiangjunli on 14-2-17.
//  Copyright (c) 2014年 jiangjunli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "wangyoudianpingViewController.h"
#import "dianpingViewController.h"
@interface ScenicSpotViewController : UIViewController
{
    wangyoudianpingViewController *wydpvc;
    dianpingViewController *dpvc;
}
@property (strong, nonatomic) NSString *idStr;

@end
