//
//  MyOrderCell.m
//  PudongTravel
//
//  Created by jiangjunli on 14-4-18.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "MyOrderCell.h"
#import "CommonHeader.h"
#import "OrderDetailView.h"

@interface MyOrderCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *dataLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@end
@implementation MyOrderCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (id)cell:(UserOrderListInfo *)info
{
    MyOrderCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"MyOrderCell" owner:nil options:nil] objectAtIndex:0];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    cell.backgroundColor = [UIColor clearColor];
    cell.titleLabel.text = info->title;
    cell.orderNumLabel.text = info->orderNum;
    cell.dataLabel.text = info->date;
    cell.addressLabel.text = info->address;
    cell.info = info;
    
 return cell;
}

-(void)handleDetail
{
    NSString * path = [userOrderDetail copy];
    path = [path stringByAppendingString:
            [NSString stringWithFormat:@"?marketId=%@", self.info->marketId]];
    [HTTPAPIConnection postPathToGetJson:path block:^(NSDictionary *json, NSError *error)
     {
         if(error || ![json objectForKey:@"info"]){
             //TODO 错误处理
             
             return ;
         }else{
             UserOrderDetailInfo *info = [UserOrderDetailInfo new];
             [info updateWithJsonDic:[json objectForKey:@"info"]];
             //目标，加到RightViewController的view上.
             //包含关系:
             /*
              RightViewController的view<-contentview<-myiangpiao<-tableView<-MyOrderCell
              */
             //从rightviewcontroller中 包含的contentview，contentview中包含了tabelview
             
             [self.superview.superview.superview.superview.superview addSubview:[OrderDetailView detail:info]];
         }
     }];
}
@end
