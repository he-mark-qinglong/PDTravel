//
//  TicketBookViewController.h
//  pudongapp
//
//  Created by jiangjunli on 14-2-19.
//  Copyright (c) 2014年 jiangjunli. All rights reserved.
//

#import <UIKit/UIKit.h>

enum OderType{
    EMarketOrder,
    EViewOrder
};

@interface TicketBookViewController : UIViewController
@property NSString *marketId;
@property enum OderType orderType;
@end
