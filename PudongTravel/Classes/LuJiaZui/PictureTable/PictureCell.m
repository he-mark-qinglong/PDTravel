//
//  PictureCell.m
//  PudongTravel
//
//  Created by mark on 14-4-4.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "PictureCell.h"
#import "PictureHelper.h"
#import "ScenicSpotViewController.h"

@interface PictureCell()

@property (strong, nonatomic) LujiazuiData *data;
@property (weak, nonatomic) IBOutlet UIImageView *bigImg;
@property (weak, nonatomic) IBOutlet UIImageView *img1;
@property (weak, nonatomic) IBOutlet UIImageView *img2;
@property (weak, nonatomic) IBOutlet UIImageView *img3;
@property (weak, nonatomic) IBOutlet UIImageView *img4;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;
@property (weak, nonatomic) IBOutlet UILabel *label5;

@end

@implementation PictureCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (IBAction)btnsClicked:(id)sender {
    NSString *imgId;
    UIButton *button =  (UIButton *)sender;
    if(button.tag == 0){
        NSString *id = self.data->bigImg->id;
        NSLog(@"id = %@", id);
        imgId = id;
    }else{
        for(int i = 1; i < 5; i++){
            if(button.tag == i){
                SmallImg *smallImg = [self.data->arraySmallImg objectAtIndex:(i-1)];
                if(smallImg == nil)
                    break;
                NSString *id = smallImg->id;
                NSLog(@"id = %@", id);
                imgId = id;
                break;
            }
        }
    }
    
    ScenicSpotViewController *ssvc = [[ScenicSpotViewController alloc]init];
    ssvc.idStr = [imgId copy];
    
    [self.viewController.navigationController  pushViewController:ssvc animated:YES];
    ssvc.merchantOrSceneTitleText = @"商户信息";
}

-(void) setContent:(LujiazuiData*)data{
    self.data = data;
    
    [PictureHelper addPicture:data->bigImg->imgUrl to:self.bigImg];
    self.label1.text = data->bigImg->title;
    int arrayCount = [data->arraySmallImg count];
    if(arrayCount == 0)  return;
    
    SmallImg *img = (SmallImg*)([data->arraySmallImg objectAtIndex:0]);
    [PictureHelper addPicture:img->imgUrl to:self.img1 withSize:CGRectMake(0, 0, 140, 120)];
    self.label2.text = img->title;

    if(arrayCount == 1)  return;
    
    img = [data->arraySmallImg objectAtIndex:1];
    [PictureHelper addPicture:img->imgUrl to:self.img2 withSize:CGRectMake(0, 0, 140, 120)];
     self.label3.text = img->title;
    if(arrayCount == 2)  return;
    
    img = [data->arraySmallImg objectAtIndex:2];
    [PictureHelper addPicture:img->imgUrl to:self.img3 withSize:CGRectMake(0, 0, 140, 120)];
     self.label4.text = img->title;
    if(arrayCount == 3)  return;
    
    img = [data->arraySmallImg objectAtIndex:3];
    [PictureHelper addPicture:img->imgUrl to:self.img4 withSize:CGRectMake(0, 0, 140, 120)];
     self.label5.text = img->title;

}
@end
