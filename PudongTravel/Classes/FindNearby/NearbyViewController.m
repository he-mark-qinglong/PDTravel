//
//  NearbyViewController.m
//  pudongapp
//
//  Created by jiangjunli on 14-2-11.
//  Copyright (c) 2014年 jiangjunli. All rights reserved.
//

#import "NearbyViewController.h"
#import "MenuController.h"
#import "FoodViewController.h"
#import "ScenicSpotViewController.h"
#import "UIImage+loadImage.h"

@interface NearbyViewController ()

//@property (weak, nonatomic) IBOutlet UITableView *nerbyTableView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *landscape;
@property (weak, nonatomic) IBOutlet UIButton *stayBtn;
@property (weak, nonatomic) IBOutlet UIButton *travelBtn;
@property (weak, nonatomic) IBOutlet UIButton *shoppingBtn;
@property (weak, nonatomic) IBOutlet UIButton *foodBtn;
@property (weak, nonatomic) IBOutlet UIButton *entertainmentBtn;
@property (strong, nonatomic) NSArray *btnArray;

@end

@implementation NearbyViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    ((UILabel*)self.navigationItem.titleView).text = @"找附近";  //设置标题
    
    if (IOS7) {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"top_background.png"]
                                                      forBarMetrics:UIBarMetricsDefault];
    }else{
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"top44.png"]
                                                      forBarMetrics:UIBarMetricsDefault];
    }
}

- (void)viewDidLoad{
    [super viewDidLoad];
    if (!IS_IPHONE5) {
        self.scrollView.frame = CGRectMake(0, 155, 300, 412);
    }
    self.scrollView.contentSize = CGSizeMake(0, 472) ;
    
    array = @[@"美食",@"购物",@"娱乐",@"景区",@"住宿",@"旅行社"];
    self.btnArray  = @[self.landscape, self.stayBtn, self.travelBtn,
                       self.shoppingBtn, self.foodBtn, self.entertainmentBtn];
}

- (IBAction)buttonClick:(id)sender{
    for (UIButton *btn in self.btnArray){
        btn.selected = NO;
    }
    UIButton *button = (UIButton *)sender;
    button.selected = YES;
    
    FoodViewController *fvc = [FoodViewController new];
    fvc._vcType = button.tag;
    [self.navigationController pushViewController:fvc animated:YES];
}
@end
