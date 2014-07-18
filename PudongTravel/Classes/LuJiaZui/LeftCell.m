//
//  LeftCell.m
//  PudongTravel
//
//  Created by jiangjunli on 14-4-2.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "LeftCell.h"
#import "LujiazuiData.h"
#import "PictureHelper.h"
#import "ScenicSpotViewController.h"

@interface LeftCell ()
@property (strong, nonatomic) LujiazuiOneViewData *data;

@property (weak, nonatomic) IBOutlet UIImageView *img1;
@property (weak, nonatomic) IBOutlet UIImageView *img2;
@property (weak, nonatomic) IBOutlet UIImageView *img3;
@property (weak, nonatomic) IBOutlet UIImageView *img4;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;


@property (weak, nonatomic) IBOutlet UILabel *title1;
@property (weak, nonatomic) IBOutlet UILabel *title2;
@property (weak, nonatomic) IBOutlet UILabel *title3;
@property (weak, nonatomic) IBOutlet UILabel *title4;


@end

@implementation LeftCell

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
-(void) setContent:(LujiazuiOneViewData*)data row:(int)row{
    self.data = data;
    
    int arrayCount = [data->arrayLujiazuiOneViewInfo count];
    if(arrayCount == 0)  return;
    
    NSArray *arrayImg = [[NSArray alloc] initWithObjects:self.img1, self.img2, self.img3, self.img4, nil];
    NSArray *arrayTitle = [[NSArray alloc] initWithObjects:self.title1, self.title2, self.title3, self.title4, nil];
    
    NSArray *arrayLabel = [[NSArray alloc]initWithObjects:self.label1,self.label2,self.label3,self.label4, nil];
    for(int i = 0; i < arrayCount; ++i){
        LujiazuiOneViewInfo *item = ([data->arrayLujiazuiOneViewInfo objectAtIndex:i]);
      //  NSLog(@"index= %d, imgUrl = %@", i, item->imgUrl);
        [PictureHelper addPicture:item->imgUrl
                               to:[arrayImg objectAtIndex:i]
                         withSize:CGRectMake(0, 0, 140, 120)];
        UILabel *title = [arrayTitle objectAtIndex:i];
        title.text = item->title;
        
        UILabel *label = [arrayLabel objectAtIndex:i];
        int number= label.tag;
        NSString *labelName =[NSString stringWithFormat:@"NO.%d",(4*row + number)];
       // NSLog(@"%@",labelName);
        label.text =labelName;
    }
}

- (IBAction)onBtnClicked:(id)sender {
    UIButton *button =  (UIButton *)sender;
    NSString *imgId;
    
    for(int i = 1; i < 5; i++){
        if(button.tag == i){
            LujiazuiOneViewInfo *imgInfo = [self.data->arrayLujiazuiOneViewInfo objectAtIndex:(i-1)];
            if(imgInfo == nil)
                break;
            NSString *id = imgInfo->id;
            NSLog(@"id = %@", id);
            imgId = id;
            break;
        }
    }
    ScenicSpotViewController *ssvc = [[ScenicSpotViewController alloc]init];
    ssvc.idStr = [imgId copy];
    
    [self.viewController.navigationController  pushViewController:ssvc animated:YES];
}

@end
