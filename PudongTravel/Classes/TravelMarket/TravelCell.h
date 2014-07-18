//
//  TravelCell.h
//  pudongapp
//
//  Created by jiangjunli on 14-2-14.
//  Copyright (c) 2014年 jiangjunli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TravelMarketData.h"

@interface TravelCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLength;  //时长

@property (weak, nonatomic) IBOutlet UIImageView *contentImg;


-(void)setContent:(TravelMarketDataInfo *)info;
@end
