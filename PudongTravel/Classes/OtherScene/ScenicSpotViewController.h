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
#import "IntroductionViewController.h"

@interface ScenicSpotViewController : UIViewController
{
    wangyoudianpingViewController *wydpvc;
    dianpingViewController *dpvc;
}
@property (strong, nonatomic) NSString *idStr;
@property (weak, nonatomic) IBOutlet UILabel *merchantOrSceneTitle;
@property NSString *merchantOrSceneTitleText;

@property NSString *path;
@end
