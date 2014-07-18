//
//  dianpingCell.m
//  pudongapp
//
//  Created by jiangjunli on 14-2-21.
//  Copyright (c) 2014年 jiangjunli. All rights reserved.
//

#import "dianpingCell.h"
#import "CommonHeader.h"

@implementation dianpingCell

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

-(void)setContent:(CommentInfo *)info{
    self.selectionStyle = UITableViewCellSelectionStyleNone;//设置选择cell的颜色
    self.backgroundColor = [UIColor clearColor];

    self.usernamelabel.text = info->nickName;
    self.contenlabel.text = info->contents;
    self.time.text = [NSString stringWithFormat:@"发表于 %@", info->time ];
    self.score.text = [NSString stringWithFormat:@"%.1f 分", info->score];
    
    [PictureHelper addPicture:info->headImg to:self.userimage
                     withSize:CGRectMake(0, 0, 44, 44)];
    int i = 0;
    for(NSString *imgUrl in info->commentImg){
        i++;
        if(i == 1){
            [PictureHelper addPicture:imgUrl to:self.imageview1
                             withSize:CGRectMake(0, 0, 40, 40)];
        }else if(i == 2){
            [PictureHelper addPicture:imgUrl to:self.imageview2
                             withSize:CGRectMake(0, 0, 40, 40)];
        }else{
            [PictureHelper addPicture:imgUrl to:self.imageview3
                             withSize:CGRectMake(0, 0, 40, 40)];
        }
    }

    self.imageview1.userInteractionEnabled = YES;
    self.imageview2.userInteractionEnabled = YES;
    self.imageview3.userInteractionEnabled = YES;
    self.imageview1.multipleTouchEnabled = YES;
    self.imageview2.multipleTouchEnabled = YES;
    self.imageview3.multipleTouchEnabled = YES;
    
}
@end
