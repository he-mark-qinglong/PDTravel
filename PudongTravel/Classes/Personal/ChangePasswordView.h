//
//  ChangePasswordView.h
//  PudongTravel
//
//  Created by jiangjunli on 14-4-3.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangePasswordView : UIView<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *NowPassWordTextField;
@property (weak, nonatomic) IBOutlet UITextField *NewPassWordTextField;
@property (weak, nonatomic) IBOutlet UITextField *AgainPassWordTextField;
@property (weak, nonatomic) IBOutlet UIImageView *NowPassWordTxtBG;
@property (weak, nonatomic) IBOutlet UIImageView *NewPassWordTxtBG;
@property (weak, nonatomic) IBOutlet UIImageView *AgainPassWordTxtBG;
@property (strong, nonatomic)NSString *userID;
@end
