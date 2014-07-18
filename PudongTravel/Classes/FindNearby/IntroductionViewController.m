//
//  IntroductionViewController.m
//  PudongTravel
//
//  Created by jiangjunli on 14-4-2.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "IntroductionViewController.h"
#import "CommonHeader.h"

#import "UIImage+loadImage.h"
#import "GoViewController.h"
#import "NearbyMapViewController.h"
#import "BaseObject.h"
//优惠券的头文件
#import "DiscountDetailsViewController.h"
#import "TravelMarketData.h"
#import "DiscountCell.h"
#import "UIView+FitVersions.h"

@interface MechatInfo:BaseObject{
    @public
    NSString *add;
    NSString *businessTime;
    NSString *grade;
    NSString *remark;
    NSString *title;
    NSString *trafic;
    NSString *viewId;
}@end
@implementation MechatInfo @end

/*
@interface SceneCouponInfo :BaseObject{
    @public
    NSString *couponId;
    NSString *couponName;
    float price;
    NSString *remark;
    NSString *imgUrl;
}@end

@implementation SceneCouponInfo @end
*/
@interface IntroductionViewController ()<UITableViewDataSource, UITableViewDelegate>
@property MechatInfo *info;
@property NSString *couponWebInterface;

@property (weak, nonatomic) IBOutlet UILabel *mainTitle;
@property (weak, nonatomic) IBOutlet UITextView *describe;
@property (weak, nonatomic) IBOutlet UILabel *openTime;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UITextView *traffic;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITableView *couponTable;

@property NSMutableArray *arrayToShow;
@end

@implementation IntroductionViewController
@synthesize arrayToShow;

-(void)loadTableDataFromWeb{
    //优惠券
    NSString *path = [[getCouponList copy] stringByAppendingString:
            [NSString stringWithFormat:@"?viewId=%@&pageNum=1",self.idStr]];
    [HTTPAPIConnection postPathToGetJson:(NSString*)path
                                   block:^(NSDictionary *json, NSError *error)
     {
         if(error) {
             
         }else{
             if(self.arrayToShow == nil)
                 self.arrayToShow = [NSMutableArray new];
             for(NSDictionary *dicItem in [json objectForKey:@"info"]){
                 TravelDetailCoupon *info = [TravelDetailCoupon new];
                 [info updateWithJsonDic:dicItem];
                 [self.arrayToShow addObject:info];
             }
             [self.couponTable reloadData];
         }
     }];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    ((UILabel*)self.navigationItem.titleView).text = @"简介";  //设置标题
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //基本页面的信息
    NSString *path = [[getMerchantIntro copy] stringByAppendingString:
            [NSString stringWithFormat:@"?viewId=%@",self.idStr]];
    [HTTPAPIConnection postPathToGetJson:(NSString*)path
                                   block:^(NSDictionary *json, NSError *error)
     {
         if(error) {
             
         }else{
             self.info = [MechatInfo new];
             [self.info updateWithJsonDic:[json objectForKey:@"info"]];
             
             self.mainTitle.text = [NSString stringWithFormat:@"[%@] %@",
                                    self.info->grade, self.info->title ];
             self.describe.text  = self.info->remark;
             self.openTime.text  = self.info->businessTime;
             self.traffic.text   = self.info->trafic;
             self.address.text   = self.info->add;
         }
     }];
    
    [self.arrayToShow removeAllObjects];
    [HUDHandle startLoadingWithView:nil];
    [self loadTableDataFromWeb];
}
- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.scrollView.contentSize = CGSizeMake(320, self.scrollView.frame.size.height + 550);
    
    self.couponTable.delegate = self;
    self.couponTable.dataSource = self;
    self.couponTable.backgroundColor = [UIColor clearColor];
    self.couponTable.separatorStyle = NO;
    if (!IS_IPHONE5) {
        self.scrollView.originY = 70 ;
    }
}
- (void)backButtonClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)goBtnCllicked:(id)sender {
    NearbyMapViewController *mapCtlr = [[NearbyMapViewController alloc] init];
    mapCtlr.willShowUserLocation = NO;
    [self.navigationController pushViewController:mapCtlr animated:NO];
    
    GoViewController *gvc = [GoViewController new];
    gvc.mapDelegate = mapCtlr;
    [mapCtlr.navigationController pushViewController:gvc animated:NO];
}

#pragma mark UITableViewDataSource
 - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    [HUDHandle stopLoading];
    return [arrayToShow count];
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
    if(self.arrayToShow != nil)
        [cell setCellWithCoupon:[self.arrayToShow objectAtIndex:row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}
#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DiscountDetailsViewController *ddvc = [[DiscountDetailsViewController alloc]init];

    TravelDetailCoupon *coupon = [self.arrayToShow objectAtIndex:indexPath.row];
    ddvc.couponId = coupon->couponId;
    [self.navigationController pushViewController:ddvc animated:YES];
}
@end
