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
#import "IntroductionViewController.h"
#import "ElseMainViewData.h"
#import "NearbyMap/NearbyMapViewController.h"


@interface ScenicSpotViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;
@property (weak, nonatomic) IBOutlet UIButton *wangyoudianpingbtn;
@property (weak, nonatomic) IBOutlet UILabel *telLabel;
@property (weak, nonatomic) IBOutlet UILabel *titlelabel;
@property BOOL isSeleced;
@property (weak, nonatomic) IBOutlet UIButton *frienddianping;
@property (weak, nonatomic) IBOutlet UIButton *alldianping;

@property (weak, nonatomic) IBOutlet UILabel *score;
@property (weak, nonatomic) IBOutlet UIImageView *mainPicture;

//user data
@property (strong, nonatomic) ViewDetailData *data;
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
#if 0
info:
    {
        id: "0710df5a9de54ea8b1afe24a5b6a44e3"
    imgUrl: http://192.168.43.66:8080/test/1.png
    grade: "5A"
    title: "TET"
    lat: "123.0"
    lng: "123.0"
    phone: "213"
    score: 4.5
    peopleWarn: "1"
    }
#endif
    self.telLabel.text = info->phone;
    self.titlelabel.text = info->title;
    self.score.text = info->score;
    [PictureHelper addPicture:info->imgUrl to:self.mainPicture];
}
-(void)loadDataFromWeb{
    NSString *path = [NSString stringWithString:(NSString*)getViewDetail];
    path = [path stringByAppendingString:
            [NSString stringWithFormat:@"?viewId = %@",self.idStr]];
    [HTTPAPIConnection postPathToGetJson:(NSString*)path
                                   block:^(NSDictionary *json, NSError *error){
                                       [self parseJson:json];
                                   }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadDataFromWeb];
// UINavigationController *nabigationcontroller = [[UINavigationController alloc]init];
//     [self.navigationController setNavigationBarHidden:YES];
    
    UIBarButtonItem *letfBarItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_return.png"] style:UIBarButtonItemStylePlain target:self action:@selector(letfbtnclick)];
    self.navigationItem.leftBarButtonItem = letfBarItem;
    
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_personal.png"] style:UIBarButtonItemStylePlain target:self action:@selector(rightbtnclick)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 40 , 100, 44)];
    titleLabel.backgroundColor = [UIColor clearColor];  //设置Label背景透明
    titleLabel.font = [UIFont boldSystemFontOfSize:16];  //设置文本字体与大小
    titleLabel.textColor = [UIColor whiteColor];  //设置文本颜色
    
    titleLabel.text = @"其他景点";  //设置标题
    self.navigationItem.titleView = titleLabel;

    
    

    wydpvc = [[wangyoudianpingViewController alloc]init];
    dpvc = [[dianpingViewController alloc]init];
   /*
    if (IS_IPHONE5) {
         self.contentScrollView.frame = CGRectMake(0, 0, 320, 568);
    }
    else
    {
         self.contentScrollView.frame = CGRectMake(0, 0, 320, 480);
    }
   */
    self.contentScrollView.contentSize = CGSizeMake(320,1137);
    self.contentScrollView.showsHorizontalScrollIndicator = NO;
    self.contentScrollView.showsVerticalScrollIndicator = YES;
    self.wangyoudianpingbtn.backgroundColor = [UIColor clearColor];
}

-(void)letfbtnclick
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)rightbtnclick{
    DDMenuController *ddMenuController = [(AppDelegate *)[UIApplication sharedApplication].delegate menuController];
    [ddMenuController showRightController:YES];
}
- (IBAction)backButtonclick:(id)sender{
    [self dismissViewControllerAnimated:NO completion:nil];
}

-(void)makeACall:(NSString*)phoneNum{// 电话号码
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

- (IBAction)telBtnClick:(id)sender {
    
    NSString *number =self.telLabel.text;// 此处读入电话号码
    
    // NSString *num = [[NSString alloc] initWithFormat:@"tel://%@",number]; //number为号码字符串 如果使用这个方法 结束电话之后会进入联系人列表
    
    [self makeACall:number];
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.cppblog.com"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)wydpBtnClick:(id)sender {
 //  [self presentViewController:wydpvc animated:NO completion:nil];
    dpvc.idStr = self.data->info->id;
[self presentViewController:dpvc animated:NO completion:nil];
//  [self.navigationController pushViewController:wydpvc animated:YES];
}
- (IBAction)souyoupinglunclick:(id)sender {
    [self presentViewController:wydpvc animated:NO completion:nil];
}

- (IBAction)menpiaoBtnClick:(id)sender {
    TicketBookViewController *tbvc = [[TicketBookViewController alloc]init];
    [self presentViewController:tbvc animated:NO completion:nil];
}
- (IBAction)merchantMessage:(id)sender {
    IntroductionViewController *ivc = [[IntroductionViewController alloc]init];
    ivc.idStr = self.data->info->id;
    [self.navigationController pushViewController:ivc animated:YES];
}
- (IBAction)onLocateBtnClicked:(id)sender {
    NearbyMapViewController *mapViewController = [[NearbyMapViewController alloc] init];
    
    CLLocationCoordinate2D loct = {
        [self.data->info->lat doubleValue],
        [self.data->info->lng doubleValue]};
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:mapViewController];
    // [[self viewController] presentViewController:mapViewController animated:YES completion:nil];
    [self presentViewController:nav animated:YES completion:^{
        [mapViewController setMapCenter:loct];
    }];
    
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
    path = [path stringByAppendingString:
            [NSString stringWithFormat:@"?viewId=%@&userId = %@",self.idStr,userid]];
    [HTTPAPIConnection postPathToGetJson:(NSString*)path
                                   block:^(NSDictionary *json, NSError *error)
     {
         [self parseJson:json];
         if(error){
             [AlertViewHandle showAlertViewWithMessage:
              [NSString stringWithFormat:@"收藏失败，原因:%@", [error domain]]];
         }else{
             [AlertViewHandle showAlertViewWithMessage:@"收藏成功"];
         }
     }];

}

@end
