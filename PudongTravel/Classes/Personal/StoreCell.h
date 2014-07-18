//
//  StoreCell.h
//  PudongTravel
//
//  Created by jiangjunli on 14-4-17.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserData.h"

static NSString * deleteStoreNotification  =  @"deleteCellnotifaction";

@interface StoreCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *phone;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (strong,nonatomic) NSString *storeid;
+ (id)cell:(UserStoreListInfo *)info;

-(void)handleDetail;
@end
