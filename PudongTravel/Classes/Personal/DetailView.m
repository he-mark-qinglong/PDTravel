//
//  DetailView.m
//  PudongTravel
//
//  Created by jiangjunli on 14-4-23.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "DetailView.h"
#import "CommonHeader.h"
@interface DetailView()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *merNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *couponNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *validTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@property (weak, nonatomic) IBOutlet UIWebView *remarkWebView;

@end
@implementation DetailView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
+ (id)detail:(CouponDetailInfo *)info
{
    
    DetailView *detail = [[[NSBundle mainBundle] loadNibNamed:@"DetailView" owner:nil options:nil] objectAtIndex:0];
    detail.titleLabel.text = [info->merName copy];
    detail.merNameLabel.text = [info->merName copy];
    detail.couponNameLabel.text = [info->couponName copy];
    detail.validTimeLabel.text = [info->validTime copy];
    detail.addressLabel.text = [info->address copy];
    //detail.remarkTxt.text = [info->remark copy];
    
    
    NSString *htmlStr =  [NSString stringWithFormat:@"<html> \n"
                          "<head> \n"
                          "<style type=\"text/css\"> \n"
                          "body {font-size: %@; color: %@;}\n"
                          "</style> \n"
                          "</head> \n"
                          "<body>%@</body> \n"
                          "</html>",@"13", @"white", info->remark ];
    [detail.remarkWebView loadHTMLString:htmlStr baseURL:nil];
    return detail;
}
- (IBAction)colseBtnClick:(id)sender { [self removeFromSuperview];
}


@end
