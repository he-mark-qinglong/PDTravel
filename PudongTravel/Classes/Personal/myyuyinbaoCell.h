//
//  myyuyinbaoCell.h
//  pudongapp
//
//  Created by jiangjunli on 14-3-3.
//  Copyright (c) 2014年 jiangjunli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "UserData.h"

#import "ElseMainViewData.h"

@interface myyuyinbaoCell : UITableViewCell
+(id)cell:(VoiceInfo *)info;

+(void)clearPlayer;
@end
