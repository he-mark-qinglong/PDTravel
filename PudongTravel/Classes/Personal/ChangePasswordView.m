//
//  ChangePasswordView.m
//  PudongTravel
//
//  Created by jiangjunli on 14-4-3.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "ChangePasswordView.h"
#import "UIImage+loadImage.h"
#import "LocalCache.h"
#import "User.h"
#import "HTTPAPIConnection.h"
#import "ConstLinks.h"
#import "UserData.h"
#import "AlertViewHandle.h"
#import "MyMD5.h"
#import "ValidateUtil.h"
@implementation ChangePasswordView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    
    self.NowPassWordTextField.delegate = self;
    self.NewPassWordTextField.delegate = self;
    self.AgainPassWordTextField.delegate = self;
    [self.NowPassWordTextField setSecureTextEntry:YES];
    [self.NewPassWordTextField setSecureTextEntry:YES];
    [self.AgainPassWordTextField setSecureTextEntry:YES];
    
}

- (IBAction)UpdateBtnClick:(id)sender {
    switch ([ValidateUtil validatePassword:self.NowPassWordTextField.text]) {
        case Empty: {
            [AlertViewHandle showAlertViewWithMessage:@"密码不能为空！"];
            return;
            break;
        }
        case NotMatch: {
            [AlertViewHandle showAlertViewWithMessage:@"密码格式错误,请输入6～16位的密码！"];
            return;
            break;
        }
        default:
            break;
    }
    switch ([ValidateUtil validatePassword:self.NewPassWordTextField.text]) {
        case Empty: {
            [AlertViewHandle showAlertViewWithMessage:@"密码不能为空！"];
            return;
            break;
        }
        case NotMatch: {
            [AlertViewHandle showAlertViewWithMessage:@"密码格式错误,请输入6～16位的密码！"];
            return;
            break;
        }
        default:
            break;
    }
    switch ([ValidateUtil validatePassword:self.AgainPassWordTextField.text]) {
        case Empty: {
            [AlertViewHandle showAlertViewWithMessage:@"密码不能为空！"];
            return;
            break;
        }
        case NotMatch: {
            [AlertViewHandle showAlertViewWithMessage:@"密码格式错误,请输入6～16位的密码！"];
            return;
            break;
        }
        default:
            break;
    }

    User *user = [[LocalCache sharedCache] cachedObjectForKey:@"user"];
    self.userID=user.userId;
    NSString *pasword = [self.NewPassWordTextField.text
                          stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

    NSString *path = [NSString stringWithString:(NSString*)updatePassWord];

    path = [path stringByAppendingString:
            [NSString stringWithFormat:@"?userId=%@&nowPassWord=%@&newPassWord=%@&againPassWord=%@",self.userID,self.NowPassWordTextField.text,self.NewPassWordTextField.text,self.AgainPassWordTextField.text]];
    NSLog(@"path is %@",path);
    [HTTPAPIConnection postPathToGetJson:path block:^(NSDictionary *json, NSError *error)
    {
        UserData *data = [UserData new];
        [data updateWithJsonDic:json];
        if ([data->code isEqualToString:@"71"]) {
            [AlertViewHandle showAlertViewWithMessage:@"修改成功！"];
            User * user =  [[LocalCache sharedCache] cachedObjectForKey:@"user"];
            user.password = pasword;
            [[LocalCache sharedCache] storeCacheObject:user forKey:@"user"];

        }
        else if([data->code isEqualToString:@"78"])
        {
             [AlertViewHandle showAlertViewWithMessage:@"新密码两次输入不正确！"];
        }
        else{
            [AlertViewHandle showAlertViewWithMessage:@" 修改失败！"];
        }
    }
     ];
    
}
- (IBAction)backBtnClick:(id)sender {
    [self removeFromSuperview];
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    switch (textField.tag) {
        case 1: {
            self.NowPassWordTxtBG.image = [UIImage imageWithResourceName:@"constituency_s.png"];
            break;
        }
        case 2: {
            self.NewPassWordTxtBG.image = [UIImage imageWithResourceName:@"constituency_s.png"];
            break;
        }
        case 3: {
            self.AgainPassWordTxtBG.image = [UIImage imageWithResourceName:@"constituency_s.png"];
            break;
        }
        default:
            break;
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    switch (textField.tag) {
        case 1: {
            self.NowPassWordTxtBG.image = [UIImage imageWithResourceName:@"constituency.png"];
            break;
        }
        case 2: {
            self.NewPassWordTxtBG.image = [UIImage imageWithResourceName:@"constituency.png"];
            break;
        }
        case 3: {
            self.AgainPassWordTxtBG.image = [UIImage imageWithResourceName:@"constituency.png"];
            break;
        }
        default:
            break;
    }
}
-(void)dealloc
{
    self.NewPassWordTextField.delegate = nil;
    self.NowPassWordTextField.delegate = nil;
    self.AgainPassWordTextField.delegate = nil; 
}

- (IBAction)TapGestureRecognizer:(UITapGestureRecognizer *)sender {
    [self.NewPassWordTextField resignFirstResponder];
    [self.NowPassWordTextField resignFirstResponder];
    [self.AgainPassWordTextField resignFirstResponder];
}

@end
