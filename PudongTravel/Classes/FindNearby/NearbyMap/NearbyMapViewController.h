//
//  NearbyMapViewController.h
//  PudongTravel
//
//  Created by mark on 14-3-28.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaiDuMapManager.h"
#import "BDMapBaseViewController.h"

#import "NearbyViewController.h"

enum SearchType{
    ETransitSearch = 1,
    EDriveSearch
};
@interface NearbyMapViewController : BDMapBaseViewController
{
    NearbyViewController *nvc;
}

@property BOOL willShowUserLocation;
- (IBAction)onBottomBtnClicked:(id)sender;
- (void)setMapAreaWithCenter:(CLLocationCoordinate2D)center
                   withTitle:(NSString *)title
            withUserPosition:(BOOL)y_n;
-(void)showSevenPop;
@end
