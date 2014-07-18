//
//  MenuController.m
//  pudongapp
//
//  Created by jiangjunli on 14-1-7.
//  Copyright (c) 2014年 jiangjunli. All rights reserved.

#import "MenuController.h"
#import "UIView+FitVersions.h"
#import "ScrollViewLoop.h"
#import "ScrollViewLoopImageItem.h"
#import "CommonHeader.h"

#import "SoundDownLoadViewController.h"
#import "WWGImagePickerViewController.h"
#import "NearbyMapViewController.h"

#import "huodongxiangqingViewController.h"
#import "ScenicSpotViewController.h"
#import "MenuModel.h"


@interface MenuController ()<ScrollViewLoopDelegate>
@property MainPageData *data;

@property (weak, nonatomic) IBOutlet UIButton *lujiazuibtn;
@property (weak, nonatomic) IBOutlet UIButton *sbyqbtn;
@property (weak, nonatomic) IBOutlet UIButton *zfjbtn;
@property (weak, nonatomic) IBOutlet UIButton *jrhdbtn;
@property (weak, nonatomic) IBOutlet UIButton *mfqpbtn;
@property (weak, nonatomic) IBOutlet UIButton *lycsbtn;
@property (weak, nonatomic) IBOutlet UIButton *moreScenicbtn;
@property (weak, nonatomic) IBOutlet UIButton *specialTravelbtn;


@property (weak, nonatomic) IBOutlet UIScrollView *contenScrollView;
@property (weak, nonatomic) IBOutlet UIView *subView;
@property (strong, nonatomic)  ScrollViewLoop *scrollView;

@property WWGImagePickerViewController* imagePickerController;
@end

@implementation MenuController
@synthesize contenScrollView,scrollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (IOS7) {
        [self.navigationController.navigationBar
         setBackgroundImage:[UIImage imageNamed:@"top_travel.png"] forBarMetrics:UIBarMetricsDefault];
    }else{
        [self.navigationController.navigationBar
         setBackgroundImage:[UIImage imageNamed:@"top_bg44.png"] forBarMetrics:UIBarMetricsDefault];
    }
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    if (IOSVersion70){
        [self.subView FitViewOffsetY];
        [contenScrollView FitViewHeight];
    }
    [self createscrollView];
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    self.contenScrollView.scrollEnabled = YES;
    //设置是否显示水平滑动条
    self.contenScrollView.userInteractionEnabled =YES;
    self.contenScrollView.showsHorizontalScrollIndicator = NO;
    //设置是否显示垂直滑动条
    self.contenScrollView.showsVerticalScrollIndicator = NO;
    if (!IS_IPHONE5) {
        self.contenScrollView.contentSize = CGSizeMake(0, 514);
    }
    
    ftvc = [[FreeTicketViewController alloc]init];
    tsvc = [[TravelSupermarketViewController alloc]init];
    fvc  = [[FestivalViewController alloc]init];
    lvc  = [[lujiazuiViewController alloc]init];
    osvc = [[OtherSceneViewController alloc]init];
    mapvc = [[NearbyMapViewController alloc] init];
    
    @weakify(self);
    [[self.sbyqbtn rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(id x){
         @strongify(self);
         lvc.bigTitle = @"世博园区";
         [self.navigationController pushViewController:lvc animated:YES];
     }];
    [[self.zfjbtn rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(id x) {
         @strongify(self);
         mapvc.willShowUserLocation = YES;
         [self.navigationController pushViewController:mapvc animated:YES];
     }];
    [[self.jrhdbtn rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(id x) {
         @strongify(self);
         [self.navigationController pushViewController:fvc animated:YES];
     }];
    [[self.lujiazuibtn rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(id x) {
         @strongify(self);
         lvc.bigTitle = @"小陆家嘴";
         [self.navigationController pushViewController:lvc animated:YES];
     }];
    [[self.mfqpbtn rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(id x) {
         @strongify(self);
         [self.navigationController pushViewController:ftvc animated:YES];
     }];
    [[self.lycsbtn rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(id x) {
         @strongify(self);
         [self.navigationController pushViewController:tsvc animated:YES];
     }];
    [[self.moreScenicbtn rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(id x) {
         @strongify(self);
         [self.navigationController pushViewController:osvc animated:YES];
     }];
    [[self.specialTravelbtn rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(id x) {
         @strongify(self);
         lvc.bigTitle = @"特色旅游";
         [self.navigationController pushViewController:lvc animated:YES];
     }];
}

#pragma mark createscrollView
-(void)createscrollView
{
    NSString *path = [getCarouselList copy];
    path = [path stringByAppendingString:@"?pageNum=1"];
    [HTTPAPIConnection postPathToGetJson:path block:^(NSDictionary *json, NSError *error) {
        if(error || [json objectForKey:@"info"] == nil){
            self.scrollView = nil;
            return;
        }
        //        NSLog(@"menuController = %@",json);
        MainPageData *data = [MainPageData new];
        [data updateWithJsonDic:json];
        
        NSMutableArray *ScrollViewLoopImageItemArray = [NSMutableArray new];
        int index = 0;
        for(MainPageInfo *info in data->arrayMainPageInfo){
            ScrollViewLoopImageItem *item = [ScrollViewLoopImageItem new];
            item.imgUrl = info->imgUrl;
            item.tag = index++;
            item.image = nil;
            item.title = nil;
            [ScrollViewLoopImageItemArray addObject:item];
        }
        self.scrollView = [[ScrollViewLoop alloc] initWithFrame:CGRectMake(0, 0, 320, 129) delegate:self scrollViewLoopImageItemArray:ScrollViewLoopImageItemArray isAuto:YES];
        scrollView.backgroundColor = [UIColor clearColor];
        [self.subView addSubview:self.scrollView];
        
        self.data = data;
    }];
}

#pragma mark - ScrollLoopDelegate
- (void)foucusImageFrame:(ScrollViewLoop *)imageFrame didSelectItem:(ScrollViewLoopImageItem *)item
{
    MainPageInfo *info = [self.data->arrayMainPageInfo objectAtIndex:item.tag];
    if(info == nil)
        return;
    
    NSString *path = [getCarouselDetail copy];
    path = [path stringByAppendingString:
            [NSString stringWithFormat:@"?relationId=%@&carouselType=%@", info->relationId, info->carouselType]];
    
    if([info->carouselType isEqualToString:@"Activity"]){
        huodongxiangqingViewController *hdxqvc = [huodongxiangqingViewController new];
        hdxqvc.path = path;
        [self.navigationController pushViewController:hdxqvc animated:NO];
    }else{
        ScenicSpotViewController *ssvc = [ScenicSpotViewController new];
        ssvc.path = path;
        ssvc.merchantOrSceneTitleText = @"景点详情";
        [self.navigationController pushViewController:ssvc animated:NO];
    }
}
- (void)foucusImageFrame:(ScrollViewLoop *)imageFrame currentItem:(int)index;
{
    
}

@end
