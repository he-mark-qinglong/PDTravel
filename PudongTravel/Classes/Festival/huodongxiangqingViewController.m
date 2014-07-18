//
//  huodongxiangqingViewController.m
//  pudongapp
//
//  Created by jiangjunli on 14-3-1.
//  Copyright (c) 2014年 jiangjunli. All rights reserved.
//

#import "huodongxiangqingViewController.h"
#import "CommonHeader.h"
#import "FestivalData.h"
#import "UIView+FitVersions.h"

@interface huodongxiangqingViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webview;

@property (weak, nonatomic) IBOutlet UITextView *contentText;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (weak, nonatomic) IBOutlet UIImageView *mainImg;

@property (weak, nonatomic) IBOutlet UILabel *contentTitle;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *openTime;
@property (weak, nonatomic) IBOutlet UILabel *telNumber;

@property (weak, nonatomic) IBOutlet UITextView *driveWay;


@end

@implementation huodongxiangqingViewController

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
    ((UILabel*)self.navigationItem.titleView).text = @"活动详情";  //设置标题
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.scrollview FitViewOffsetY];
    
    UIFont *font           = [UIFont fontWithName:@"Arial" size:14];
    self.contentText.font = font;
    CGRect rect = self.scrollview.frame;
    self.scrollview.contentSize = CGSizeMake(300, rect.size.height + 300);
    if (!IS_IPHONE5) {
        self.scrollview.frame = CGRectMake(10, 160, 300, rect.size.height-10);
    }
    
    [self updateDataFromWebWithId:self.actId];
}
-(void)updateDataFromWebWithId:(NSString*)actId{
    NSString *path;
    if(self.path == nil || [self.path isEqualToString:@""]){
        path = [getActivityDetail copy];
        NSString *appendStr = [NSString stringWithFormat:@"?activityId=%@",actId];
        path = [path stringByAppendingString:appendStr];
    }else{
        path = self.path;
    }
    
    void (^parseJson)(NSDictionary *json, NSError *error) = ^(NSDictionary *json, NSError *error) {
        FestivalDetail *data = [FestivalDetail new];
        [data updateWithJsonDic:json];
        [self setupUI:data->info ];
    };
    [HTTPAPIConnection postPathToGetJson:path block:parseJson];
    
    [PictureHelper addPicture:self.imgPath to:self.mainImg
                     withSize:CGRectMake(0, 0, 320, 160)];
}

-(void)setupUI:(FestivalDetailInfo *)info{
    self.contentText.text = info->remark;
    NSString *htmlStr =  [NSString stringWithFormat:@"<html> \n"
                          "<head> \n"
                          "<style type=\"text/css\"> \n"
                          "body {font-size: %@; color: %@;}\n"
                          "</style> \n"
                          "</head> \n"
                          "<body>%@</body> \n"
                          "</html>",@"13", @"white", info->remark ];

    [self.webview loadHTMLString:htmlStr baseURL:nil];

    
    self.contentTitle.text = info->title;
    
    self.address.text = info->address;
    self.openTime.text = info->activityTime;
    self.driveWay.text = info->trafic;
    self.telNumber.text = info->phone;
}

- (IBAction)backbtnclick:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
