//
//  GoViewController.m
//  pudongapp
//
//  Created by jiangjunli on 14-2-19.
//  Copyright (c) 2014年 jiangjunli. All rights reserved.
//

#import "GoViewController.h"
#import "UIImage+loadImage.h"
#import "CommonHeader.h"

enum ChoosedBtnStatus{
    EChooseTranstion = 0,
    EChooseDriving
};

@interface GoViewController ()//<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *busBtn;//公交路线按钮
@property (weak, nonatomic) IBOutlet UIButton *carBtn;//驾车路线按钮
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;

@property (weak, nonatomic) IBOutlet UIImageView *backgroundimage1;//出发地text下面的青色框
@property (weak, nonatomic) IBOutlet UIImageView *backgroundimage2;//目的地text下面的青色框

@property (weak, nonatomic) IBOutlet UITextField *DestinationTextField;//目的地文本框
@property (weak, nonatomic) IBOutlet UITextField *DepartureText;//出发地文本框

@property (weak, nonatomic) IBOutlet UIImageView *tabbackgroundimage;//公交路线驾车路线切换时的背景image
@property (weak, nonatomic) IBOutlet UIView *contentView;

@property enum ChoosedBtnStatus choosedBtnType; // 0-公交, 1-驾车
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

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    ((UILabel*)self.navigationItem.titleView).text = @"我要去";  //设置标题
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.choosedBtnType = EChooseDriving;
    if (IOSVersion70){
        [self.contentView FitViewOffsetY];
    }
    
    //编辑动作,切换输入的边框
    [[RACSignal combineLatest:
      @[[self.DestinationTextField rac_signalForControlEvents:UIControlEventEditingDidBegin],
        [self.DepartureText rac_signalForControlEvents:UIControlEventEditingDidBegin]]]
     subscribeNext:^(id x) {
         static UIImage *image_s;
         if(!image_s) image_s = [UIImage imageWithResourceName:@"constituency_s.png"];
         self.backgroundimage2.image = self.backgroundimage1.image = image_s;
     }];
    [[RACSignal combineLatest:
      @[[self.DestinationTextField rac_signalForControlEvents:UIControlEventEditingDidEnd],
        [self.DepartureText rac_signalForControlEvents:UIControlEventEditingDidEnd]]]
     subscribeNext:^(id x) {
         static UIImage *image;
         if(!image) image = [UIImage imageWithResourceName:@"constituency.png"];
         self.backgroundimage2.image = self.backgroundimage1.image = image;
     }];
    
    //按钮选择
    [[self.busBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
         [self.tabbackgroundimage setImage:[UIImage imageWithResourceName:@"tab_bus_s.png"]];
         self.choosedBtnType = EChooseTranstion;
         [self.busBtn setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
         [self.carBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
     }];
    [[self.carBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self.tabbackgroundimage setImage:[UIImage imageWithResourceName:@"tab_drive_s.png"]];
        self.choosedBtnType = EChooseDriving;
        [self.busBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.carBtn setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
    }];
    
    //搜索按钮的enable属性绑定两个条件，因为需要两个输入框都输入才能点击，减少用户提示
    RAC(self.searchBtn, enabled) =
    [RACSignal combineLatest:@[self.DestinationTextField.rac_textSignal,
                               self.DepartureText.rac_textSignal]
                      reduce:^id(id value, id value2) {
                          return @((value != nil && ![value isEqualToString:@""])
                          && (value2 != nil && ![value2 isEqualToString:@""]));
                      }];
    
    //搜索
    [[self.searchBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
         NSString * endStr = self.DestinationTextField.text;
         NSString * startStr = self.DepartureText.text;
         
         self.mapDelegate.willShowUserLocation = NO;
         [self.navigationController popViewControllerAnimated:NO];
         
         if(self.choosedBtnType == EChooseTranstion)
             [self.mapDelegate onBusSearchString:@"上海"
                                     startString:startStr  endString:endStr
                                         BDMtype:BDMPositionBusPoint];
         else
             [self.mapDelegate onBusSearchString:@"上海"
                                     startString:startStr  endString:endStr
                                         BDMtype:BDMPositionDrivingPoint];
     }];
    
    //键盘加入自动隐藏的按钮
    [self setupKeyBoardHideBtnFor:self.DestinationTextField];
    [self setupKeyBoardHideBtnFor:self.DepartureText];
}

-(void)setupKeyBoardHideBtnFor:(UITextField*)textView{
    UIToolbar * topView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    [topView setBarStyle:UIBarStyleBlackTranslucent];
    topView.backgroundColor = [UIColor clearColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(2, 5, 50, 25);
    [btn setImage:[UIImage imageNamed:@"icon_download_activating.png"] forState:UIControlStateNormal];
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [textView resignFirstResponder];
     }];
    
    UIBarButtonItem *btnSpace = [[UIBarButtonItem alloc]
                                 initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                 target:self action:nil];
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc]initWithCustomView:btn];
    
    NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace, doneBtn, nil];
    [topView setItems:buttonsArray];
    [textView setInputAccessoryView:topView];
}
@end
