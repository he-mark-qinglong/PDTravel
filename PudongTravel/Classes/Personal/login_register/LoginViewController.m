//
//  LoginViewController.m
//  PudongTravel
//
//  Created by mark on 14-3-27.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
@property (strong, nonatomic) UIView *registeview;

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSLog(@"register View loaded");
    self.registeview =[[UIView alloc]init];
    self.registeview.frame = CGRectMake(0, 0, 320, 480);
    [self.view addSubview:self.registeview];
    
    UIImage *background = [UIImage imageNamed:@"background4.png"];
    UIImageView *backgroundview = [[UIImageView alloc]initWithImage:background];
    
    backgroundview.frame = CGRectMake(0, 0, 320, 480);
    [self.registeview addSubview:backgroundview];
    if (IS_IPHONE5) {
        backgroundview.frame = CGRectMake(0, 0, 320,568);
    }

    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(50, 60, 100, 30)];
    label.text = @"会员注册";
    label.font = [UIFont systemFontOfSize: 14];
    label.textColor= [UIColor cyanColor];
    [self.registeview addSubview:label];
    
    UIImage *nametextbackground = [UIImage imageNamed:@"constituency_s.png"];
    UIImageView *nametextbackgroundview = [[UIImageView alloc]initWithFrame:CGRectMake(50, 100, 222, 36)];
    nametextbackgroundview.image = nametextbackground;
    [self.registeview addSubview:nametextbackgroundview];
    nametextbackgroundview.hidden = YES;
    
    UIImage *nametextbackground2 = [UIImage imageNamed:@"constituency.png"];
    UIImageView *nametextbackgroundview2 = [[UIImageView alloc]initWithFrame:CGRectMake(50, 100, 222, 36)];
    nametextbackgroundview2.image = nametextbackground2;
    [self.registeview addSubview:nametextbackgroundview2];
    
    UILabel *userlabel = [[UILabel alloc]initWithFrame:CGRectMake(65, 105, 60, 30)];
    userlabel.text = @"账 号";
    userlabel.font = [UIFont systemFontOfSize: 13];
    userlabel.textColor= [UIColor whiteColor];
    [self.registeview addSubview:userlabel];
    
    UITextField *userTextField = [[UITextField alloc]initWithFrame:CGRectMake(120, 103, 152, 36)];
    userTextField.textColor = [UIColor whiteColor];
    [self.registeview addSubview:userTextField];
    
    
    
    UIImage *pwdtextbackground = [UIImage imageNamed:@"constituency_s.png"];
    UIImageView *pwdtextbackgroundview = [[UIImageView alloc]initWithFrame:CGRectMake(50, 150, 222, 36)];
    pwdtextbackgroundview.image = pwdtextbackground;
    [self.registeview addSubview:pwdtextbackgroundview];
    pwdtextbackgroundview.hidden = YES;
    
    UIImage *pwdtextbackground2 = [UIImage imageNamed:@"constituency.png"];
    UIImageView *pwdtextbackgroundview2 = [[UIImageView alloc]initWithFrame:CGRectMake(50, 150, 222, 36)];
    pwdtextbackgroundview2.image = pwdtextbackground2;
    [self.registeview addSubview:pwdtextbackgroundview2];
    
    UILabel *pwdlabel = [[UILabel alloc]initWithFrame:CGRectMake(65, 155, 60, 30)];
    pwdlabel.text = @"密 码";
    pwdlabel.font = [UIFont systemFontOfSize: 13];
    pwdlabel.textColor= [UIColor whiteColor];
    [self.registeview addSubview:pwdlabel];
    
    UITextField * pwdTextField = [[UITextField alloc]initWithFrame:CGRectMake(120, 153, 152, 36)];
    pwdTextField.textColor = [UIColor whiteColor];
    [self.registeview addSubview:pwdTextField];
    
    UILabel *repwdlabel = [[UILabel alloc]initWithFrame:CGRectMake(67, 207, 60, 30)];
    repwdlabel.text = @"确认密码";
    repwdlabel.font = [UIFont systemFontOfSize: 13];
    repwdlabel.textColor= [UIColor whiteColor];
    [self.registeview addSubview:repwdlabel];
    
    UITextField *repwdTextField = [[UITextField alloc]initWithFrame:CGRectMake(120, 200, 152, 36)];
    [self.registeview addSubview:repwdTextField];
    
    UIImage *repwdtextbackground2 = [UIImage imageNamed:@"constituency.png"];
    UIImageView *repwdtextbackgroundview2 = [[UIImageView alloc]initWithFrame:CGRectMake(50, 200, 222, 36)];
    repwdtextbackgroundview2.image = repwdtextbackground2;
    [self.registeview addSubview:repwdtextbackgroundview2];
    
    UIImage *repwdtextbackground = [UIImage imageNamed:@"constituency_s.png"];
    UIImageView *repwdtextbackgroundview = [[UIImageView alloc]initWithFrame:CGRectMake(50, 200, 222, 36)];
    repwdtextbackgroundview.image = repwdtextbackground;
    [self.registeview addSubview:repwdtextbackgroundview];
    repwdtextbackgroundview.hidden = YES;
    
    UILabel *nichenglabel = [[UILabel alloc]initWithFrame:CGRectMake(65, 260, 60, 30)];
    nichenglabel.text = @"昵 称";
    nichenglabel.font = [UIFont systemFontOfSize: 13];
    nichenglabel.textColor= [UIColor whiteColor];
    [self.registeview addSubview:nichenglabel];
    
    UITextField * nichengTextField = [[UITextField alloc]initWithFrame:CGRectMake(120, 256, 152, 36)];
    [self.registeview addSubview:nichengTextField];
    
    
    UIImage *nichengtextbackground2 = [UIImage imageNamed:@"constituency.png"];
    UIImageView *nichengtextbackgroundview2 = [[UIImageView alloc]initWithFrame:CGRectMake(50, 255, 222, 36)];
    nichengtextbackgroundview2.image = nichengtextbackground2;
    [self.registeview addSubview:nichengtextbackgroundview2];
    
    UIButton *loginbutton = [[UIButton alloc]initWithFrame:CGRectMake(50, 300, 222, 36)];
    [loginbutton setBackgroundImage:[UIImage imageNamed:@"icon_textbackground2.png"] forState:UIControlStateNormal];
    [loginbutton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [loginbutton setTintColor:[UIColor whiteColor]];
    loginbutton.titleLabel.font    = [UIFont systemFontOfSize: 14];
    [self.registeview addSubview:loginbutton];
    
    
    UIButton *registeLoginbtn = [[UIButton alloc]initWithFrame:CGRectMake(50, 350, 102, 36)];
    [registeLoginbtn setBackgroundImage:[UIImage imageNamed:@"icon_textbackground.png"] forState:UIControlStateNormal];
    [registeLoginbtn setTitle:@"登录" forState:UIControlStateNormal];
    [registeLoginbtn setTintColor:[UIColor whiteColor]];
    registeLoginbtn.titleLabel.font    = [UIFont systemFontOfSize: 14];
    [registeLoginbtn addTarget:self action:@selector(registeLoginbtnclick) forControlEvents:UIControlEventTouchUpInside];
    [self.registeview addSubview:registeLoginbtn];
    
    UIButton *backbtn = [[UIButton alloc]initWithFrame:CGRectMake(170, 350, 102, 36)];
    [backbtn setBackgroundImage:[UIImage imageNamed:@"icon_textbackground.png"] forState:UIControlStateNormal];
    [backbtn setTitle:@"返回" forState:UIControlStateNormal];
    [backbtn setTintColor:[UIColor whiteColor]];
    backbtn.titleLabel.font    = [UIFont systemFontOfSize: 14];
    [backbtn addTarget:self action:@selector(backbtnclick) forControlEvents:UIControlEventTouchUpInside];
    [self.registeview addSubview:backbtn];
}

-(void)registeLoginbtnclick
{
    NSLog(@"44444");
    self.registeview.hidden = YES;
    
}
-(void)backbtnclick
{
   [self.view removeFromSuperview];
}
@end
