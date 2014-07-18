//
//  SuggestionTable.h
//  PudongTravel
//
//  Created by mark on 14-3-27.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullTableView.h"

@interface SuggestionTable :  PullTableView
-(void)loadDataFromWeb:(BOOL)more;
@property BOOL inited;
@property UINavigationController *navController;

@end
