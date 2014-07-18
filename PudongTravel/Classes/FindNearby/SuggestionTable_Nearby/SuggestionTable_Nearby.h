//
//  SuggestionTable_Nearby.h
//  PudongTravel
//
//  Created by mark on 14-3-27.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NearbyTableData.h"
#import "FoodViewController.h"

@interface SuggestionTable_Nearby : NearbyTableData<WebData>
@property UINavigationController *navController;

@property BOOL inited;

@property enum VCType vctype;
@end

