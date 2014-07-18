//
//  RegiterView.m
//  PudongTravel
//
//  Created by jiangjunli on 14-3-28.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "RegiterView.h"
#import "SafetyVerificationView.h"
#import "UIImage+loadImage.h"
#import "ValidateUtil.h"
#import "AlertViewHandle.h"
#import "UIView+FrameHandle.h"
#import "ConstLinks.h"
#import "UserData.h"

@interface RegiterView()
@property NSMutableArray *textFields;
@end

@implementation RegiterView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
           }
    return self;
}
//每次进入都会调用
- (void)awakeFromNib{
    self.textFields = [[NSMutableArray alloc ]initWithObjects:self.accountTextField, self.passwordTextField, self.repasswordTextField, self.nickNameTextField, nil];
    for(UITextField *tf in self.textFields){
        tf.delegate = self;
        [self setKeyboardForInputView:(UITextView*)tf];
    }

    [self registKeyboardEventHandler];
}

-(void)registKeyboardEventHandler{
    if (IS_IPHONE5) {
        return;
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasHidden:) name:UIKeyboardDidHideNotification object:nil];
}

-(void)setKeyboardForInputView:(UITextView *)contentView{
    UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    [topView setBarStyle:UIBarStyleBlackTranslucent];
    topView.backgroundColor = [UIColor clearColor];
    
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                              target:self action:nil];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(2, 5, 50, 25);
    [btn addTarget:self action:@selector(dismissKeyBoard) forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[UIImage imageNamed:@"icon_download_activating.png"] forState:UIControlStateNormal];
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc]initWithCustomView:btn];
    
    NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace, doneBtn, nil];
    [topView setItems:buttonsArray];
    [contentView setInputAccessoryView:topView];
}

-(void)dismissKeyBoard{
    for(UITextField *tf in self.textFields){
        [tf resignFirstResponder];
    }
}
- (IBAction)SafetyVerificationBtnClick:(id)sender {
    switch ([ValidateUtil validatePhoneNumber:self.accountTextField.text]) {
       
        case NotMatch: {
            [AlertViewHandle showAlertViewWithMessage:@"手机号码格式错误，请重新输入"];
            return;
            break;
        }
        default:
            break;
    }
    switch ([ValidateUtil validatePassword:self.passwordTextField.text]) {
 
        case NotMatch: {
            [AlertViewHandle showAlertViewWithMessage:@"密码格式错误,请输入6～16位的密码！"];
            return;
            break;
        }
        default:
            break;
    }

    for(UITextField *tf in self.textFields){
        [tf resignFirstResponder];
    }
    
    NSString *path = [NSString stringWithString:(NSString*)regCheck];
    path = [path stringByAppendingString:
            [NSString stringWithFormat:@"?account=%@&passWord=%@&passWordAgain=%@&nickName=%@",self.accountTextField.text,self.passwordTextField.text,self.repasswordTextField.text,self.nickNameTextField.text]];
    NSLog(@"path is %@",path);
    [HTTPAPIConnection postPathToGetJson:path block:^(NSDictionary *json, NSError *error)
     {
         UpdateanicknameData *data = [UpdateanicknameData new];
         [data updateWithJsonDic:json];
         if([data->code isEqualToString:@"74"]){
             [AlertViewHandle showAlertViewWithMessage:@"请输入账号！"];
         }
         else if ([data->code isEqualToString:@"75"]){
             [AlertViewHandle showAlertViewWithMessage:@"请输入密码！"];
         }
         else if ([data->code isEqualToString:@"77"]){
             [AlertViewHandle showAlertViewWithMessage:@"怎么不设置昵称呢！"];
         }
         else if ([data->code isEqualToString:@"80"]){
             [AlertViewHandle showAlertViewWithMessage:@"确认密码为空！"];
         }
         else if ([data->code isEqualToString:@"78"]){
             [AlertViewHandle showAlertViewWithMessage:@"两次输入的密码不一致！"];
         }
         else if ([data->code isEqualToString:@"72"]){
             [AlertViewHandle showAlertViewWithMessage:@"该账号已经被注册！"];
         }
         else if ([data->code isEqualToString:@"71"]){
             self.svv = [[[NSBundle mainBundle] loadNibNamed:@"SafetyVerificationView"
                                                       owner:self
                                                     options:nil] objectAtIndex:0];
             
             self.svv.password   = self.passwordTextField.text;
             self.svv.repassword = self.repasswordTextField.text;
             self.svv.niciname   = self.nickNameTextField.text;
             self.svv.account    = self.accountTextField.text;
             NSLog(@"%@",self.accountTextField.text);
             NSLog(@"%@",self.svv.account);
             
             [self.superview addSubview:self.svv];
         }
         else {
             [AlertViewHandle showAlertViewWithMessage:@"！"];
         }

    } ];
}

- (IBAction)backBtnClicked:(id)sender {
    [self removeFromSuperview];
}
- (IBAction)loginBtnClick:(id)sender {
    self.lv= [[[NSBundle mainBundle] loadNibNamed:@"loginView"
                                            owner:self options:nil] objectAtIndex:0];
    
    [self.superview addSubview:self.lv];
}

- (IBAction)tapGesture:(UITapGestureRecognizer *)sender {
    [self.accountTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [self.repasswordTextField resignFirstResponder];
    [self.nickNameTextField resignFirstResponder];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    switch (textField.tag) {
        case 1: {
            self.accountTxtBG.image = [UIImage imageWithResourceName:@"constituency_s.png"];
            break;
        }
        case 2: {
            self.passwordTxtBG.image = [UIImage imageWithResourceName:@"constituency_s.png"];
            break;
        }
        case 3: {
            self.repasswordTxtBG.image = [UIImage imageWithResourceName:@"constituency_s.png"];
            break;
        }
        case 4: {
            self.nickNameTxtBG.image = [UIImage imageWithResourceName:@"constituency_s.png"];
            break;
        }
 
        default:
            break;
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    switch (textField.tag) {
        case 1: {
            self.accountTxtBG.image = [UIImage imageWithResourceName:@"constituency.png"];
            break;
        }
        case 2: {
            self.passwordTxtBG.image = [UIImage imageWithResourceName:@"constituency.png"];
            break;
        }
        case 3: {
            self.repasswordTxtBG.image = [UIImage imageWithResourceName:@"constituency.png"];
            break;
        }
        case 4: {
            self.nickNameTxtBG.image = [UIImage imageWithResourceName:@"constituency.png"];
            break;
        }
        default:
            break;
    }
}
-(void)dealloc{
    self.accountTextField.delegate = nil;
    self.passwordTextField.delegate = nil;
    self.repasswordTextField.delegate = nil;
    self.nickNameTextField.delegate = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void) keyboardWasShown:(NSNotification *) notif{
    NSDictionary *info = [notif userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    
    NSLog(@"keyBoard:%f", keyboardSize.height);  //216
    ///keyboardWasShown = YES;
    [UIView animateWithDuration:0.1f animations:^{
        self.contentView.originY = -80.f;
    }];
}
- (void) keyboardWasHidden:(NSNotification *) notif{
    NSDictionary *info = [notif userInfo];
    
    NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    NSLog(@"keyboardWasHidden keyBoard:%f", keyboardSize.height);
    [UIView animateWithDuration:0.1f animations:^{
        self.contentView.originY = 0.f;
    }];
}
@end
