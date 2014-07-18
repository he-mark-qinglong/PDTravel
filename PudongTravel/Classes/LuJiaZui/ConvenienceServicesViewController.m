//
//  ConvenienceServicesViewController.m
//  pudongapp
//
//  Created by jiangjunli on 14-2-18.
//  Copyright (c) 2014年 jiangjunli. All rights reserved.
//

#import "ConvenienceServicesViewController.h"
#import "CommonHeader.h"
#import "NearbyMapViewController.h"
#import "CustomNavigationController.h"

@interface ConvenienceServicesViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIButton *personalInfoBtn;

@end

@implementation ConvenienceServicesViewController

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
    ((UILabel*)self.navigationItem.titleView).text = @"便民服务";
}
- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.webView.delegate = self;
    self.webView.hidden   = YES;
    
    self.personalInfoBtn.hidden = YES;
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
    
    /*
     [webView goBack];
     [webView goForward];
     [webView reload];//重载
     [webView stopLoading];//取消载入内容
     */
}

- (IBAction)jiaoJing:(id)sender {
//    NearbyMapViewController *map = [NearbyMapViewController new];
//    map.willShowUserLocation = YES;
//    [self.navigationController pushViewController:map animated:YES];

    NearbyMapViewController *mapViewController = [[NearbyMapViewController alloc] init];
    mapViewController.willShowUserLocation     = YES;
    
    CustomNavigationController *nav = [[CustomNavigationController alloc]initWithRootViewController:mapViewController];
    [self.navigationController presentViewController:nav animated:YES completion:^{
        [mapViewController showSevenPop];
        [self performSelector:@selector(setupMapScale:) withObject:mapViewController afterDelay:1.0];
    }];
}
-(void)setupMapScale:(id)sender{
    NearbyMapViewController *mapViewController = (NearbyMapViewController*)sender;
     [mapViewController setMapCircle:50];  //单位:km,半径显示

}
@end
