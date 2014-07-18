//
//  OtherTableView.h
//  PudongTravel
//
//  Created by mark on 14-3-27.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NearbyTableData.h"
@interface OtherTableView : PullTableView
@property BOOL inited;
-(void)loadDataFromWeb:(BOOL)more;
@property UINavigationController *navController;
@end
