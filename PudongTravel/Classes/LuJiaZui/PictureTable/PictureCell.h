//
//  PictureCell.h
//  PudongTravel
//
//  Created by mark on 14-4-4.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LujiazuiData.h"

@interface PictureCell : UITableViewCell
-(void) setContent:(LujiazuiData*)data;
@property (strong, nonatomic) UIViewController *viewController;
@end