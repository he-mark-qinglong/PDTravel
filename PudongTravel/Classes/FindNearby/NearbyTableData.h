//
//  NearbyTableData.h
//  PudongTravel
//
//  Created by mark on 14-3-27.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "PullTableView.h"

#import "CommonHeader.h"
#import "NearbyData.h"

@protocol WebData<NSObject>
@required
-(void)loadDataFromWeb:(BOOL)more;

@property (strong, nonatomic) NSMutableArray *arrayToShow;
@property NSInteger pageNo;

@end

@interface NearbyTableData :PullTableView

@end