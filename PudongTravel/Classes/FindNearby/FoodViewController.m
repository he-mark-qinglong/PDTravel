//
//  FoodViewController.m
//  pudongapp
//
//  Created by jiangjunli on 14-2-14.
//  Copyright (c) 2014年 jiangjunli. All rights reserved.
//

#import "FoodViewController.h"
#import "FoodCell.h"
#import "NearbyViewController.h"
#import "ScenicSpotViewController.h"
#import "NearbyMap/NearbyMapViewController.h"

#import "OtherTable_Nearby.h"
#import "CommonHeader.h"
#import "CustomNavigationController.h"
#import "UIView+FitVersions.h"
#import "UIView+FrameHandle.h"

@interface FoodViewController ()<PullTableViewDelegate>
@property (weak, nonatomic) IBOutlet OtherTable_Nearby *suggestionTable;
@property (weak, nonatomic) IBOutlet OtherTable_Nearby *distanceTable;

@property (weak, nonatomic) IBOutlet UIButton *recommendButton;
@property (weak, nonatomic) IBOutlet UIButton *recentlyButton;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet UIImageView *tabCurrenimage;

@end

@implementation FoodViewController
@synthesize recommendButton = recommendButton, recentlyButton = recentlyButton;

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    static NSDictionary *titleDic = nil;
    if(titleDic == nil)
        titleDic = @{@(JingQuVC):@"景区", @(YuLeVC):@"娱乐",
                     @(ShoppingVC):@"购物", @(ZhuSuVC):@"住宿",
                     @(FoodVC):@"美食",  @(LvXingSheVC):@"旅行社"};
    ((UILabel*)self.navigationItem.titleView).text = titleDic[@(self._vcType)];
}
- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self.contentView FitViewOffsetY];
    self.navigationItem.rightBarButtonItem = [(CustomNavigationController*)self.navigationController
                                              navBarItemWithTarget:self
                                              action:@selector(mapButtonClicked:)
                                              imageName:@"icon_map.png"];
    if (!IS_IPHONE5) {
        self.view.frame = CGRectMake(0, 64, 320, 568-64);
        self.distanceTable.height = 360;
        self.suggestionTable.height = 370;
    }
    
    [self initPullTable:self.suggestionTable];
    self.suggestionTable.isPush = YES;  // 获取数据的时候，是否是推荐，有两份数据表，下同.
    [self initPullTable:self.distanceTable];
    self.distanceTable.isPush = NO;
    
    //两个table的选择按钮消息观察
    [[self.recentlyButton rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(id x) {
         [self showRightTable];
         
     }];
    [[self.recommendButton rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(id x) {
         [self showLeftTable];
     }];
    [self showLeftTable];  //只在首次加载的时候显示左边的列表，因为如果是返回，应当保持原状
}

-(void)showTable:(OtherTable_Nearby*)table{
    table.vctype = self._vcType;
    if(table.inited == NO){
        table.inited = YES;
        [HUDHandle startLoadingWithView:nil];
        [table loadDataFromWeb:NO];
    }else{
        [table reloadData];
    }
}
-(void) initPullTable:(OtherTable_Nearby *)table{
    table.delegate = (id)self;
    table.dataSource = (id)table;
    table.backgroundColor = [UIColor clearColor];
    [table setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    table.pullDelegate = self;
    
    table.navController = self.navigationController;
}
-(void)showLeftTable{
    self.distanceTable.hidden = !(self.suggestionTable.hidden = NO);
    [self showTable:self.suggestionTable ];
    
    self.tabCurrenimage.frame = CGRectMake(0, 49, 160, 2);
    [self.recentlyButton setBackgroundImage:[UIImage imageNamed:@"icon_recently.png"]
                                   forState:UIControlStateNormal];
    [self.recommendButton setBackgroundImage:[UIImage imageNamed:@"icon_recommend_s.png"]
                                    forState:UIControlStateNormal];
}
-(void)showRightTable{
    self.distanceTable.hidden = !(self.suggestionTable.hidden = YES);
    [self showTable:self.distanceTable];
    
    self.tabCurrenimage.frame = CGRectMake(160, 49, 160, 2);
    [self.recentlyButton setBackgroundImage:[UIImage imageNamed:@"icon_recently_s.png"]
                                   forState:UIControlStateNormal];
    [self.recommendButton setBackgroundImage:[UIImage imageNamed:@"icon_recommend.png"]
                                    forState:UIControlStateNormal];
}
//右上角的地图图标，不在nib文件里面
- (void)mapButtonClicked:(id)sender {
    NearbyMapViewController *mapViewController = [[NearbyMapViewController alloc] init];
    [self.navigationController pushViewController:mapViewController animated:YES];
}

//下拉刷新在这个类中接收，传递给左右两个table ，让显示出来的那个table更新数据
#pragma mark - PullTableViewDelegate
- (void)pullTableViewDidTriggerRefresh:(PullTableView *)pullTableView{
    [self performSelector:@selector(refreshTable) withObject:nil afterDelay:1.0f];
}
- (void)pullTableViewDidTriggerLoadMore:(PullTableView *)pullTableView{
    [self performSelector:@selector(loadMoreDataToTable) withObject:nil afterDelay:1.0f];
}

-(void)refreshTable{
    BOOL more = NO;
    if(self.suggestionTable.hidden){
        if(self.distanceTable.pullTableIsLoadingMore == YES){
            self.distanceTable.pullTableIsRefreshing = NO;
            return;
        }else{
            [HUDHandle startLoadingWithView:nil];
            [self.distanceTable loadDataFromWeb:more];
        }
    }else{
        if(self.suggestionTable.pullTableIsLoadingMore == YES){
            self.suggestionTable.pullTableIsRefreshing = NO;
            return;
        }else{
            [HUDHandle startLoadingWithView:nil];
            [self.suggestionTable loadDataFromWeb:more];
        }
    }
}
-(void)loadMoreDataToTable{
    BOOL more = YES;
    if(self.suggestionTable.hidden){
        if(self.distanceTable.pullTableIsRefreshing == YES){
            self.distanceTable.pullTableIsLoadingMore = NO;
            return;
        }else{
            [HUDHandle startLoadingWithView:nil];
            [self.distanceTable loadDataFromWeb:more];
        }
    }else{
        if(self.suggestionTable.pullTableIsRefreshing == YES){
            self.suggestionTable.pullTableIsLoadingMore = NO;
            return;
        }else{
            [HUDHandle startLoadingWithView:nil];
            [self.suggestionTable loadDataFromWeb:more];
        }
    }
}
@end
