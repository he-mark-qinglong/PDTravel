//
//  LeftCell.h
//  PudongTravel
//
//  Created by jiangjunli on 14-4-2.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LujiazuiData.h"

@interface LeftCell : UITableViewCell
-(void) setContent:(LujiazuiOneViewData*)data row:(int)row;
@property (strong, nonatomic) UIViewController *viewController;
@end
