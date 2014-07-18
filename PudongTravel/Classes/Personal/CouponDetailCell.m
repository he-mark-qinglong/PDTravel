//
//  CouponDetailCell.m
//  PudongTravel
//
//  Created by jiangjunli on 14-4-18.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "CouponDetailCell.h"
#import "CommonHeader.h"
#import "DetailView.h"
static NSString * deleteStoreNotification  =  @"deleteCellnotifaction";

@interface CouponDetailCell()
@property (weak, nonatomic) IBOutlet UILabel *merNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *couponNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *validTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;


@end
@implementation CouponDetailCell

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
+ (id)cell:(UserCouponListInfo *)info;
{
    CouponDetailCell * cell = [[[NSBundle mainBundle] loadNibNamed:@"CouponDetailCell" owner:nil options:nil] objectAtIndex:0];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    cell.merNameLabel.text = info->merName;
    cell.couponNameLabel.text = info->couponName;
    cell.validTimeLabel.text = info->validTime;
    cell.addressLabel.text = info->address;
    cell.couponId = info->id;
    
    return cell;
}
- (IBAction)couponDeleteBtnClick:(id)sender {
}
-(void)handleDetail1
{
    NSMutableString * path1 = [[NSMutableString alloc]initWithString:@"user/couponDetail"];
    NSLog(@"%@",self.couponId);
    
    [path1 appendFormat:@"?couponId=%@", self.couponId];
   // path1 = [path1 stringByAppendingString:
            //[NSString stringWithFormat:@"?couponId=%@", self.info->couponId]];
    [HTTPAPIConnection postPathToGetJson:path1 block:^(NSDictionary *json, NSError *error)
     {
         if(error || ![json objectForKey:@"info"]){
             //TODO 错误处理
             
             return ;
         }else{
             CouponDetailInfo *info = [CouponDetailInfo new];
             [info updateWithJsonDic:[json objectForKey:@"info"]];
             //目标，加到RightViewController的view上.
             //包含关系:
             /*
              RightViewController的view<-contentview<-myiangpiao<-tableView<-MyOrderCell
              */
             //从rightviewcontroller中 包含的contentview，contentview中包含了tabelview
             
             [self.superview.superview.superview.superview.superview addSubview:[DetailView detail:info]];
         }
     }];

}
- (IBAction)deleteclick:(id)sender {
     [[NSNotificationCenter defaultCenter]   postNotificationName:deleteStoreNotification object:self];
}

@end
