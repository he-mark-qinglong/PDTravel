//
//  dongfangbaliViewController.h
//  pudongapp
//
//  Created by jiangjunli on 14-3-2.
//  Copyright (c) 2014年 jiangjunli. All rights reserved.
//

#import <UIKit/UIKit.h>

enum ScenicType{
    ELujiaZui_EExpo,
    EDfbl
};
@interface dongfangbaliViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *mainPicture;
@property (weak, nonatomic) IBOutlet UIView *downView;
@property (strong, nonatomic) NSString *showType;
@property (strong, nonatomic) NSString *buttonname1;
@property (strong, nonatomic) NSString *buttonname2;
@property NSString *pathId;
@property NSString *mainPictureUrl;

@property enum ScenicType eScenicType;
@end
