//
//  FoodCell.m
//  pudongapp
//
//  Created by jiangjunli on 14-2-14.
//  Copyright (c) 2014年 jiangjunli. All rights reserved.
//

#import "FoodCell.h"
#import "PictureHelper.h"


@implementation FoodCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setContentWith:(ElseSceneInfo *)info{
    self.selectionStyle = UITableViewCellSelectionStyleNone;//设置选择cell的颜色
    self.backgroundColor = [UIColor clearColor];
    
    self.name.text = info->title;
    self.time.text = info->busTime;
    self.address.text = info->address;
    self.iphonenumber.text = info->phone;
    
    self.score.text = [NSString stringWithFormat:@"%.1f 分", info->score ];
    float dis = 0;
    //服务器返回数据有差异，这是一个BUG，为了兼容性和适应服务器做了分支处理，只用其中不为0得距离数据
    if(info->distance == 0)
        dis = info->distince ;
    else
        dis = info->distance;
    
    if(dis >= 1000*1000){
        self.distince.text = @">1000km";
    }else{
        if(dis > 1000){
            float distanceInkiloMeters = dis / 1000;
            self.distince.text = [NSString stringWithFormat:@"%0.1fkm",distanceInkiloMeters];
        }else{
            self.distince.text = [NSString stringWithFormat:@"%0.1fm", dis];
        }
    }
    [PictureHelper addPicture:info->imgUrl to:self.image withSize:CGRectMake(0, 0, 64, 64)];
}
@end
