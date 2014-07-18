//
//  TicketDetailView.m
//  PudongTravel
//
//  Created by jiangjunli on 14-4-24.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "TicketDetailView.h"

@interface TicketDetailView ()
@property (weak, nonatomic) IBOutlet UILabel *merNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ticketNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *validTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@property (weak, nonatomic) IBOutlet UIWebView *remarkWebView;

@end
@implementation TicketDetailView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+ (id)detail:(UserTicktDetailInfo *)info
{
      TicketDetailView *detail = [[[NSBundle mainBundle] loadNibNamed:@"TicketDetailView" owner:nil options:nil] objectAtIndex:0];
    detail.merNameLabel.text = [info->merName copy];
    detail.ticketNameLabel.text = [info->ticketName copy];
    detail.validTimeLabel.text = [info->validTime copy];
    detail.phoneLabel.text = [info->phone copy];
    detail.addressLabel.text = [info->address copy];
//    detail.remarkTxt.text= [info->remark copy];
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
- (IBAction)closeBtnClick:(id)sender {
    [self removeFromSuperview];
}

@end
