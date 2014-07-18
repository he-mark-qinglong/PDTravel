//
//  SetUpViewController.m
//  pudongapp
//
//  Created by jiangjunli on 14-2-18.
//  Copyright (c) 2014年 jiangjunli. All rights reserved.
//

#import "SetUpViewController.h"
#import "UIView+FitVersions.h"
#import "UIImage+loadImage.h"
#import "SetingCell.h"
#import "AlertViewHandle.h"

@interface SetUpViewController ()<UITableViewDataSource,UITableViewDelegate, UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *image;

@end

@implementation SetUpViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)onBtnClicked:(id)sender {
    if(self.contentView.hidden == YES){
        UIWindow *mainWindow = [UIApplication sharedApplication].delegate.window;
        [mainWindow makeKeyAndVisible];
    }else{//显示回列表
        self.contentView.hidden = YES;
    }
}


- (void)viewDidLoad{
    [super viewDidLoad];
    
  
    self.contentView.hidden   = YES;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView setSeparatorColor:[UIColor whiteColor]];
    [self.tableView setSeparatorStyle: UITableViewCellSeparatorStyleNone ];
    
    [self.tableView reloadData];
}
#pragma mark UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView  cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSUInteger row = [indexPath row];
    
    return [SetingCell cellAtIndex:row];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     NSString *url;
    
    switch (indexPath.row) {
        case 0:
            self.contentView.hidden = NO;
            self.nameLabel.text = @" 官方微信";
            self.image.image = [UIImage imageNamed:@"wx.png"];
            break;
        case 1:
            url = @"http://weibo.com/u/3212385172";
           [self loadWebPageWithString:url];

            break;
        case 2:
            [AlertViewHandle showAlertViewWithMessage:@"当前版本为最新版本！"];
            break;
        
        default:
            break;
    }

    
}
-(void)updateVersion
{
  
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
   
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@",appleID]]];
   
    [request setHTTPMethod:@"GET"];
   
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSDictionary *releaseInfo = [NSJSONSerialization JSONObjectWithData:returnData options:0 error:nil];
    NSString *latestVersion = [releaseInfo objectForKey:@"version"];
  
    NSString *trackViewUrl1 = [releaseInfo objectForKey:@"trackViewUrl"];//地址trackViewUrl
   
    NSString *trackName = [releaseInfo objectForKey:@"trackName"];//trackName

    NSString *currentVersion = [releaseInfo objectForKey:@"CFBundleVersion"];
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
//    NSString *currentVersion = [infoDict objectForKey:@"CFBundleVersion"];
    double doubleCurrentVersion = [currentVersion doubleValue];
    double doubleUpdateVersion = [latestVersion doubleValue] ;
    if (doubleCurrentVersion < doubleUpdateVersion) {
        
        UIAlertView *alert;
        alert = [[UIAlertView alloc] initWithTitle:trackName
                                           message:@"有新版本，是否升级！"
                                          delegate: self
                                 cancelButtonTitle:@"取消"
                                 otherButtonTitles: @"升级", nil];
        alert.tag = 1001;
        [alert show];
    }else{
        UIAlertView *alert;
        alert = [[UIAlertView alloc] initWithTitle:trackName
                                           message:@"暂无新版本"
                                          delegate: nil
                                 cancelButtonTitle:@"好的"
                                 otherButtonTitles: nil, nil];
        [alert show];
    }
}


#pragma mark - AertView delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex

{
    
    if (buttonIndex == 1) {
        
        //去appstore中更新
        
        //方法一：根据应用的id打开appstore，并跳转到应用下载页面
        
       NSString *appStoreLink = [NSString stringWithFormat:@"http://itunes.apple.com/cn/app/id%@",appleID];
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appStoreLink]];
        
        
        
        //方法二：直接通过获取到的url打开应用在appstore，并跳转到应用下载页面
        
        //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:updateURL]];
        
        
        
    } else if (buttonIndex == 2) {
        
        //去itunes中更新
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms://itunes.apple.com/cn/app/guang-dian-bi-zhi/id511587202?mt=8"]];
        
    }
    
    
    
}

- (void)loadWebPageWithString:(NSString*)urlString
{

    NSURL *url =[NSURL URLWithString:urlString];
    NSLog(@"url:\n%@", urlString);
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    
    
    self.webView.scalesPageToFit = YES;  //自动对页面进行缩放以适应屏幕
    //    self.webView.detectsPhoneNumbers = YES;  //自动检测网页上的电话号码，单击可以拨打
    [self.webView loadRequest:request];
    self.webView.hidden = NO;
    [self.webView reload];//重载
}


@end
