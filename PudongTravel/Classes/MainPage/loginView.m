//
//  loginView.m
//  PudongTravel
//
//  Created by jiangjunli on 14-3-28.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "loginView.h"
#import "RegiterView.h"
#import "ConstLinks.h"
#import "HTTPAPIConnection.h"
#import "UserData.h"
#import "AlertViewHandle.h"
#import "UIImage+loadImage.h"
#import "User.h"
#import "LocalCache.h"
#import "ValidateUtil.h"
#import "MyMD5.h"

@implementation loginView

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
    self.accountTextField.delegate = self;
    self.passwordTextField.delegate = self;
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

- (IBAction)loginBtnClick:(id)sender {
    NSString *userName = [self.accountTextField.text
                          stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *password = [self.passwordTextField.text
                          stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
 
    switch ([ValidateUtil validatePhoneNumber:self.accountTextField.text]) {
        case Empty: {
            [AlertViewHandle showAlertViewWithMessage:@"请先输入手机号码"];
            return;
            break;
        }
        case NotMatch: {
            [AlertViewHandle showAlertViewWithMessage:@"手机号码格式错误，请重新输入"];
            return;
            break;
        }
        default:
            break;
    }
    
    switch ([ValidateUtil validatePassword:self.passwordTextField.text]) {
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
   // NSString *md5pasword=[MyMD5 md5:self.passwordTextField.text];
    
    NSString *path = [NSString stringWithString:(NSString*)login];
    path = [path stringByAppendingString:
            [NSString stringWithFormat:@"?account=%@&passWord=%@",self.accountTextField.text,self.passwordTextField.text]];
    NSLog(@"path is %@",path);
    [HTTPAPIConnection postPathToGetJson:path block:^(NSDictionary *json, NSError *error) {
        UserData *data = [UserData new];
        [data updateWithJsonDic:json];
        if(data->info != nil){
            User *user = [User new];
            user.userName = userName;
            user.password = password;
            user.userId = data->info->userId;
            user.nickName = data->info->nickName;
            user.imgUrl = data->info->imgUrl;
            user.storeCnt = data->info->storeCnt;
            user.commonCnt = data->info->commonCnt;
            user.isLoginSuccess = YES;
            [[LocalCache sharedCache] storeCacheObject:user forKey:@"user"];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"loginSuccess" object:nil];
//            self.isLoginSuccess = YES;
            [self removeFromSuperview];
        }else{
            User *user = [User new];
            user.isLoginSuccess = NO;
            [[LocalCache sharedCache] storeCacheObject:user forKey:@"user"];
            if([data->code isEqualToString:@"75"]){
                [AlertViewHandle showAlertViewWithMessage:@"账号或者密码有错误！"];
            }else if([data->code isEqualToString:@"70"]){
                [AlertViewHandle showAlertViewWithMessage:@"账号或者密码有错误！"];
            }else if([data->code isEqualToString:@"71"]){
            }else{
                [AlertViewHandle showAlertViewWithMessage:@"登录失败！请仔细核对登录信息！"];
            }
        }
    }];
}
- (IBAction)sd:(UITapGestureRecognizer *)sender {
    [self.accountTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    switch (textField.tag) {
        case 1: {
            self.accounttTxtBG.image = [UIImage imageWithResourceName:@"constituency_s.png"];
            break;
        }
        case 2: {
            self.passwordTxtBG.image = [UIImage imageWithResourceName:@"constituency_s.png"];
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
            self.accounttTxtBG.image = [UIImage imageWithResourceName:@"constituency.png"];
            break;
        }
        case 2: {
            self.passwordTxtBG.image = [UIImage imageWithResourceName:@"constituency.png"];
            break;
        }
            
        default:
            break;
    }
}
-(void)dealloc
{
    self.accountTextField.delegate = nil;
    self.passwordTextField.delegate = nil;
}

@end
