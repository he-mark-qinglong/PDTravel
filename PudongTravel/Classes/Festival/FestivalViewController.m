//
//  FestivalViewController.m
//  pudongapp
//
//  Created by jiangjunli on 14-2-20.
//  Copyright (c) 2014年 jiangjunli. All rights reserved.
//

#import "FestivalViewController.h"
#import "FestivalCell.h"
#import "huodongxiangqingViewController.h"
#import "FestivalData.h"
#import "PullTableView.h"
#import "CommonHeader.h"
#import "UIView+FitVersions.h"

@interface FestivalViewController ()<UITableViewDataSource,UITableViewDelegate, PullTableViewDelegate>
@property (weak, nonatomic) IBOutlet PullTableView *festivalTabelView;
@property (strong, nonatomic) FestivalData *data;
@property (strong, nonatomic) NSMutableArray *arrayToShow;
@property NSUInteger pageNo;
@end

@implementation FestivalViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    ((UILabel*)self.navigationItem.titleView).text = @"节庆活动";  //设置标题
}
-(void)viewWillAppear:(BOOL)animated{
    if (IOS7) {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"top_background.png"] forBarMetrics:UIBarMetricsDefault];
        
    }
    else{
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"top44.png"] forBarMetrics:UIBarMetricsDefault];
    }
}
- (void)viewDidLoad{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    self.festivalTabelView.delegate = self;
    self.festivalTabelView.dataSource = self;
    self.festivalTabelView.backgroundColor = [UIColor clearColor];
    self.festivalTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.festivalTabelView.pullDelegate = self;
    
    [self.festivalTabelView FitViewOffsetY];
    [HUDHandle startLoadingWithView:nil];
    [self loadMoreDataFromWeb:NO];
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section{
    self.festivalTabelView.pullTableIsLoadingMore = NO;
    self.festivalTabelView.pullTableIsRefreshing = NO;
    
    [HUDHandle stopLoading];
    // Return the number of rows in the section.
    return self.arrayToShow.count;
}
- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 165;
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"FestivalCell";
    //自定义cell类
    FestivalCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        //通过xib的名称加载自定义的cell
        cell = [[[NSBundle mainBundle] loadNibNamed:@"FestivalCell" owner:self options:nil] lastObject];
    }
    //  NSUInteger row = [indexPath row];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    int row = indexPath.row;
    FestivalInfo *anInfo = [self.arrayToShow objectAtIndex:row];
    [cell setContent:anInfo];
    return cell;
}
- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    huodongxiangqingViewController *hdcqvc = [[huodongxiangqingViewController alloc]init];
    FestivalInfo *info = [self.arrayToShow objectAtIndex:indexPath.row];
    hdcqvc.actId       = info->activityId;
    hdcqvc.imgPath     = info->imgUrl;
//    [self presentViewController:hdcqvc animated:NO completion:nil];
    [self.navigationController pushViewController: hdcqvc animated:YES];
}

#pragma mark - PullTableViewDelegate
- (void)pullTableViewDidTriggerRefresh:(PullTableView *)pullTableView{
    if(self.festivalTabelView.pullTableIsLoadingMore == YES){
        self.festivalTabelView.pullTableIsRefreshing = NO;
        return;
    }
    [HUDHandle startLoadingWithView:nil];
    [self performSelector:@selector(refreshTable) withObject:nil afterDelay:1.0f];
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView *)pullTableView{
    if(self.festivalTabelView.pullTableIsRefreshing  == YES){
        self.festivalTabelView.pullTableIsLoadingMore = NO;
        return;
    }
    [HUDHandle startLoadingWithView:nil];
    [self performSelector:@selector(loadMoreDataToTable) withObject:nil afterDelay:1.0f];
}

-(void)refreshTable{
    
    [self loadMoreDataFromWeb:NO];
}
-(void)loadMoreDataToTable{
    
    [self loadMoreDataFromWeb:YES];
}

#pragma mark data
-(void)loadMoreDataFromWeb:(BOOL)more{
    if(!self.arrayToShow)
        self.arrayToShow = [[NSMutableArray alloc] init];
    if(more){
        self.pageNo++;
    }else{
        self.pageNo = 1;
        [self.arrayToShow removeAllObjects];
    }
    NSString *path = [NSString stringWithString:(NSString*)getActivityList];
    path = [path stringByAppendingString:
            [NSString stringWithFormat:@"?pageNum=%d",self.pageNo]];
    [HTTPAPIConnection postPathToGetJson:(NSString*)path block:^(NSDictionary *json, NSError *error){
        if([json objectForKey:@"code"]){
            self.pageNo--;
            [self.festivalTabelView reloadData];
            return;
        }
        if(self.data == nil)
            self.data = [FestivalData new];
        [self.data updateWithJsonDic:json];
        [self.arrayToShow addObjectsFromArray:self.data->arrayFestivalInfo];
        
        [self.festivalTabelView reloadData];
    }];
}

@end
