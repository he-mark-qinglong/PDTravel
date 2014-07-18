//
//  myqiangpiaoCell.h
//  pudongapp
//
//  Created by jiangjunli on 14-2-26.
//  Copyright (c) 2014年 jiangjunli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserData.h"
static NSString * deleteTicktNotification  =  @"deleteTicktCellnotifaction";
@interface myqiangpiaoCell : UITableViewCell
@property (strong,nonatomic) NSString *tickid;
-(void)handleDetail;
+(id)cell:(UserTicktListInfo *)info;
@property UserTicktListInfo *info;
@end
