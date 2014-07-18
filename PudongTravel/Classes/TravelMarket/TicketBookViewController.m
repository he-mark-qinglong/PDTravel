//
//  TicketBookViewController.m
//  pudongapp
//
//  Created by jiangjunli on 14-2-19.
//  Copyright (c) 2014年 jiangjunli. All rights reserved.
//

#import <EventKit/EventKit.h>
#import <EventKitUI/EventKitUI.h>

#import "TicketBookViewController.h"
#import "UICCalendarPicker.h"
#import "UICCalendarPickerDateButton.h"
#import "CommonHeader.h"
#import "UIView+FitVersions.h"
@interface TicketBookViewController ()<EKEventEditViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UILabel *piaoshulabel;
@property (weak, nonatomic) IBOutlet UIView *dataview;
@property (weak, nonatomic) IBOutlet UIButton *ticketBookBtn;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@property BOOL invalidTime;
@property NSString *choosedDateInText;
@end

@implementation TicketBookViewController

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
    
    ((UILabel*)self.navigationItem.titleView).text = @"预订";  //设置标题
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    if (IOSVersion70)
    {
        [self.contentView FitViewOffsetY];
       
    }

    // Do any additional setup after loading the view from its nib.
    UICCalendarPicker *calendarPicker = [[UICCalendarPicker alloc] initWithSize:UICCalendarPickerSizeExtraLarge];
    calendarPicker.frame = CGRectMake(calendarPicker.frame.origin.x, 130,
                                      calendarPicker.frame.size.width, calendarPicker.frame.size.height);
    
	[calendarPicker setDelegate:self];
    [calendarPicker setDataSource:self];
	[calendarPicker setSelectionMode:UICCalendarPickerSelectionModeSingleSelection];
	[calendarPicker setPageDate:[NSDate dateWithTimeIntervalSinceNow:1*(60 * 60 * 8)]];
	[calendarPicker showInView:self.view animated:YES];
    self.dataview.backgroundColor = [UIColor clearColor];
    [self.dataview addSubview:calendarPicker];
    
    NSDate *  senddate = [NSDate date];
    
    NSDateFormatter  *dateformatter = [[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"YYYY年MM月dd"];
    senddate = [NSDate dateWithTimeIntervalSinceNow:1*(60 * 60 * 8*9)];
    NSString *  locationString = [dateformatter stringFromDate:senddate];
    
    NSLog(@"locationString#######:%@",locationString);
    
    self.label.text = [NSString stringWithFormat:@"为了保证出行畅通，请你至少提前3天以上进行预定今日可预定%@以后的门票",locationString];
    if (IS_IPHONE5) {
    //    self.ticketBookBtn.frame = CGRectMake(24, 512, 272, 47);
    }
}
#pragma mark UICCalendarPickerDelegate Methods
//点击日历按钮
- (void)picker:(UICCalendarPicker *)picker didSelectDate:(NSArray *)selectedDate
{
    
    if ([selectedDate count] == 0) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请选择其他日期" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }else{
        NSDate* selectDate = [selectedDate objectAtIndex:0];
        if ([selectDate isKindOfClass:[NSDate class]]) {
            //NSLog(@"selectedDate:%@", selectedDate);
            selectDate  = [NSDate dateWithTimeInterval:8*60*60 sinceDate:selectDate];
            NSLog(@"selectdDate:%@", selectDate);
            
            NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
            [inputFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
            self.choosedDateInText= [inputFormatter stringFromDate:selectDate];
            NSLog(@"formated date:%@", self.choosedDateInText);
            
            NSDate *today = [picker today];
            NSTimeInterval timeInterval = [today timeIntervalSinceDate:selectDate];
            if(timeInterval > 0){  //从今天开始计算，时间大于0，说明是在今天之前
                self.invalidTime = YES;
            }else{
                self.invalidTime = NO;
            }
        }
    }
}

- (void)picker:(UICCalendarPicker *)picker pushedPrevButton:(id)sender
{
    NSLog(@"dated selected before remove lastobject = %@ ",[picker selectedDates]);
    [[picker selectedDates] removeLastObject];
    NSLog(@"dated selected after remove lastobject = %@ ",[picker selectedDates]);
}

- (void)picker:(UICCalendarPicker *)picker pushedNextButton:(id)sender
{
    NSLog(@"dated selected before remove lastobject = %@ ",[picker selectedDates]);
    [[picker selectedDates] removeLastObject];
    NSLog(@"dated selected after remove lastobject = %@ ",[picker selectedDates]);
    
}

#pragma mark  EKEventEditViewDelegate
- (void)eventEditViewController:(EKEventEditViewController *)controller
          didCompleteWithAction:(EKEventEditViewAction)action{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - UICCalendarPickerDataSource
- (NSString *)picker:(UICCalendarPicker *)picker textForYearMonth:(NSDate *)aDate {
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
	[dateFormatter setDateFormat:@"yyyy年MM"];
	return [dateFormatter stringFromDate:aDate];
}

//当日历载入时加载在上面的每一个button（日历项）都会再此方法中得到回调
- (void)picker:(UICCalendarPicker *)picker buttonForDate:(UICCalendarPickerDateButton *)button {
    NSString *path = [[[NSBundle mainBundle] resourcePath]stringByAppendingPathComponent:@"hoursList.plist"];
    NSDictionary* dict =  [[NSDictionary alloc] initWithContentsOfFile:path];
    NSDictionary *dataDict = [dict objectForKey:@"extendedHours"];
    
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [dateFormatter1 stringFromDate:[button date]];

    for (NSString  *str in [dataDict allKeys]){
        if ([str isEqualToString:dateStr] && [button backgroundImageForState:UIControlStateNormal] != [UIImage imageNamed:@"uiccalendar_cell_monthout.png"]) {
            [button setBackgroundImage:[UIImage imageNamed:@"uiccalendar_cell_holiday.png"]
                              forState:UIControlStateNormal];
            break;
        }
    }
}

#pragma mark Event handler
//订票数量减少
- (IBAction)jiabuttonclick:(id)sender {
   NSString *piaoshu = self.piaoshulabel.text;
    int intString = [piaoshu intValue];
    intString = intString-1;
    NSString *stringInt =[NSString stringWithFormat:@"%d",intString];

    if (intString<1) {
        UIAlertView *alert=[[UIAlertView alloc]
                            initWithTitle:@"温馨提示" message:@"订票数量不能小于1哦！"
                                                    delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
        intString = 1;
        return;
    }
   
    self.piaoshulabel.text = stringInt;

}
- (IBAction)jiabuttonclisk:(id)sender {
    NSString *piaoshu = self.piaoshulabel.text;
    int intString = [piaoshu intValue];
    intString = intString+1;
    NSString *stringInt =[NSString stringWithFormat:@"%d",intString];
    self.piaoshulabel.text = stringInt;
}

- (IBAction)onBookBtnClicked:(id)sender {
    if(self.invalidTime){
        [AlertViewHandle showAlertViewWithMessage:@"请选择今天以后的日期进行预定"];
        return;
    }
    if(self.choosedDateInText == nil || [self.choosedDateInText isEqualToString:@""] ){
        [AlertViewHandle showAlertViewWithMessage:@"请选择日期"];
        return;
    }
    NSString *path;
    User *user = [[LocalCache sharedCache] cachedObjectForKey:@"user"];
    if(!user || !user.isLoginSuccess){
        [AppDelegate showLogin];
        return;
    }
    /*
     1:marketId(大超市Id)
     2:userId(用户Id)
     3:orderTime(预定的日期)
     4:orderNum(预定的票数)
     */
    NSString *appenStr = nil;
    if(self.orderType == EMarketOrder){
        appenStr = [NSString stringWithFormat:@"?marketId=%@&userId=%@&orderTime=%@&orderNum=%@",
                            self.marketId,
                            user.userId,
                            self.choosedDateInText, self.piaoshulabel.text];
        path = [addOrder copy];
    }else if(self.orderType == EViewOrder){
        appenStr = [NSString stringWithFormat:@"?viewId=%@&userId=%@&orderDate=%@&ticketCnt=%@",
                    self.marketId,
                    user.userId,
                    self.choosedDateInText,self.piaoshulabel.text];
        path = [orderTicket copy];
    }
    path = [path stringByAppendingString:appenStr];
    [HTTPAPIConnection postPathToGetJson:path block:^(NSDictionary *json, NSError *error) {
        NSLog(@"json:%@", json);
        if(error){
            [AlertViewHandle showAlertViewWithMessage:[error domain]];
        }else{
            NSString *codeStr = [json objectForKey:@"code"];
            if( codeStr == nil || [codeStr integerValue] == 70)
                [AlertViewHandle showAlertViewWithMessage:@"没有可预订的票"];
            else if ([codeStr isEqualToString:@"71"])
            {
                 [AlertViewHandle showAlertViewWithMessage:@"预定成功"];
            }
            else if ([codeStr isEqualToString:@"81"])
            {
                [AlertViewHandle showAlertViewWithMessage:@":已经超过有效期"];
            }
            else
            {
                 [AlertViewHandle showAlertViewWithMessage:@"每天累计最多只能预订5张票！"];
            }
               
        }
    }];
}
- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:NO  completion:nil];
}

@end
