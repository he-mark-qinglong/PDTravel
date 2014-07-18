//
//  OtherTable_Nearby.h
//  PudongTravel
//
//  Created by mark on 14-3-27.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NearbyTableData.h"
#import "FoodViewController.h"

@interface OtherTable_Nearby : NearbyTableData<WebData>
@property UINavigationController *navController;
@property BOOL inited;
@property BOOL isPush;  // 左右两个表的标识，用于获取数据的时候做区分
@property enum VCType vctype;
@end
