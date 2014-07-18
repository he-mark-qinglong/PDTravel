//
//  SafetyVerificationView.m
//  PudongTravel
//
//  Created by jiangjunli on 14-4-3.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "SafetyVerificationView.h"
#import "ConstLinks.h"
#import "AlertViewHandle.h"
#import "HTTPAPIConnection.h"
#import "UserData.h"
#import "RegiterView.h"
#import "User.h"
#import "LocalCache.h"
#import "ValidateUtil.h"
#import "MyMD5.h"
@implementation SafetyVerificationView
static const NSInteger kTime = 60;

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
    [self timebegin];
     self.sendValidationCodeButton.enabled= NO;
    
}
-(void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    static BOOL addFromSuperView = YES;
    if(addFromSuperView){
        [self getverifiaction];
    }
    addFromSuperView = !addFromSuperView;
}

-(void)getverifiaction
{
    NSString *path = [NSString stringWithString:(NSString*)verification];

    path = [path stringByAppendingString:
            [NSString stringWithFormat:@"?userName=%@",self.account]];
    NSLog(@"path is %@",path);
    [HTTPAPIConnection postPathToGetJson:path block:^(NSDictionary *json, NSError *error) {
    } ];

}
-(void)timebegin
{
    _time = kTime;
    //   self.timeLabel.hidden = NO;
    // self.timeLabel.text = [NSString stringWithFormat:@"%i 秒", _time];
    //self.sendValidationCodeButton.enabled = NO;
    
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1
                                                  target:self
                                                selector:@selector(timeCount)
                                                userInfo:nil
                                                 repeats:YES];
     self.sendValidationCodeButton.enabled = NO;
}

- (void)timeCount
{
    _time = _time-1;
   // [self.sendValidationCodeButton setTitle:@"" forState:UIControlStateNormal];
    self.timeLabel.text = [NSString stringWithFormat:@"%i 秒", _time];
    if (_time == 0) {
        [self.timer invalidate];
//        self.timeLabel.hidden = YES;
        self.sendValidationCodeButton.enabled= YES;
        [self.sendValidationCodeButton setBackgroundImage:[UIImage imageNamed:@"icon_2.png"] forState:UIControlStateNormal];
    }
}

- (IBAction)closeBtnClick:(id)sender {
    
    [self removeFromSuperview];
}
- (IBAction)reveificationBtnClick:(id)sender {
    [self.sendValidationCodeButton setBackgroundImage:[UIImage imageNamed:@"icon_3.png"] forState:UIControlStateNormal];
     [self timebegin];
    [self getverifiaction];
}
- (IBAction)registeBtnClick:(id)sender {


//    NSString *md5password=[MyMD5 md5:self.password];
//
//    NSString *md5repassword=[MyMD5 md5:self.repassword];
  //  NSLog(@"%@",md5password);
    
    NSString *path = [kAPIBaseURLString stringByAppendingString:[reg copy]];
    NSURL *url                       = [NSURL URLWithString:path];

    NSMutableURLRequest *request     = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30];
    [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
    
    //将textfile文本框中的内容给服务器
    NSString *valueStr = [NSString stringWithFormat:@"account=%@&passWord=%@&passWordAgain=%@&nickName=%@&code=%@",self.account,self.password,self.repassword,self.niciname,self.verificationTextField.text];
    NSLog(@"%@",valueStr);
    NSData *data = [valueStr dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data];
    
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSError *error;
    NSData *response=[[NSData alloc]initWithData:received];
    NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
    
    NSString *code=[resultDic objectForKey:@"code"];
    NSLog(@"code is %@",code);
    if([code isEqualToString:@"71"]){
        [AlertViewHandle showAlertViewWithMessage:@"注册成功，浦东欢迎你，请登录！"];
        [self removeFromSuperview];
    }else if([code isEqualToString:@"88"]){
        [AlertViewHandle showAlertViewWithMessage:@"验证码输入错误！"];
        
    }
    else if([code isEqualToString:@"87"]){
        [AlertViewHandle showAlertViewWithMessage:@"验证码过期！"];}
    else if([code isEqualToString:@"78"]){
        [AlertViewHandle showAlertViewWithMessage:@"两次密码不匹配！"];}
    else if([code isEqualToString:@"80"]){
        [AlertViewHandle showAlertViewWithMessage:@"确认密码为空！"];}
    else if([code isEqualToString:@"77"]){
            [AlertViewHandle showAlertViewWithMessage:@"昵称为空"];
    }
    else if([code isEqualToString:@"72"]){
        [AlertViewHandle showAlertViewWithMessage:@"该用户已经被注册"];
    }
        else{
        [AlertViewHandle showAlertViewWithMessage:@"注册失败！请仔细核对注册信息！"];
    }
}
- (IBAction)TapGestureRecognizer:(UITapGestureRecognizer *)sender {
    [self.verificationTextField resignFirstResponder];
}
- (void)dealloc
{
    if (self.timer && [self.timer isValid]) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

@end
