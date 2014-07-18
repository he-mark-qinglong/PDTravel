//
//  SoundCell.h
//  pudongapp
//
//  Created by jiangjunli on 14-2-19.
//  Copyright (c) 2014年 jiangjunli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "ElseMainViewData.h"

@interface SoundCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *area;
@property (weak, nonatomic) IBOutlet UILabel *Title;
@property (weak, nonatomic) IBOutlet UIButton *listenBtn;
@property (weak, nonatomic) IBOutlet UIButton *downLoadBtn;

@property UITableView* tableDelegate;
- (void)setUpUrl:(NSString*)baseUrl path:(NSString *)path fileName:(NSString *)fileName;
-(void)setContent:(VoiceInfo *)info;

+(void)clearPlayer;
@end
