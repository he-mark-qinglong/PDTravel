//
//  ChangeNickNameView.m
//  PudongTravel
//
//  Created by jiangjunli on 14-4-4.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "ChangeNickNameView.h"
#import "personalSetingView.h"
#import "UIImage+loadImage.h"
#import "HTTPAPIConnection.h"
#import "ConstLinks.h"
#import "User.h"
#import "UserData.h"
#import "AlertViewHandle.h"
#import "LocalCache.h"
#import "User.h"
#import "LocalCache.h"
#import "ValidateUtil.h"
@interface ChangeNickNameView()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *changeBtnClick;
@property (weak, nonatomic) IBOutlet UITextField *textfield;
@property (weak, nonatomic) IBOutlet UIImageView *textfieldBG;

@end

@implementation ChangeNickNameView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (IBAction)backBtnClick:(id)sender {

    [self removeFromSuperview];
}
- (void)awakeFromNib
{
    self.textfield.delegate = self;
}


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
                self.textfieldBG.image = [UIImage imageWithResourceName:@"constituency_s.png"];
     }
- (void)textFieldDidEndEditing:(UITextField *)textField
{
                self.textfieldBG.image = [UIImage imageWithResourceName:@"constituency.png"];
     }
-(void)dealloc
{
    self.textfield.delegate = nil;
   }

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
- (IBAction)TapGestureRecognizer:(UITapGestureRecognizer *)sender {
    [self.textfield resignFirstResponder];
}
- (IBAction)UPNickNameBtnClick:(id)sender {
    
    switch ([ValidateUtil validatePassword:self.textfield.text]) {
        case Empty: {
            [AlertViewHandle showAlertViewWithMessage:@"昵称不能为空！"];
            return;
            break;
        }
               default:
            break;
    }

    NSString *nickName = [self.textfield.text
                          stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    User *user = [[LocalCache sharedCache] cachedObjectForKey:@"user"];
    self.userID=user.userId;
    
    
    NSString *path = [kAPIBaseURLString stringByAppendingString:[updateNickName copy]];
    NSURL *url                       = [NSURL URLWithString:path];
    
    NSMutableURLRequest *request     = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30];
    [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
    
    //将textfile文本框中的内容给服务器
    NSString *valueStr = [NSString stringWithFormat:@"userId=%@&nickName=%@",self.userID,self.textfield.text];
    NSData *data = [valueStr dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data];
    
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSError *error;
    NSData *response=[[NSData alloc]initWithData:received];
    NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
    
    NSString *code=[resultDic objectForKey:@"code"];
    if([code isEqualToString:@"71"]){
        [AlertViewHandle showAlertViewWithMessage:@"修改成功！"];
        User * user =  [[LocalCache sharedCache] cachedObjectForKey:@"user"];
        user.nickName = nickName;
        [[LocalCache sharedCache] storeCacheObject:user forKey:@"user"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"changeupdateNickNameSuccess" object:nil];
        [self removeFromSuperview];
    }else{
        [AlertViewHandle showAlertViewWithMessage:@"修改失败！"];
    }
    
}

@end
