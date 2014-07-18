//
//  myqiangpiao.h
//  pudongapp
//
//  Created by jiangjunli on 14-2-26.
//  Copyright (c) 2014年 jiangjunli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserData.h"
#import "PullTableView.h"
typedef enum
{
    //以下是枚举成员
    EStoreCell = 1,
    ECommentCell,
    ECouponDetailCell,
    EOrderCell,
    ETicketCell,
    EVoiceCell,
    ESetingCell
}Type;//枚举名称
@interface myqiangpiao : UIView<UITableViewDelegate, UITableViewDataSource, PullTableViewDelegate>
{
}
@property (weak, nonatomic) IBOutlet PullTableView *tablelview;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property Type cellType;
////@property (strong, nonatomic) NSMutableArray *infoArray;
@property NSInteger pageNo;
//@property (strong, nonatomic) UserStoreListData *data;
@property (strong, nonatomic) NSMutableArray *arrayToShow;
@property (strong, nonatomic) NSMutableArray *arrayDetail;
@end
