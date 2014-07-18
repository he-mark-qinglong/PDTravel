//
//  dianpingCell.h
//  pudongapp
//
//  Created by jiangjunli on 14-2-21.
//  Copyright (c) 2014年 jiangjunli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ElseMainViewData.h"

@interface dianpingCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *contenlabel;
@property (weak, nonatomic) IBOutlet UILabel *usernamelabel;
@property (weak, nonatomic) IBOutlet UILabel *score;
@property (weak, nonatomic) IBOutlet UILabel *time;

@property (weak, nonatomic) IBOutlet UIImageView *imageview1;
@property (weak, nonatomic) IBOutlet UIImageView *imageview2;
@property (weak, nonatomic) IBOutlet UIImageView *imageview3;

@property (weak, nonatomic) IBOutlet UIImageView *userimage;


-(void)setContent:(CommentInfo *)info;
@end
