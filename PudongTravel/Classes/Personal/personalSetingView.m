//
//  personalSetingView.m
//  PudongTravel
//
//  Created by jiangjunli on 14-4-3.
//  Copyright (c) 2014年 mark. All rights reserved.
//
#import <ReactiveCocoa/RACEXTScope.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

#import "personalSetingView.h"
#import "ChangeNickNameView.h"
#import "ChangePasswordView.h"
#import "User.h"
#import "LocalCache.h"

@interface personalSetingView ()
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;

@property (weak, nonatomic) IBOutlet UIButton *quitLoginBtn;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UIButton *changNickNameBtn;
@property (weak, nonatomic) IBOutlet UIButton *changePasswdBtn;

@property (strong,nonatomic) ChangeNickNameView *changenickname;
@property (strong,nonatomic)ChangePasswordView *changepasswordview;
@end

@implementation personalSetingView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib{
    @weakify(self);
    
    User *user = [[LocalCache sharedCache] cachedObjectForKey:@"user"];
    self.userNameLabel.text = user.userName;
    self.nickNameLabel.text = user.nickName;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(changeupdateNickNameSuccess)
                                                 name:@"changeupdateNickNameSuccess" object:nil];
    //退出
    [[self.quitLoginBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(id x) {
         User * user =  [[LocalCache sharedCache] cachedObjectForKey:@"user"];
         user.userId = nil;
         user.isLoginSuccess = NO;
         user.commonCnt = 0;
         user.storeCnt = 0;
         [[NSNotificationCenter defaultCenter] postNotificationName:@"quitlogin" object:nil];
         [self removeFromSuperview];
     }];
    //返回
    [[self.backBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(id x) {
         @strongify(self);
         [self removeFromSuperview];
     }];
    //修改昵称
    [[self.changNickNameBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(id x) {
         @strongify(self);
         self.changepasswordview = [[[NSBundle mainBundle]
                                     loadNibNamed:@"ChangePasswordView"
                                     owner:nil options:nil] objectAtIndex:0];
         [self.contentview addSubview:self.changepasswordview];
     }];
    //改密码
    [[self.changePasswdBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(id x) {
         @strongify(self);
         self.changenickname = [[[NSBundle mainBundle]
                                 loadNibNamed:@"ChangeNickNameView"
                                 owner:nil options:nil] objectAtIndex:0];
         [self.contentview addSubview:self.changenickname];
     }];
}

-(void)changeupdateNickNameSuccess{
    User *user = [[LocalCache sharedCache] cachedObjectForKey:@"user"];
    self.nickNameLabel.text = user.nickName;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
