//
//  FestivalCell.m
//  pudongapp
//
//  Created by jiangjunli on 14-2-20.
//  Copyright (c) 2014年 jiangjunli. All rights reserved.
//

#import "FestivalCell.h"
#import "PictureHelper.h"

@interface FestivalCell()
@property (strong, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation FestivalCell

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

-(void)setContent:(FestivalInfo *)info{
    [PictureHelper addPicture:[info->imgUrl copy] to:self.imgView
                     withSize:CGRectMake(0, 0, 320, 160)];
    self.titleLabel.text = [info->title copy];
}
@end
