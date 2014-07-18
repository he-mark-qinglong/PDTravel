//
//  DiscountCell.m
//  PudongTravel
//
//  Created by jiangjunli on 14-4-1.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "DiscountCell.h"
#import "PictureHelper.h"

@interface DiscountCell()
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *couponName;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *remark;
@property (weak, nonatomic) IBOutlet UIWebView *remarkWebView;

@end

@implementation DiscountCell

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

-(void)setCellWithCoupon:(TravelDetailCoupon*)coupon{
    [PictureHelper addPicture:coupon->imgUrl to:self.image withSize:CGRectMake(0, 0, 60, 60)];
    self.couponName.text = coupon->couponName;
    self.price.text = coupon->price;
    

    NSString *htmlStr =  [NSString stringWithFormat:@"<html> \n"
                          "<head> \n"
                          "<style type=\"text/css\"> \n"
                          "body {font-size: %@; color: %@;}\n"
                          "</style> \n"
                          "</head> \n"
                          "<body>%@</body> \n"
                          "</html>",@"13", @"white", coupon->remark ];
    [self.remarkWebView loadHTMLString:htmlStr baseURL:nil];
    
    NSLog(@"%@", coupon->remark);
    self.remark.text = coupon->remark;
}
@end
