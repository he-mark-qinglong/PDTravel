//
//  FreeTicketViewController.m
//  pudongapp
//
//  Created by jiangjunli on 14-2-13.
//  Copyright (c) 2014年 jiangjunli. All rights reserved.
//

#import "FreeTicketViewController.h"
#import "CommonHeader.h"

#import "TicketBookViewController.h"
#import "TicketData.h"
#import "NSString+RectSize.h"
#import "UIView+FitVersions.h"

@interface FreeTicketViewController ()
@property (weak, nonatomic) IBOutlet UILabel *timelabel;
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;
@property (weak, nonatomic) IBOutlet UIButton *ticketButton;

@property (weak, nonatomic) IBOutlet UIButton *overBtn;
@property (weak, nonatomic) IBOutlet UIImageView *imgWithUrl;
@property (weak, nonatomic) IBOutlet UILabel *ticketCount;

@property (weak, nonatomic) IBOutlet UILabel *ticketName;
@property (weak, nonatomic) IBOutlet UILabel *robTicketTime;
@property (weak, nonatomic) IBOutlet UIWebView *webview;

@property (weak, nonatomic) IBOutlet UILabel *validTime;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (strong, nonatomic) NSDate *startTime;
@property (strong, nonatomic) NSDate *endTime;
@property (strong, nonatomic) NSDate *currTime;

@property NSString *ticketId;
@property NSTimer *timer;

@property double intervalTime;
@property BOOL nextFlag;  //区分是否显示下一期的预告，数据填充来自于网络数据 。
@end

@implementation FreeTicketViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    ((UILabel*)self.navigationItem.titleView).text = @"免费抢票";
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.overBtn.hidden = YES;
    [HTTPAPIConnection postPathToGetJson:[currShowTicket copy]
                                   block:^(NSDictionary *json, NSError *error)
     {
         if(error || [json objectForKey:@"info"] == nil){
             self.ticketButton.enabled = NO;
             self.overBtn.enabled = NO;
             return ;
         }
         TicketData *data = [TicketData new];
         [data updateWithJsonDic:json];
         self.nextFlag = [data.info.nextFlag integerValue];
         
         [self setUpUI:data.info];
         //只在没有下一期内容的时候才需要设置倒计时
         [self.ticketButton setBackgroundImage:[UIImage imageNamed:@"icon_grab.png"]
                                      forState:UIControlStateNormal];
         [self setUpTimer];
    }];
    
    
    if (IOS7) {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"top_background.png"] forBarMetrics:UIBarMetricsDefault];
    }else{
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"top44.png"] forBarMetrics:UIBarMetricsDefault];
    }

}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    if(self.timer){
        [self.timer invalidate];
        self.timer = nil;
    }
}
- (void)viewDidLoad{
    [super viewDidLoad];
    [self.contentView FitViewOffsetY];
    
    [self.contentScrollView setContentOffset:CGPointMake(0, 60) animated:NO];
    
    if (! IS_IPHONE5) {
        self.contentScrollView.frame = CGRectMake(self.contentScrollView.frame.origin.x,self.contentScrollView.frame.origin.y, self.contentScrollView.frame.size.width, self.contentScrollView.frame.size.height-60);
        self.ticketButton.frame = CGRectMake(self.ticketButton.frame.origin.x,self.ticketButton.frame.origin.y-80, self.ticketButton.frame.size.width, self.ticketButton.frame.size.height);
    }
}

-(NSDate*)myStringToDate:(NSString *)str{
    //@"2013-08-13 20:28:40";  //传入时间
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [format dateFromString:str];
    return date;
}
-(void)setUpUI:(TicketInfo *)info{
    self.currTime         = [self myStringToDate:info.currTime];
    self.startTime        = [self myStringToDate:info.startTime];
    self.endTime          = [self myStringToDate:info.endTime];
    
    [PictureHelper addPicture:info.imgUrl to:self.imgWithUrl];
    self.ticketId         = info.ticketId;
    self.ticketName.text  = info.ticketName;
    self.robTicketTime.text = [NSString stringWithFormat:@"%@ - %@", info.startTime, info.endTime];
    self.validTime.text   = [NSString stringWithFormat:@"%@ - %@", info.validStartTime, info.validEndTime];
    self.ticketCount.text = [NSString stringWithFormat:@"%@", info.surplusCnt];

    
    NSString *htmlStr =  [NSString stringWithFormat:@"<html> \n"
                          "<head> \n"
                          "<style type=\"text/css\"> \n"
                          "body {font-size: %@; color: %@;}\n"
                          "</style> \n"
                          "</head> \n"
                          "<body>%@</body> \n"
                          "</html>",@"13", @"white", info.remark ];
     [self.webview loadHTMLString:htmlStr baseURL:nil];
    CGSize size = [self.contentScrollView contentSize];
    [self.contentScrollView setContentSize:CGSizeMake(size.width, size.height+300)];
   
}

-(void)setupBtnWhenStop{
    /*
     3.本期已过期，下期没有数据（增加已结束标签，但无法跳转）
     4.本期已过期，下次有数据（增加已结束标签，跳转到下期的界面数据）
     */
    if(self.nextFlag == NO){
        self.overBtn.hidden = NO;
        self.overBtn.enabled = NO;
    }else{
        self.overBtn.hidden = NO;
        self.overBtn.enabled = YES;
        
        self.ticketButton.enabled = NO;
    }
}
-(void)setUpTimer{
    self.intervalTime = [self.endTime timeIntervalSinceDate:self.currTime];
    
    if(self.intervalTime > 0){
        /*
         1.本期进行中，下期没数据（只显示本期进行的状态）
         2.本期进行中，下期有数据（只显示本期进行的状态）
         */
        //使用timer定时，每秒触发一次
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self
                                                    selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
        self.overBtn.hidden = YES;
        self.ticketButton.enabled = YES;
    }else{
        [self setupBtnWhenStop];
    }
}
- (void)timerFireMethod:(NSTimer*)theTimer{
    --self.intervalTime;
    long lTime = (long)self.intervalTime;
    
    if(lTime <= 0.0){
        [self.timer invalidate];
        self.timer = nil;
        self.timelabel.text = @"0天00:00:00";
        [self setupBtnWhenStop];
        return;
    }
    
    NSInteger iSeconds = lTime % 60;
    NSInteger iMinutes = (lTime / 60) % 60;
    NSInteger iHours = (lTime /60/60%24);
    NSInteger iDays = lTime/60/60/24;
    NSInteger iMonth = lTime/60/60/24/12;
    NSInteger iYears = lTime/60/60/24/365;
    
    NSDateComponents *shibo = [[NSDateComponents alloc] init];
    //NSLog(@"相差%d年%d月 或者 %d日%d时%d分%d秒", iYears,iMonth,iDays,iHours,iMinutes,iSeconds);
    [shibo setYear:iYears];
    [shibo setMonth:iMonth];
    [shibo setDay:iDays];
    [shibo setHour:iHours];
    [shibo setMinute:iMinutes];
    [shibo setSecond:iSeconds];
    
    self.timelabel.text = [NSString stringWithFormat:@"%d天%d:%d:%d",
                           [shibo day], [shibo hour], [shibo minute], [shibo second]];
}
#pragma mark event Handeler
- (IBAction)bookbtnclick:(id)sender {
    User *user = [[LocalCache sharedCache ] cachedObjectForKey:@"user"];
    if(user == nil || user.isLoginSuccess == NO){
        [AppDelegate showLogin];
        return;
    }
    NSString *path = [grabTicket copy];
    path = [path stringByAppendingFormat:@"?userId=%@&ticketId=%@",
            user.userId, self.ticketId];
    
    [HTTPAPIConnection postPathToGetJson:path block:^(NSDictionary *json, NSError *error){
        /*
         1：code=72   用户已经抢过票
         2：code=81   抢票活动结束
         3：code=82   票已经抢光
         4：code=71   抢票成功
         */
        NSString *codeStr = [json objectForKey:@"code"];
        if(error || codeStr == nil){
            [AlertViewHandle showAlertViewWithMessage:@"抢票失败"];
            return;
        }
        NSInteger code = [codeStr integerValue];
        switch (code) {
            case 71:
                [AlertViewHandle showAlertViewWithMessage:@"抢票成功"];
                break;
            case 72:
                [AlertViewHandle showAlertViewWithMessage:@"您已经抢过票了"];
                break;
            case 81:
                [AlertViewHandle showAlertViewWithMessage:@"抢票活动已结束"];
                [self setupBtnWhenStop];
                break;
            case 82:
                [AlertViewHandle showAlertViewWithMessage:@"票已经抢光啦"];
                break;
            default:
                [AlertViewHandle showAlertViewWithMessage:@"很遗憾，您没有抢票成功或票已经被抢完"];
                break;
        }
    }];
}

- (IBAction)onOverBtnClicked:(id)sender {
    self.overBtn.hidden = YES;
    self.ticketButton.enabled = NO;
    
    NSString *path = [nextTicket copy];
    path = [path stringByAppendingString:[NSString stringWithFormat:@"?currentId=%@", self.ticketId]];
    [HTTPAPIConnection postPathToGetJson:path block:^(NSDictionary *json, NSError *error){
        if(error || [json objectForKey:@"code"]){
            //[self enableOverBtn];
            return ;
        }
        TicketData *data = [TicketData new];
        [data updateWithJsonDic:json];
        
        [self setUpUI:data.info];
        [self.ticketButton setBackgroundImage:[UIImage imageNamed:@"icon_grab_x.png"]
                                     forState:UIControlStateNormal];
        self.ticketButton.enabled = NO;
        self.overBtn.hidden = YES;
    }];
}
@end
