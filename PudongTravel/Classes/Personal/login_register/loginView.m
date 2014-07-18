//
//  loginView.m
//  PudongTravel
//
//  Created by jiangjunli on 14-3-28.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "loginView.h"
#import "RegiterView.h"

@implementation loginView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (IBAction)registerButtonClicked:(id)sender {
    [self.superview addSubview:[[[NSBundle mainBundle] loadNibNamed:@"RegiterView" /*写错了的，将就一下*/
                                                             owner:self
                                                           options:nil] objectAtIndex:0]];
    [self removeFromSuperview];
}
- (IBAction)backBtnClicked:(id)sender {
    [self removeFromSuperview];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
