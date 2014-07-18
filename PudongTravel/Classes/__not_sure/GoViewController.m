//
//  GoViewController.m
//  pudongapp
//
//  Created by jiangjunli on 14-2-19.
//  Copyright (c) 2014年 jiangjunli. All rights reserved.
//

#import "GoViewController.h"
#import "UIImage+loadImage.h"
@interface GoViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *busBtn;//公交路线按钮
@property (weak, nonatomic) IBOutlet UIButton *carBtn;//驾车路线按钮
@property (weak, nonatomic) IBOutlet UIImageView *backgroundimage1;//出发地text下面的青色框
@property (weak, nonatomic) IBOutlet UIImageView *backgroundimage2;//目的地text下面的青色框
@property (weak, nonatomic) IBOutlet UITextField *DestinationTextField;//目的地文本框
@property (weak, nonatomic) IBOutlet UITextField *DepartureText;//出发地文本框
@property (weak, nonatomic) IBOutlet UIImageView *tabbackgroundimage;//公交路线驾车路线切换时的背景image

@end

@implementation GoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
//确认搜索的单机事件
- (IBAction)searchbtnClick:(id)sender {
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.backgroundimage1.initialize = NO;
  
    
}
- (IBAction)busBtnClicked:(id)sender {
//    [self.tabbackgroundimage setImage:[UIImage imageNamed:<#(NSString *)#>]];
    [self.tabbackgroundimage setImage:[UIImage imageWithResourceName:@"tab_bus_s.png"]];
}
- (IBAction)carBtnClicked:(id)sender {
    [self.tabbackgroundimage setImage:[UIImage imageWithResourceName:@"tab_drive_s.png"]];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc
{
    
}
@end
