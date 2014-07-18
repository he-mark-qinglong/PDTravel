//
//  DetailsViewController.m
//  PudongTravel
//
//  Created by jiangjunli on 14-3-31.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "DetailsViewController.h"
#import "CommonHeader.h"

#import "TravelMarketData.h"
#import "DiscountCell.h"
#import "PullTableView.h"
#import "DiscountDetailsViewController.h"
#import "TicketBookViewController.h"
#import "UIView+FitVersions.h"
#import "HUDHandle.h"

@interface DetailsViewController ()<UITableViewDataSource,UITableViewDelegate, PullTableViewDelegate>

@property (weak, nonatomic) IBOutlet PullTableView *DiscountTabelView;
@property (strong, nonatomic) TravelDetailData * data;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UIImageView *mainPic;
@property (weak, nonatomic) IBOutlet UILabel *travelTitle;

@property (weak, nonatomic) IBOutlet UILabel *agencyName;
@property (weak, nonatomic) IBOutlet UILabel *agencyAdd;
@property (weak, nonatomic) IBOutlet UIScrollView *countentScrollView;

@property (strong, nonatomic) NSMutableArray *couponArray;

@property (weak, nonatomic) IBOutlet UIImageView *tag1;
@property (weak, nonatomic) IBOutlet UIImageView *tag2;
@property (weak, nonatomic) IBOutlet UIImageView *tag3;
@property (weak, nonatomic) IBOutlet UIImageView *tag4;
@property (weak, nonatomic) IBOutlet UIImageView *tag5;
@property (weak, nonatomic) IBOutlet UIImageView *tag6;
@property (weak, nonatomic) IBOutlet UIImageView *tag7;
@property (weak, nonatomic) IBOutlet UIImageView *tag8;

@property (weak, nonatomic) IBOutlet UILabel *tagLabel1;
@property (weak, nonatomic) IBOutlet UILabel *tagLabel2;
@property (weak, nonatomic) IBOutlet UILabel *tagLabel3;
@property (weak, nonatomic) IBOutlet UILabel *tagLabel4;
@property (weak, nonatomic) IBOutlet UILabel *tagLabel5;
@property (weak, nonatomic) IBOutlet UILabel *tagLabel6;
@property (weak, nonatomic) IBOutlet UILabel *tagLabel7;
@property (weak, nonatomic) IBOutlet UILabel *tagLabel8;
@property (weak, nonatomic) IBOutlet UIWebView *remarkWebView;


@property (weak, nonatomic) IBOutlet UILabel *travelTime;

@property (strong, nonatomic) NSArray *tags;
@property (strong, nonatomic) NSMutableArray *tagArray;
@property (strong, nonatomic) NSMutableArray *tagLabelArray;

@property int pageNum;
@end


//Web 接口,命名和其他景点的区分开
//getTravelCouponList
//getTtravelCouponDetail

@implementation DetailsViewController

@synthesize tag1, tag2,tag3, tag4, tag5, tag6,tag7,tag8;
@synthesize tagLabel1,tagLabel2,tagLabel3, tagLabel4, tagLabel5, tagLabel6, tagLabel7, tagLabel8;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)loadDataFromWeb{
    NSString *path = [getTravelDetail copy];
    path = [path stringByAppendingString:
            [NSString stringWithFormat:@"?travelId=%@",self.travelId]];
    [HTTPAPIConnection postPathToGetJson:(NSString*)path block:^(NSDictionary *json, NSError *error){
         self.data = [[TravelDetailData alloc] init];
        [self.data updateWithJsonDic:json];
        if(self.data == nil || self.data->info == nil)  return;
        TravelDetailInfo *info = self.data->info;
        
        self.price.text       = [NSString stringWithFormat: @"%0.2f元", info->price];
        [PictureHelper addPicture:info->imgUrl to:self.mainPic withSize:CGRectMake(0, 0, 320, 160)];
        self.travelTitle.text = info->title;
        self.agencyName.text  = info->agencyName;
        self.agencyAdd.text   = info->agencyAdd;
              self.travelTime.text  = info->travelTime;
         NSString *htmlStr =  [NSString stringWithFormat:@"<html> \n"
                              "<head> \n"
                              "<style type=\"text/css\"> \n"
                              "body {font-size: %@; color: %@;}\n"
                              "</style> \n"
                              "</head> \n"
                              "<body>%@</body> \n"
                              "</html>",@"13", @"white", info->remark ];
        [self.remarkWebView loadHTMLString:htmlStr baseURL:nil];
        self.tags = [info->tags copy];
        
        if(_tagArray  == nil)
            _tagArray = [[NSMutableArray alloc] initWithObjects:
                         tag1, tag2, tag3, tag4, tag5, tag6, tag7, tag8, nil];
        if(_tagLabelArray == nil)
            _tagLabelArray = [[NSMutableArray alloc] initWithObjects:
                              tagLabel1, tagLabel2, tagLabel3, tagLabel4, tagLabel5, tagLabel6, tagLabel7, tagLabel8, nil];
        
        void (^hideImgAndLabel)(int i, BOOL yn) = ^(int i, BOOL yn){
            UIImageView *aTag = [_tagArray objectAtIndex:i];
            UILabel *aLabel = [_tagLabelArray objectAtIndex:i];
            if(yn == NO){  //这里的i时数组索引，这个判断不能去掉，否则可能引起数组越界访问
                aLabel.text = [self.tags objectAtIndex:i];
            }
            aTag.hidden = aLabel.hidden = yn;
        };
        
        int labelAndViewCnt = [self.tagArray count];  //8
        int tagCount = self.tags.count;
        int i = 0;
        for (; i < labelAndViewCnt && i < tagCount; ++i){
            hideImgAndLabel(i, NO);
        }
        for(; i < labelAndViewCnt; ++i){
            hideImgAndLabel(i, YES);
        }
    }];
}
-(void)loadDataToTableFromWeb{
    int pageNum =  self.pageNum++;
    
    NSString *path = [getTravelCouponList copy];
    path = [path stringByAppendingString:
            [NSString stringWithFormat:@"?viewId=%@&pageNum=%d",self.viewId, pageNum] ];
    [HTTPAPIConnection postPathToGetJson:(NSString*)path block:^(NSDictionary *json, NSError *error){
        if([json objectForKey:@"coupon"]){
            if(pageNum == 0 )
                self.couponArray = [NSMutableArray new];
            for(NSDictionary *couponDic in [json objectForKey:@"coupon"]){
                TravelDetailCoupon *item = [TravelDetailCoupon new];
                [item  updateWithJsonDic:couponDic];
                [self.couponArray addObject:item];
            }
            
            [self.DiscountTabelView reloadData];
        }else{
            [HUDHandle stopLoading];
        }
    }];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    ((UILabel*)self.navigationItem.titleView).text    = self.navigationItem.title;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [HUDHandle startLoadingWithView:nil];
    [self loadDataFromWeb ];
    self.pageNum = 0;
    [self loadDataToTableFromWeb];
}
- (void)viewDidLoad{
    [super viewDidLoad];
    
    if (!IOSVersion70) {
        [self.countentScrollView moveDownY:90];
    }
    self.DiscountTabelView.delegate        = self;
    self.DiscountTabelView.dataSource      = self;
    self.DiscountTabelView.pullDelegate    = self;
    self.DiscountTabelView.backgroundColor = [UIColor clearColor];
    self.DiscountTabelView.separatorStyle= NO;


    self.countentScrollView.contentSize = CGSizeMake(0, 880) ;
    [self.countentScrollView FitViewOffsetY];
}

- (void)backButtonClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDelegate UITableViewDataSource methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    self.DiscountTabelView.pullTableIsRefreshing = NO;
    self.DiscountTabelView.pullTableIsLoadingMore = NO;
    [HUDHandle stopLoading];
    
    return [self.couponArray count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 97;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    int row = indexPath.row;
    static NSString *CellIdentifier = @"DiscountCell";
    DiscountCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"DiscountCell" owner:self options:nil] lastObject];
    }
    if(self.couponArray != nil)
        [cell setCellWithCoupon:[self.couponArray objectAtIndex:row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
  
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DiscountDetailsViewController *ddvc = [[DiscountDetailsViewController alloc]init];

    TravelDetailCoupon *coupon = [self.couponArray objectAtIndex:indexPath.row];
    ddvc.couponId = coupon->couponId;
    [self.navigationController pushViewController:ddvc animated:YES];
}

#pragma mark Events Handler
- (IBAction)bookThis:(id)sender {
    TicketBookViewController *tickCtlr = [[TicketBookViewController alloc] init];
    tickCtlr.marketId = self.travelId;
    [self.navigationController pushViewController:tickCtlr animated:YES];
}
- (IBAction)collectThis:(id)sender {
    User *user = [[LocalCache sharedCache] cachedObjectForKey:@"user"];
    if(user == nil || user.isLoginSuccess == NO){
        DDMenuController *ddMenuController = [(AppDelegate *)[UIApplication sharedApplication].delegate menuController];
        [ddMenuController showRightController:YES];
         [(RightViewController*)(ddMenuController.rightViewController) loginBtnClick:nil];
        return;
    }else{
        NSString *path = [addStore copy];
        NSString *appenStr = [NSString stringWithFormat:@"?marketId=%@&userId=%@",
                              self.travelId,
                              user.userId];
        path = [path stringByAppendingString:appenStr];
        [HTTPAPIConnection postPathToGetJson:path block:^(NSDictionary *json, NSError *error) {
            NSLog(@"json:\n%@", json);
            if(error || json == nil || [json objectForKey:@"code"] == nil){
#if DEBUG
                [AlertViewHandle showAlertViewWithMessage:[error domain]];
#endif
            }else{
                if ([[json objectForKey:@"code"] isEqualToString: @"71"]) {
                    [AlertViewHandle showAlertViewWithMessage:@"收藏成功"];
                }else if([[json objectForKey:@"code"] isEqualToString: @"72"]){
                    [AlertViewHandle showAlertViewWithMessage:@"重复收藏该条信息"];
                }
            }
        }];
    }
}

#pragma mark PullTableViewDelegate
- (void)pullTableViewDidTriggerRefresh:(PullTableView *)pullTableView{
    if(self.DiscountTabelView.pullTableIsLoadingMore  == YES){
        self.DiscountTabelView.pullTableIsRefreshing = NO;
        return;
    }
    [HUDHandle startLoadingWithView:nil];
    [self performSelector:@selector(refreshTable) withObject:nil afterDelay:1.0f];
}
- (void)pullTableViewDidTriggerLoadMore:(PullTableView *)pullTableView{
    if(self.DiscountTabelView.pullTableIsRefreshing  == YES){
        self.DiscountTabelView.pullTableIsLoadingMore = NO;
        return;
    }
    [HUDHandle startLoadingWithView:nil];
    [self performSelector:@selector(loadMoreDataToTable) withObject:nil afterDelay:1.0f];
}
- (void)refreshTable{
    self.pageNum = 0;
    [self.couponArray removeAllObjects];
    
    [self loadDataToTableFromWeb];
}
- (void)loadMoreDataToTable{
    [self loadDataToTableFromWeb];
}

@end
