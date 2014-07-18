//
//  SafetyVerificationView.h
//  PudongTravel
//
//  Created by jiangjunli on 14-4-3.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SafetyVerificationView : UIView
{
    NSInteger _time;
    
}
@property (strong, nonatomic) NSTimer *timer;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UIImageView *verificationTxtBG;
@property (weak, nonatomic) IBOutlet UIButton *sendValidationCodeButton;
@property (strong,nonatomic) NSString *account;
@property (strong,nonatomic) NSString *password;
@property (strong,nonatomic) NSString *repassword;
@property (strong,nonatomic) NSString *niciname;
@property (strong,nonatomic) NSString *messgaeeror;
@property (weak, nonatomic) IBOutlet UITextField *verificationTextField;
@end
