//
//  TravelSupermarketViewController.m
//  pudongapp
//
//  Created by jiangjunli on 14-2-17.
//  Copyright (c) 2014年 jiangjunli. All rights reserved.
//

#import "TravelSupermarketViewController.h"
#include "CommonHeader.h"

#import "TravelCell.h"
#import "TicketBookViewController.h"
#import "TravelMarketData.h"
#import "DetailsViewController.h"
#import "UIView+FitVersions.h"
#import "ScrollViewLoop.h"
#import "ScrollViewLoopImageItem.h"

#import "HUDHandle.h"

@interface TravelSupermarketViewController ()<PullTableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *mycontentView;
@property (weak, nonatomic) IBOutlet  PullTableView*travelTabelView;
@property (strong, nonatomic) TravelMarketData *data;
@property (strong, nonatomic) NSMutableArray *infoArray;
@property NSInteger pageNo;
@property (strong, nonatomic)  ScrollViewLoop *scrollView;
@end

@implementation TravelSupermarketViewController
@synthesize scrollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    ((UILabel*)self.navigationItem.titleView).text  = @"旅游超市";  //设置标题
    if (IOS7) {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"top_background.png"]
                                                      forBarMetrics:UIBarMetricsDefault];
    }else{
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"top44.png"]
                                                      forBarMetrics:UIBarMetricsDefault];
    }
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

#pragma mark data
-(void)loadMoreDataFromWeb:(BOOL)more{
    if(!self.infoArray)
        self.infoArray = [[NSMutableArray alloc] init];
    if(more){
        self.pageNo++;
    }else{
        self.pageNo = 1;
        [self.infoArray removeAllObjects];
    }
    NSString *path = [NSString stringWithString:[getTravelList copy]];
    path = [path stringByAppendingString:
            [NSString stringWithFormat:@"?pageNum=%d",self.pageNo]];
    [HTTPAPIConnection postPathToGetJson:(NSString*)path block:^(NSDictionary *json, NSError *error){
        if([json objectForKey:@"code"]){
            self.pageNo--;
            [self.travelTabelView reloadData];
            return;
        }
        if(self.data == nil)
            self.data = [TravelMarketData new];
        [self.data updateWithJsonDic:json];
        [self.infoArray addObjectsFromArray:self.data->arrayTravelMarketDataInfo];
        
        [self.travelTabelView reloadData];
    }];
}

-(void)initPullTable{
    self.travelTabelView.dataSource = self;
    self.travelTabelView.delegate = (id)self;
    self.travelTabelView.backgroundColor = [UIColor clearColor];
    [self.travelTabelView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    self.travelTabelView.pullBackgroundColor = [UIColor clearColor];
    self.travelTabelView.pullDelegate = self;
    self.travelTabelView.pullTextColor = [UIColor colorWithRed:191.0 / 255.0
                                                         green:191.0 / 255.0
                                                          blue:191.0 / 255.0 alpha:1];
    
    if (!IS_IPHONE5) {
        self.travelTabelView.frame = CGRectMake(self.travelTabelView.frame.origin.x, self.travelTabelView.frame.origin.y, self.travelTabelView.frame.size.width, 285.f);
    }
    
    if (IOSVersion70 && !IS_IPHONE5)
    {
        [self.travelTabelView moveDownY:-40];
    }
}
- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self initPullTable];
    [HUDHandle startLoadingWithView:nil];
    [self loadMoreDataFromWeb:NO];
    
    [self.navigationController.navigationBar setBackgroundImage:
    [UIImage imageNamed:@"top_background.png"] forBarMetrics:UIBarMetricsDefault];

    [self.mycontentView FitViewOffsetY];
    if (IOSVersion70) {
        [self.travelTabelView moveDownY:-40];
    }
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    // Return the number of sections.
    return 1;
}
#pragma mark - UITableViewDelegate UITableViewDataSource methods
- (NSInteger)tableView:(UITableView *)tableView   numberOfRowsInSection:(NSInteger)section{
    // Return the number of rows in the section.
    self.travelTabelView.pullTableIsLoadingMore = NO;
    self.travelTabelView.pullTableIsRefreshing = NO;
    [HUDHandle stopLoading];
    
    return [self.infoArray count];
}
- (CGFloat)tableView:(UITableView *)tableView     heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}
- (UITableViewCell *)tableView:(UITableView *)tableView  cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSUInteger row = [indexPath row];
    static NSString *CellIdentifier = @"TravelCell";
    TravelCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TravelCell" owner:self options:nil] lastObject];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    
    TravelMarketDataInfo * info = [self.infoArray objectAtIndex:row];
    [cell setContent:info];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailsViewController *dvc = [[DetailsViewController alloc]init];
//    [self presentViewController:dvc animated:NO completion:nil];
    TravelMarketDataInfo * info = [self.infoArray objectAtIndex:indexPath.row];
    dvc.title = info->title;
    dvc.travelId = info->travelId;
    NSLog( @"%@",dvc.travelId);
    dvc.viewId = info->viewId;
    [self.navigationController pushViewController:dvc animated:YES];
}
- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - PullTableViewDelegate
- (void)pullTableViewDidTriggerRefresh:(PullTableView *)pullTableView{
    [HUDHandle startLoadingWithView:nil];
    [self performSelector:@selector(refreshTable) withObject:nil afterDelay:1.0f];
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView *)pullTableView{
    [HUDHandle startLoadingWithView:nil];
    [self performSelector:@selector(loadMoreDataToTable) withObject:nil afterDelay:1.0f];
}
-(void)refreshTable{
    [self loadMoreDataFromWeb:NO];
}
-(void)loadMoreDataToTable{
    [self loadMoreDataFromWeb:YES];
}
@end
