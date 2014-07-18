//
//  OtherSceneViewController.m
//  PudongTravel
//
//  Created by jiangjunli on 14-3-25.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "OtherSceneViewController.h"
#import "ScenicSpotViewController.h"
#import "SuggestionTable.h"
#import "OtherTableView.h"
#import "PullTableView.h"
#import "UIView+FitVersions.h"
#import "Appdelegate.h"
#import "UIView+FrameHandle.h"
//使用两个Table，在点击上面两个按钮的时候，将其中一个隐藏，并且重新加载或者现实另一个
@interface OtherSceneViewController ()<PullTableViewDelegate>
@property (strong, nonatomic) IBOutlet OtherTableView *rightTableView;
@property (weak, nonatomic) IBOutlet UIButton *otherSceneButton;
@property (weak, nonatomic) IBOutlet UIButton *suggestionButton;

@property (strong, nonatomic) IBOutlet SuggestionTable *leftTableView;
@property (weak, nonatomic) IBOutlet UIImageView *LineImage;
@property (weak, nonatomic) IBOutlet UIView *contetView;

@end

@implementation OtherSceneViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    ((UILabel*)self.navigationItem.titleView).text = @"更多景点";  //设置标题
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (IOS7) {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"top_background.png"] forBarMetrics:UIBarMetricsDefault];
    }else{
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"top44.png"] forBarMetrics:UIBarMetricsDefault];
    }
    
    self.leftTableView.navController = self.navigationController;
    self.rightTableView.navController = self.navigationController;
}
- (void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if (IOSVersion70)
    {
        [self.contetView FitViewOffsetY];
    }
    
    [self initLeftTable:self.leftTableView];
    [self initRightTable:self.rightTableView];
    [self showLeftTable];

    self.rightTableView.hidden = YES;
    
    if (!IS_IPHONE5) {
        self.leftTableView.height = 370;
        self.rightTableView.height = 370;
    }
}

-(void) initLeftTable:(SuggestionTable*)tableView{
    tableView.dataSource = (id)tableView;
    tableView.delegate = (id)self;
    tableView.pullDelegate = self;

    tableView.backgroundColor = [UIColor clearColor];
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

-(void) initRightTable:(OtherTableView*)table{
    table.delegate = (id)self;
    table.dataSource = (id)table;
    table.pullDelegate = self;
    
    table.backgroundColor = [UIColor clearColor];
    [table setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}


-(void)showLeftTable{
    self.leftTableView.hidden = NO;
    self.rightTableView.hidden = !self.leftTableView.hidden;
    if(self.leftTableView.inited == NO){
        self.leftTableView.inited = YES;
        [HUDHandle startLoadingWithView:nil];
        [self.leftTableView loadDataFromWeb:NO];
    }else{
        [self.leftTableView reloadData];
    }
}
-(void)showRightTable{
    self.leftTableView.hidden = YES;
    self.rightTableView.hidden = !self.leftTableView.hidden;
    if(self.rightTableView.inited == NO){
        self.rightTableView.inited = YES;
        [HUDHandle startLoadingWithView:nil];
        [self.rightTableView loadDataFromWeb:NO];
    }else{
        [self.rightTableView reloadData];
    }
}

#pragma mark – eventHandler

- (IBAction)suggestionButtonClicked:(UIButton *)sender {
    for(UIView *view in [self.view subviews]){
        if(view.tag == 999){
           [view removeFromSuperview];
        }
    }
    [self.suggestionButton setBackgroundImage:[UIImage imageNamed:@"icon_recommend_s.png"] forState:UIControlStateNormal];
    [self.otherSceneButton setBackgroundImage:[UIImage imageNamed:@"icon_qita.png"] forState:UIControlStateNormal];
    self.LineImage.frame = CGRectMake(0, 41, 160, 2);
    [self showLeftTable];
}
- (IBAction)otherSceneButtonClicked:(id)sender {
    [self.suggestionButton setBackgroundImage:[UIImage imageNamed:@"icon_recommend.png"] forState:UIControlStateNormal];
    [self.otherSceneButton setBackgroundImage:[UIImage imageNamed:@"icon_qita_s.png"] forState:UIControlStateNormal];
     self.LineImage.frame = CGRectMake(160, 41, 160, 2);
    [self showRightTable];
}

//下拉刷新在这个类中接收，传递给左右两个table ，让显示出来的那个table更新数据
#pragma mark - PullTableViewDelegate
- (void)pullTableViewDidTriggerRefresh:(PullTableView *)pullTableView{
    [HUDHandle startLoadingWithView:nil];
    [self performSelector:@selector(refreshTable) withObject:nil afterDelay:1.0f];
    //    [MainViewCell updateBoolsWithType:kTableType];
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView *)pullTableView{
    [HUDHandle startLoadingWithView:nil];
    [self performSelector:@selector(loadMoreDataToTable) withObject:nil afterDelay:1.0f];
}

-(void)refreshTable{
    BOOL more = NO;
    if(self.leftTableView.hidden){
        if(self.rightTableView.pullTableIsLoadingMore == YES){
            self.rightTableView.pullTableIsRefreshing = NO;
            return;
        }else{
            [self.rightTableView loadDataFromWeb:more];
        }
    }else{
        if(self.leftTableView.pullTableIsLoadingMore == YES){
            self.leftTableView.pullTableIsRefreshing = NO;
            return;
        }else{
            [self.leftTableView loadDataFromWeb:more];
        }
    }
}
-(void)loadMoreDataToTable{
    BOOL more = YES;
    if(self.leftTableView.hidden){
        if(self.rightTableView.pullTableIsRefreshing == YES){
            self.rightTableView.pullTableIsLoadingMore = NO;
            return;
        }else{
            [self.rightTableView loadDataFromWeb:more];
        }
    }else{
        if(self.leftTableView.pullTableIsRefreshing == YES){
            self.leftTableView.pullTableIsLoadingMore = NO;
            return;
        }else{
            [self.leftTableView loadDataFromWeb:more];
        }
    }
}

@end
