//
//  OrderDetailView.m
//  PudongTravel
//
//  Created by jiangjunli on 14-4-24.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "OrderDetailView.h"

@interface OrderDetailView()
@property (weak, nonatomic) IBOutlet UILabel *ticketnameLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *marketTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *validTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UITextView *introductionTxt;

@property (weak, nonatomic) IBOutlet UIWebView *remarkWebView;

@end
@implementation OrderDetailView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
+ (id)detail:(UserOrderDetailInfo *)info
{
    
    OrderDetailView *detail = [[[NSBundle mainBundle] loadNibNamed:@"OrderDetailView" owner:nil options:nil] objectAtIndex:0];
    detail.ticketnameLabel.text = [info->title copy];
    detail.titleLabel.text = [info->title copy];
    detail.marketTypeLabel.text = [info->marketType copy];
    detail.validTimeLabel.text = [info->validTime copy];
    detail.phoneLabel.text = [info->phone copy];
    detail.addressLabel.text = [info->address copy];
    detail.introductionTxt.text = [info->introduction copy];
//    detail.remakTxt.text = [info->remark copy];
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

- (IBAction)colseBtnClick:(id)sender {
    [self removeFromSuperview];
}

@end
