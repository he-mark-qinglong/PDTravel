//
//  DiscountCell.h
//  PudongTravel
//
//  Created by jiangjunli on 14-4-1.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TravelMarketData.h"

@interface DiscountCell : UITableViewCell
-(void)setCellWithCoupon:(TravelDetailCoupon*)coupon;
@end
