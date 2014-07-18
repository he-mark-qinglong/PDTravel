//
//  RideLineViewController.m
//  PudongTravel
//
//  Created by jiangjunli on 14-3-25.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "RideLineViewController.h"
#import "dongfangbaliViewController.h"
@interface RideLineViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tabelview;

@end

@implementation RideLineViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    if (IOS7) {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"top_background.png"] forBarMetrics:UIBarMetricsDefault];
        
    }
    else{
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"top44.png"] forBarMetrics:UIBarMetricsDefault];
    }
}- (void)viewDidLoad
{
    if (IOS7) {
       self.tabelview.frame = CGRectMake(10, 70, 300, 498);
    }
    else
    {
        if (!IS_IPHONE5) {
            self.tabelview.frame = CGRectMake(10, 10, 300, 498);
        }
         self.tabelview.frame = CGRectMake(10, 70, 300, 498);
    }
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIBarButtonItem *letfBarItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_return.png"] style:UIBarButtonItemStylePlain target:self action:@selector(letfbtnclick)];
    self.navigationItem.leftBarButtonItem = letfBarItem;
    
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_personal.png"] style:UIBarButtonItemStylePlain target:self action:@selector(rightbtnclick)];
//    self.navigationItem.rightBarButtonItem = rightBarItem;
    UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 40 , 100, 44)];
    titleLabel.backgroundColor = [UIColor clearColor];  //设置Label背景透明
    titleLabel.font = [UIFont boldSystemFontOfSize:16];  //设置文本字体与大小
    titleLabel.textColor = [UIColor whiteColor];  //设置文本颜色
    
    titleLabel.text = @"特色主题游";  //设置标题
    self.navigationItem.titleView = titleLabel;
    
    self.tabelview.dataSource = self;
    self.tabelview.delegate = self;
    self.tabelview.backgroundColor = [UIColor clearColor];
    [self.tabelview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
   
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 165;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSUInteger row = [indexPath row];
        // cell.textLabel.text = [array objectAtIndex:row];
        NSString *imageName = [NSString stringWithFormat:@"xianlu_tb%d.png",row+1];
        UIImageView *imagview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
        
        imagview.frame = CGRectMake(0, 0, 300, 160);
        [cell addSubview:imagview];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    dongfangbaliViewController *dfblvc = [[dongfangbaliViewController alloc]init];
    [self presentViewController:dfblvc animated:NO completion:nil];
}
-(void)rightbtnclick
{
}
-(void)letfbtnclick
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
