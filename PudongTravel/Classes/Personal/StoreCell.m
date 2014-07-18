//
//  StoreCell.m
//  PudongTravel
//
//  Created by jiangjunli on 14-4-17.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "StoreCell.h"
#import "CommonHeader.h"
#import "ScenicSpotViewController.h"

@interface StoreCell()
@property (weak, nonatomic) IBOutlet UILabel *StoreTitlelabel;
@property (weak, nonatomic) IBOutlet UILabel *DateLabel;
@property (weak, nonatomic) IBOutlet UILabel *PhoneLabel;

@property (weak, nonatomic) IBOutlet UILabel *AddressLabel;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;

@property UserStoreListInfo *info;
@end
@implementation StoreCell

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
+ (id)cell:(UserStoreListInfo *)info
{
    StoreCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"StoreCell" owner:nil options:nil] objectAtIndex:0];
    cell.info = info;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.StoreTitlelabel.text = [info->storeTitle copy];
    cell.DateLabel.text = [info->date copy];
    cell.PhoneLabel.text = [info->phone copy];
    cell.AddressLabel.text = [info->address copy];
    cell.storeid=[info->id copy];
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.backgroundColor = [UIColor clearColor];
   
    return cell;
}
- (IBAction)deleteButtonClick
{
    [[NSNotificationCenter defaultCenter]   postNotificationName:deleteStoreNotification object:self];
}
    
    
-(void)handleDetail{
    DDMenuController *ddMenuController = [(AppDelegate *)[UIApplication sharedApplication].delegate menuController];
    UINavigationController *navigationController = (UINavigationController*)ddMenuController.rootViewController;
    
    ScenicSpotViewController *scenic = [ScenicSpotViewController new];
    scenic.idStr = self.info->storeId;
    [navigationController pushViewController:scenic animated:NO];
    
    [AppDelegate showMiddle];
}

@end
