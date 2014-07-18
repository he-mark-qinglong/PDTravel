//
//  PictureTableView.h
//  PudongTravel
//
//  Created by mark on 14-4-4.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "PullTableView.h"

@interface PictureTableView : PullTableView
-(void)loadDataFromWeb:(BOOL)more;
@property (strong, nonatomic) NSString *path;
@property (strong, nonatomic) UIViewController *viewController;
@property BOOL isLeftViewDifferent;
@property NSString *pathId;

@end
