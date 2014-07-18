//
//  TravelCell.m
//  pudongapp
//
//  Created by jiangjunli on 14-2-14.
//  Copyright (c) 2014年 jiangjunli. All rights reserved.
//

#import "TravelCell.h"
#import "TicketBookViewController.h"
#import "TravelMarketData.h"
#import "PictureHelper.h"

@interface TravelCell()
@property (weak, nonatomic) IBOutlet UIImageView *tag1;
@property (weak, nonatomic) IBOutlet UIImageView *tag2;
@property (weak, nonatomic) IBOutlet UIImageView *tag3;
@property (weak, nonatomic) IBOutlet UIImageView *tag4;
@property (weak, nonatomic) IBOutlet UIImageView *tag5;
@property (weak, nonatomic) IBOutlet UIImageView *tag6;
@property (weak, nonatomic) IBOutlet UIImageView *tag7;
@property (weak, nonatomic) IBOutlet UIImageView *tag8;

@property (weak, nonatomic) IBOutlet UILabel *tagLabel1;
@property (weak, nonatomic) IBOutlet UILabel *tagLabel2;
@property (weak, nonatomic) IBOutlet UILabel *tagLabel3;
@property (weak, nonatomic) IBOutlet UILabel *tagLabel4;
@property (weak, nonatomic) IBOutlet UILabel *tagLabel5;
@property (weak, nonatomic) IBOutlet UILabel *tagLabel6;
@property (weak, nonatomic) IBOutlet UILabel *tagLabel7;
@property (weak, nonatomic) IBOutlet UILabel *tagLabel8;

@property (strong, nonatomic) NSArray *tags;
@property (strong, nonatomic) NSMutableArray *tagArray;
@property (strong, nonatomic) NSMutableArray *tagLabelArray;
@end

@implementation TravelCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
            }
    return self;
}

-(void)setContent:(TravelMarketDataInfo *)info{
    
    //耦合，两个都是8个元素的，元素的树木不可以不一致，否则超过8个时可能引起UI出错
    if(_tagArray  == nil)
        _tagArray = [[NSMutableArray alloc]
                         initWithObjects:_tag1, _tag2, _tag3, _tag4, _tag5, _tag6, _tag7, _tag8, nil];
    if(_tagLabelArray == nil)
        _tagLabelArray = [[NSMutableArray alloc]
                          initWithObjects:_tagLabel1, _tagLabel2, _tagLabel3, _tagLabel4,
                          _tagLabel5, _tagLabel6, _tagLabel7, _tagLabel8, nil];
    
    self.title.text = info->title;
    self.priceLabel.text = [info-> price stringByAppendingString:@"元"];
    self.timeLength.text = [info-> travelTime stringByAppendingString:@"天"];
    [PictureHelper addPicture:info->imgUrl to:self.contentImg withSize:CGRectMake(0, 0, 60, 60)];
    self.tags = [info->tags copy];
    
    void (^hideImgAndLabel)(int i, BOOL yn) = ^(int i, BOOL yn){
        UIImageView *aTag = [_tagArray objectAtIndex:i];
        UILabel *aLabel = [_tagLabelArray objectAtIndex:i];
        if(yn == NO){  //这里的i时数组索引，这个判断不能去掉，否则可能引起数组越界访问
            aLabel.text = [self.tags objectAtIndex:i];
        }
        aTag.hidden = yn;
        aLabel.hidden = yn;
    };
    
    int labelAndViewCnt = [self.tagArray count];  //8
    int tagCount = self.tags.count;
    int i = 0;
    for (; i < labelAndViewCnt && i < tagCount; ++i){
        hideImgAndLabel(i, NO);
    }
    for(; i < labelAndViewCnt; ++i){
        hideImgAndLabel(i, YES);
    }
}
@end
