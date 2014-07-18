//
//  RegiterView.h
//  PudongTravel
//
//  Created by jiangjunli on 14-3-28.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SafetyVerificationView.h"
#import "loginView.h"
@interface RegiterView : UIView<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet UITextField *accountTextField;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *repasswordTextField;
@property (weak, nonatomic) IBOutlet UIImageView *passwordTxtBG;
@property (weak, nonatomic) IBOutlet UITextField *nickNameTextField;
@property (weak, nonatomic) IBOutlet UIImageView *accountTxtBG;
@property (weak, nonatomic) IBOutlet UIImageView *repasswordTxtBG;
@property (weak, nonatomic) IBOutlet UIImageView *nickNameTxtBG;
@property (strong, nonatomic) SafetyVerificationView *svv;

@property (strong,nonatomic)loginView *lv;
@end
