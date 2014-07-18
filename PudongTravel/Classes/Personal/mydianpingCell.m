//
//  mydianpingCell.m
//  pudongapp
//
//  Created by jiangjunli on 14-2-28.
//  Copyright (c) 2014年 jiangjunli. All rights reserved.
//

#import "mydianpingCell.h"
#import "PictureHelper.h"
@interface mydianpingCell()
@property (weak, nonatomic) IBOutlet UILabel *merchantNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentsLabel;
@property (weak, nonatomic) IBOutlet UIImageView *image1;
@property (weak, nonatomic) IBOutlet UIImageView *image2;
@property (weak, nonatomic) IBOutlet UIImageView *image3;
@property (weak, nonatomic) IBOutlet UILabel *scoreLael;
@property (weak, nonatomic) IBOutlet UILabel *dataLabel;

@end
@implementation mydianpingCell

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
+ (id)cell:(UserCommentListInfo *)info
{
    [[NSBundle mainBundle] loadNibNamed:@"mydianpingCell" owner:nil options:nil] ;
    mydianpingCell *cell        = [[[NSBundle mainBundle] loadNibNamed:@"mydianpingCell" owner:nil options:nil] objectAtIndex:0];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor        = [UIColor clearColor];
    cell.merchantNameLabel.text = [info->merchantName copy];
    cell.contentsLabel.text     = [info->contents copy];
    cell.scoreLael.text         = [NSString stringWithFormat: @"%0.1f分",info->score ];
    cell.dataLabel.text         = [info->date copy];
    

    int i = 0;
    for(NSString *imgUrl1 in info->imgUrl){
        i++;
        if(i == 1){
            [PictureHelper addPicture:imgUrl1 to:cell.image1
                             withSize:CGRectMake(0, 0, 60, 60)];
        }else if(i == 2){
            [PictureHelper addPicture:imgUrl1 to:cell.image2
                             withSize:CGRectMake(0, 0, 60, 60)];
        }else{
            [PictureHelper addPicture:imgUrl1 to:cell.image3
                             withSize:CGRectMake(0, 0, 60, 60)];
        }
    }

    return cell;
   }
@end
