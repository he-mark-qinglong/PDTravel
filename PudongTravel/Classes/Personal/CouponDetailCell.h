//
//  CouponDetailCell.h
//  PudongTravel
//
//  Created by jiangjunli on 14-4-18.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserData.h"


@interface CouponDetailCell : UITableViewCell
@property (strong,nonatomic) NSString *couponId;
-(void)handleDetail1;
+(id)cell:(UserCouponListInfo *)info;
@property UserCouponListInfo *info;
@end
