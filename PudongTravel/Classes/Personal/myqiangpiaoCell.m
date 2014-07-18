//
//  myqiangpiaoCell.m
//  pudongapp
//
//  Created by jiangjunli on 14-2-26.
//  Copyright (c) 2014年 jiangjunli. All rights reserved.
//

#import "myqiangpiaoCell.h"
#import "UserData.h"
#import "HTTPAPIConnection.h"
#import "TicketDetailView.h"
#import "CommonHeader.h"
static NSString * deleteStoreNotification  =  @"deleteCellnotifaction";
@interface myqiangpiaoCell()

@property (weak, nonatomic) IBOutlet UILabel *merNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *ticketNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *validTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@end
@implementation myqiangpiaoCell

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
+ (id)cell:(UserTicktListInfo *)info
{
    myqiangpiaoCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"myqiangpiaoCell" owner:nil options:nil] objectAtIndex:0];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    cell.merNameLabel.text = info->merName;
    cell.ticketNameLabel.text = info->ticketName;
    cell.validTimeLabel.text = info->validTime;
    cell.addressLabel.text = info->address;
    cell.tickid=[info->id copy];
    cell.info = info;
        return cell;
}
-(void)handleDetail{
//    NSString * path = [getTicketDetail copy];
//    path = [path stringByAppendingString:
//            [NSString stringWithFormat:@"?ticketId=%@", self.info->ticketId]];
    
    NSString * path = [getTicketDetail copy];
    path = [path stringByAppendingString:
            [NSString stringWithFormat:@"?inventoryId=%@", self.info->ticketId]];
    [HTTPAPIConnection postPathToGetJson:path block:^(NSDictionary *json, NSError *error)
     {
         if(error || ![json objectForKey:@"info"]){
             //TODO 错误处理
             [AlertViewHandle showAlertViewWithMessage:@"网络异常！"];
             return ;
         }else{
             UserTicktDetailInfo *info = [UserTicktDetailInfo new];
             [info updateWithJsonDic:[json objectForKey:@"info"]];
             //目标，加到RightViewController的view上.
             //包含关系:
             /*
              RightViewController的view<-contentview<-myiangpiao<-tableView<-MyOrderCell
              */
             //从rightviewcontroller中 包含的contentview，
             [self.superview.superview.superview.superview.superview addSubview:[TicketDetailView detail:info]];
         }
     }];
}
- (IBAction)deletebtn:(id)sender {
      [[NSNotificationCenter defaultCenter]   postNotificationName:deleteStoreNotification object:self];
}
@end
