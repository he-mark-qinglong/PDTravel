//
//  SetUpViewController.m
//  pudongapp
//
//  Created by jiangjunli on 14-2-18.
//  Copyright (c) 2014年 jiangjunli. All rights reserved.
//

#import "SetUpViewController.h"
#import "UIView+FitVersions.h"
#import "SetingCell.h"
@interface SetUpViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SetUpViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    if (IOSVersion70)
    {
        [self.tableView FitViewOffsetY];
    }
    
   }
#pragma mark UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView  cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSUInteger row = [indexPath row];

    
    
    return [SetingCell cellAtIndex:row];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
     UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, 424)];
    if (IS_IPHONE5) {
        webView.frame=CGRectMake(0, 0, 320, 504);
    }
     NSString *url=@"";
    switch (indexPath.row) {
        case 0:
          url=@"http://www.baidu.com";
            break;
        case 1:
            url=@"";
            break;
        case 2:
            url=@"";
            break;
        case 3:
            url=@"";
            break;
        
        default:
            break;
    }
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [self.view addSubview: webView];
    [webView loadRequest:request];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
