//
//  loginView.h
//  PudongTravel
//
//  Created by jiangjunli on 14-3-28.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface loginView : UIView<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIImageView *accounttTxtBG;
@property (weak, nonatomic) IBOutlet UIImageView *passwordTxtBG;
@property (strong, nonatomic)NSString *nickname;
@property (strong, nonatomic)NSString *username;
@property (strong, nonatomic)NSString *commoncnt;
@property (strong, nonatomic)NSString *stroecnt;

//@property BOOL isLoginSuccess;
@end
