//
//  ScenicSpotViewController.m
//  pudongapp
//
//  Created by jiangjunli on 14-2-17.
//  Copyright (c) 2014年 jiangjunli. All rights reserved.
//

#import "ScenicSpotViewController.h"
#import "CommonHeader.h"

#import "TicketBookViewController.h"
#import "NearbyViewController.h"
#import "SoundDownLoadViewController.h"

#import "ElseMainViewData.h"
#import "NearbyMapViewController.h"
#import "CustomNavigationController.h"
#import "EmbedReaderViewController.h"



@interface ScenicSpotViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;
@property (weak, nonatomic) IBOutlet UIButton *wangyoudianpingbtn;
@property (weak, nonatomic) IBOutlet UILabel *telLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property BOOL isSeleced;
@property (weak, nonatomic) IBOutlet UIButton *frienddianping;

@property (weak, nonatomic) IBOutlet UILabel *score;
@property (weak, nonatomic) IBOutlet UIImageView *mainPicture;
@property (weak, nonatomic) IBOutlet UILabel *level;
@property (weak, nonatomic) IBOutlet UIImageView *travelPattern;
@property (weak, nonatomic) IBOutlet UIButton *bookBtnClicked;
@property (weak, nonatomic) IBOutlet UIImageView *star1;
@property (weak, nonatomic) IBOutlet UIImageView *star2;
@property (weak, nonatomic) IBOutlet UIImageView *star3;
@property (weak, nonatomic) IBOutlet UIImageView *star4;
@property (weak, nonatomic) IBOutlet UIImageView *star5;

@property NSString *scores;
//user data
@property (retain, nonatomic) ViewDetailData *data;
@end

@implementation ScenicSpotViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)parseJson:(NSDictionary *)json{
    self.data = [ViewDetailData new];
    [self.data updateWithJsonDic:json];
    
    ViewDetailInfo *info = self.data->info;
    self.telLabel.text = info->phone;
    if ([info->grade isEqualToString:@"nullA"]) {
        self.level.text = @"";
    }
    else{
        self.level.text = info->grade;}
    NSLog(@"%@",info->grade);
    self.titleLabel.text = info->title;
    self.score.text = [ NSString stringWithFormat:@"%0.1f分", info->score];
    NSLog(@"%@",self.score.text);

    [PictureHelper addPicture:info->imgUrl to:self.mainPicture];
    
    //setup travel pattern
    int peopleWarn = [info->peopleWarn integerValue];
    NSString *patternFile = nil;
    switch (peopleWarn) {
        case 1:  //畅通
            patternFile = @"pattern_unobstructed.png";
            break;
        case 2:  //拥挤
            patternFile = @"pattern_crowd.png";
            break;
        case 3:  //高峰
            patternFile = @"pattern_peak.png";
            break;
        case 0:  //直下式,和 default使用同一个分支
        default:
            patternFile = @"pattern_invalid.png";
            self.bookBtnClicked.hidden = YES;
            self.travelPattern.hidden = YES;
            break;
    }
    self.travelPattern.image = [UIImage imageNamed:patternFile];
    
    self.scores = [NSString stringWithFormat:@"%f",info->score];
    int s = [self.scores integerValue];
    switch (s) {
        case 0:
            self.star1.image = [UIImage imageNamed:@"pattern_Star.png"];
            self.star2.image = [UIImage imageNamed:@"pattern_Star.png"];
            self.star3.image = [UIImage imageNamed:@"pattern_Star.png"];
            self.star4.image = [UIImage imageNamed:@"pattern_Star.png"];
            self.star5.image = [UIImage imageNamed:@"pattern_Star.png"];
            
            break;
        case 1:
            self.star1.image = [UIImage imageNamed:@"pattern_Star_bright.png"];
             self.star2.image = [UIImage imageNamed:@"pattern_Star.png"];
            self.star3.image = [UIImage imageNamed:@"pattern_Star.png"];
            self.star4.image = [UIImage imageNamed:@"pattern_Star.png"];
            self.star5.image = [UIImage imageNamed:@"pattern_Star.png"];
    
            break;
        case 2:
            self.star1.image = [UIImage imageNamed:@"pattern_Star_bright.png"];
            self.star2.image = [UIImage imageNamed:@"pattern_Star_bright.png"];
            self.star3.image = [UIImage imageNamed:@"pattern_Star.png"];
            self.star4.image = [UIImage imageNamed:@"pattern_Star.png"];
            self.star5.image = [UIImage imageNamed:@"pattern_Star.png"];
            break;
        case 3:
            self.star1.image = [UIImage imageNamed:@"pattern_Star_bright.png"];
            self.star2.image = [UIImage imageNamed:@"pattern_Star_bright.png"];
            self.star3.image = [UIImage imageNamed:@"pattern_Star_bright.png"];
            self.star4.image = [UIImage imageNamed:@"pattern_Star.png"];
            self.star5.image = [UIImage imageNamed:@"pattern_Star.png"];
            break;
        case 4:
            self.star1.image = [UIImage imageNamed:@"pattern_Star_bright.png"];
            self.star2.image = [UIImage imageNamed:@"pattern_Star_bright.png"];
            self.star3.image = [UIImage imageNamed:@"pattern_Star_bright.png"];
            self.star4.image = [UIImage imageNamed:@"pattern_Star_bright.png"];
            self.star5.image = [UIImage imageNamed:@"pattern_Star.png"];
            break;
        default:
            self.star1.image = [UIImage imageNamed:@"pattern_Star_bright.png"];
            self.star2.image = [UIImage imageNamed:@"pattern_Star_bright.png"];
            self.star3.image = [UIImage imageNamed:@"pattern_Star_bright.png"];
            self.star4.image = [UIImage imageNamed:@"pattern_Star_bright.png"];
            self.star5.image = [UIImage imageNamed:@"pattern_Star_bright.png"];
            break;
    }
    
}
-(void)loadDataFromWeb{
    NSString *path;
    if(self.path == nil || [self.path isEqualToString:@""]){
        path = [NSString stringWithString:(NSString*)getViewDetail];
        path = [path stringByAppendingString:
            [NSString stringWithFormat:@"?viewId=%@",self.idStr]];
    }else{
        path = self.path;
    }
    [HTTPAPIConnection postPathToGetJson:(NSString*)path
                                   block:^(NSDictionary *json, NSError *error){
                                       [self parseJson:json];
                                   }];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    ((UILabel*)self.navigationItem.titleView).text = @"景区";  //设置标题
}
-(void)viewWillAppear:(BOOL)animated{
    self.merchantOrSceneTitle.text = self.merchantOrSceneTitleText;
    [super viewWillAppear:animated];
    [self loadDataFromWeb];
}
- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.contentScrollView.contentSize = CGSizeMake(320,1137);
    self.contentScrollView.showsHorizontalScrollIndicator = NO;
    self.contentScrollView.showsVerticalScrollIndicator = YES;
    self.wangyoudianpingbtn.backgroundColor = [UIColor clearColor];
}

-(void)makeACall:(NSString*)phoneNum{// 电话号码
    NSString *modelname = [[UIDevice currentDevice] model];
    if (![modelname isEqualToString:@"iPhone"]) {
        //不是 iPhone
        [AlertViewHandle showAlertViewWithMessage:@"无法使用拨号功能"];
        return;
    }
        
    NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",phoneNum]];
    
    UIWebView* phoneCallWebView = [[UIWebView alloc] initWithFrame:CGRectZero];// 这个webView只是一个后台的View 不需要add到页面上来  效果跟方法二一样 但是这个方法是合法的
    [phoneCallWebView loadRequest:[NSURLRequest requestWithURL:phoneURL]];
    [self.view addSubview:phoneCallWebView];
    //而这个方法则打电话前先弹框  是否打电话 然后打完电话之后回到程序中 网上说这个方法可能不合法 无法通过审核
    NSString *num = [[NSString alloc] initWithFormat:@"tel://%@",phoneNum];
    
    UIWebView*callWebview =[[UIWebView alloc] init];
    NSURL *telURL =[NSURL URLWithString:num];// 貌似tel:// 或者 tel: 都行
    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
    //记得添加到view上
    [self.view addSubview:callWebview];
}
#pragma mark Events handler
- (IBAction)telBtnClick:(id)sender {
    
    NSString *number =self.telLabel.text;// 此处读入电话号码
    
    // NSString *num = [[NSString alloc] initWithFormat:@"tel://%@",number]; //number为号码字符串 如果使用这个方法 结束电话之后会进入联系人列表
    
    [self makeACall:number];
    //    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.cppblog.com"]];
}
- (IBAction)iDpBtnClick:(id)sender {
    dpvc = [dianpingViewController new];
    dpvc.idStr = self.data->info->id;
    dpvc.data = self.data;
//    [self presentViewController:dpvc animated:NO completion:nil];
    [self.navigationController pushViewController:dpvc animated:YES];
}
- (IBAction)wydpBtnClicked:(id)sender {
    wydpvc = [wangyoudianpingViewController new];
    wydpvc.viewId = self.idStr;
    wydpvc.ismessage = self.score.text;
       [self.navigationController pushViewController:wydpvc animated:YES];
}

- (IBAction)menpiaoBtnClick:(id)sender {
    TicketBookViewController *tbvc = [[TicketBookViewController alloc]init];
    tbvc.marketId = self.idStr;
    tbvc.orderType = EViewOrder;
    [self.navigationController pushViewController:tbvc animated:YES];
}
- (IBAction)merchantMessage:(id)sender {
    IntroductionViewController *ivc = [[IntroductionViewController alloc]init];
    ivc.idStr = self.data->info->id;
    [self.navigationController pushViewController:ivc animated:YES];
}
- (IBAction)onLocateBtnClicked:(id)sender {
    if(self.data == nil)
        return;
    //(latitude = 31.245369, longitude = 121.50626)
    CLLocationCoordinate2D loct = {
        [self.data->info->lat doubleValue],
        [self.data->info->lng doubleValue]};
    NearbyMapViewController *mapViewController = [[NearbyMapViewController alloc] init];

    
    CustomNavigationController *nav = [[CustomNavigationController alloc]initWithRootViewController:mapViewController];
    
    [self.navigationController presentViewController:nav animated:YES completion:^{
        [mapViewController setMapAreaWithCenter:loct withTitle:self.data->info->title withUserPosition:NO];
    }];
    
    //[self.navigationController pushViewController:mapViewController animated:NO];
}
- (IBAction)addStore:(id)sender {
    NSString *path = [storeView copy];
    User *user = [[LocalCache sharedCache] cachedObjectForKey:@"user"];
    if( user == nil || user.isLoginSuccess == NO){
        DDMenuController *ddMenuController = [(AppDelegate *)[UIApplication sharedApplication].delegate menuController];
        [ddMenuController showRightController:YES];
        [(RightViewController*)(ddMenuController.rightViewController) loginBtnClick:nil];
        return;
    }
    NSString *userid = user.userId;
    path = [path stringByAppendingFormat:@"?viewId=%@&userId=%@", self.idStr, userid];
    [HTTPAPIConnection postPathToGetJson:(NSString*)path
                                   block:^(NSDictionary *json, NSError *error)
     {
         if(error){
             [AlertViewHandle showAlertViewWithMessage:
              [NSString stringWithFormat:@"收藏失败，原因:%@", [error domain]]];
         }else{
             if ([[json objectForKey:@"code"] isEqualToString: @"71"]) {
                 [AlertViewHandle showAlertViewWithMessage:@"收藏成功"];
             }else if([[json objectForKey:@"code"] isEqualToString: @"72"]){
                 [AlertViewHandle showAlertViewWithMessage:@"重复收藏该条信息"];
             }else if([[json objectForKey:@"code"] isEqualToString: @"81"]){
                 [AlertViewHandle showAlertViewWithMessage:@"已经过时不能领取啦"];
             }
         }
     }];
}
- (IBAction)onDownloadAudioBtnClicked:(id)sender {
    EmbedReaderViewController *scan = [[EmbedReaderViewController alloc] init];
    scan.voiceId = self.idStr;
    [self.navigationController pushViewController:scan animated:NO];
}

@end
