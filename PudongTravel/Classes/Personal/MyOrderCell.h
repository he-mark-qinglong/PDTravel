//
//  MyOrderCell.h
//  PudongTravel
//
//  Created by jiangjunli on 14-4-18.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserData.h"

@interface MyOrderCell : UITableViewCell
-(void)handleDetail;

+ (id)cell:(UserOrderListInfo *)info;
@property UserOrderListInfo *info;
@end

