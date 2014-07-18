//
//  DiscountDetailsViewController.m
//  PudongTravel
//
//  Created by jiangjunli on 14-4-1.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "DiscountDetailsViewController.h"
#import "CommonHeader.h"
#import "TravelMarketData.h"
#import "UIView+FitVersions.h"
#import "UIView+FrameHandle.h"
@interface DiscountDetailsViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *mainImg;
@property (weak, nonatomic) IBOutlet UITextView *remark;
@property Coupon *data;
@property (weak, nonatomic) IBOutlet UILabel *couponTitle;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation DiscountDetailsViewController

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
    
   // [self.scrollView FitViewOffsetY];
    if (!IS_IPHONE5) {
        self.scrollView.originY = 70;
    }
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    ((UILabel*)self.navigationItem.titleView).text = @"详情";  //设置标题
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self loadDataFromWeb];
}

- (IBAction)onCollectBtnClicked:(id)sender {
    NSString *path = [storeCoupon copy];
    User *user = [[LocalCache sharedCache] cachedObjectForKey:@"user"];
    if(!user || !user.isLoginSuccess){
        [AppDelegate showLogin];
        return;
    }
    NSString *appenStr = [NSString stringWithFormat:@"?couponId=%@&userId=%@",
                          self.data.info.couponId,
                          user.userId];
    path = [path stringByAppendingString:appenStr];
    [HTTPAPIConnection postPathToGetJson:path block:^(NSDictionary *json, NSError *error) {
        NSLog(@"%@", json);
        if(error){
#if DEBUG
            [AlertViewHandle showAlertViewWithMessage:[error domain]];
#endif
        }else{
            if ([[json objectForKey:@"code"] isEqualToString: @"71"]) {
                [AlertViewHandle showAlertViewWithMessage:@"收藏成功"];
            }
            else if([[json objectForKey:@"code"] isEqualToString: @"72"])
            {
                [AlertViewHandle showAlertViewWithMessage:@"重复收藏该条信息"];
            }

        }
    }];
}

- (IBAction)onGetCouponClicked:(id)sender {
    NSString *path = [addCoupon copy];
    User *user = [[LocalCache sharedCache] cachedObjectForKey:@"user"];
    if(!user || user.isLoginSuccess == NO){
        [AppDelegate showLogin];
        return;
    }
    NSString *appenStr = [NSString stringWithFormat:@"?couponId=%@&userId=%@",
                          self.data.info.couponId,
                          user.userId];
    path = [path stringByAppendingString:appenStr];
    [HTTPAPIConnection postPathToGetJson:path block:^(NSDictionary *json, NSError *error) {
        NSLog(@"%@", json);
//        if(error){
//            [AlertViewHandle showAlertViewWithMessage:
//             [NSString stringWithFormat:@"%@ 领取失败", [error domain]]];
//        }else{
//            [AlertViewHandle showAlertViewWithMessage:@"领取成功"];
//        }
        if(error || json == nil || [json objectForKey:@"code"] == nil){
#if DEBUG
            [AlertViewHandle showAlertViewWithMessage:[error domain]];
#endif
        }else{
            if ([[json objectForKey:@"code"] isEqualToString: @"71"]) {
                [AlertViewHandle showAlertViewWithMessage:@"领取成功"];
            }else if([[json objectForKey:@"code"] isEqualToString: @"72"]){
                [AlertViewHandle showAlertViewWithMessage:@"重复领取该条优惠卷"];
            }else if([[json objectForKey:@"code"] isEqualToString: @"81"]){
                [AlertViewHandle showAlertViewWithMessage:@"抱歉！优惠卷已经过期不能领取！敬请期待其他优惠"];
            }


        }
    }];
}

-(void)backButtonClicked{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)loadDataFromWeb{
    NSString *path = [getCouponDetail copy];
    path = [path stringByAppendingString:
            [NSString stringWithFormat:@"?couponId=%@", self.couponId]];
    [HTTPAPIConnection postPathToGetJson:(NSString*)path block:^(NSDictionary *json, NSError *error){
        self.data = [Coupon new];
        [self.data updateWithJsonDic:json];
        if(self.data == nil || self.data.info == nil)  return;
        CouponInfo *info = self.data.info;
        
        [PictureHelper addPicture:info.imgUrl to:self.mainImg
                         withSize:CGRectMake(0, 0, 320, 160)];
        self.remark.text = (info.remark == nil) ? @"没有更多介绍了" : info.remark;
        
        self.couponTitle.text = info.couponName;
        
        //self.price.text       = [NSString stringWithFormat: @"%2.00f元", info->price];
    }];
}

@end
