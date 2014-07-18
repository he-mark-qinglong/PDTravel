//
//  wangyoudianpingViewController.m
//  pudongapp
//
//  Created by jiangjunli on 14-2-21.
//  Copyright (c) 2014年 jiangjunli. All rights reserved.
//

#import "wangyoudianpingViewController.h"
#import "dianpingCell.h"
@interface wangyoudianpingViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *contentTableView;
@property(strong,nonatomic) NSMutableArray *usernameArray;
@property(strong,nonatomic) UIView *view1;
@end

@implementation wangyoudianpingViewController

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
    // Do any additional setup after loading the view from its nib.
    self.contentTableView.delegate = self;
    self.contentTableView.dataSource = self;
    self.contentTableView.backgroundColor = [UIColor clearColor];
    self.contentTableView .separatorStyle = UITableViewCellSeparatorStyleNone ;
    self.usernameArray = [[NSMutableArray alloc]initWithObjects:@"123",@"er",@"my yixiu", nil];
    if (!IS_IPHONE5) {
        self.contentTableView.frame = CGRectMake(0, 65, 320,424);
    }
    }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

   
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 155;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"dianpingCell";
    //自定义cell类
    dianpingCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        //通过xib的名称加载自定义的cell
        cell = [[[NSBundle mainBundle] loadNibNamed:@"dianpingCell" owner:self options:nil] lastObject];
    }
    NSUInteger row = [indexPath row];
    //添加测试数据
    cell.selectionStyle = UITableViewCellSelectionStyleNone;//设置选择cell的颜色
    cell.backgroundColor = [UIColor clearColor];
//    cell.name.text = [tableArray objectAtIndex:row];
//    cell.youhui.text = @"共有1中优惠卷";
//    cell.renjun.text = [numberArray objectAtIndex:row];
//    cell.address.text = [addressArray objectAtIndex:row];
    NSString *imageName = [NSString stringWithFormat:@"%d.png",row+1];
    UIImage *image = [UIImage imageNamed:imageName];
    NSString *imageName2 = [NSString stringWithFormat:@"%d.png",row+4];
    UIImage *image2 = [UIImage imageNamed:imageName2];
//    cell.image.image = image;
    cell.usernamelabel.text = [self.usernameArray objectAtIndex:row];;
    cell.contenlabel.text = @"初花 上海人气最高的日料店之一  初花里的环境优美";
    cell.imageview1.userInteractionEnabled = YES;
    cell.imageview2.userInteractionEnabled = YES;
    cell.imageview1.multipleTouchEnabled = YES;
     cell.imageview2.multipleTouchEnabled = YES;
    cell.imageview1.image = image;
    cell.imageview2.image = image2;

    UIGestureRecognizer*singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showBigImage:)];
    UIGestureRecognizer*singleTap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showBigImage:)];
   [cell.imageview1  addGestureRecognizer:singleTap];
   [cell.imageview2 addGestureRecognizer:singleTap2];
    
    
    return cell;

}
-(void) showBigImage:( UIGestureRecognizer *)tap
{
    UIImageView *imageView = (UIImageView *)tap.view;
    UIImage *image = imageView.image;
    self.view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 20, 320, 548)];
    self.view1.backgroundColor = [UIColor blackColor];
    self.view1.alpha = 0.75;
    UIImageView *imageViewer = [[UIImageView alloc] init];
    UITapGestureRecognizer *closeTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                               action:@selector(hideBigImage:)];
    imageViewer.multipleTouchEnabled = YES;
    imageViewer.userInteractionEnabled = YES;
    [imageViewer addGestureRecognizer:closeTap];
    imageViewer.animationDuration = 2.0;
    imageViewer.animationRepeatCount = 1;
    [imageViewer setFrame:CGRectMake(10, 120, 300, 200)];
    [imageViewer startAnimating];
//    NSString *imagepath = [[NSBundle mainBundle] pathForResource:@"t1"
//                                                          ofType:@"png"];
//    UIImage *image1 = [UIImage imageWithContentsOfFile:imagepath];
    [imageViewer setImage:image];
 
    UIWindow *mainWindow = [UIApplication sharedApplication].delegate.window;
    [mainWindow.rootViewController.view addSubview:self.view1];
    [mainWindow.rootViewController.view addSubview:imageViewer];
}
- (IBAction)backclick:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}
-(void) hideBigImage:(id)sender
{
    UITapGestureRecognizer *tap = (UITapGestureRecognizer*)sender;
    [tap.view removeFromSuperview];
    [self.view1 removeFromSuperview];
}
@end
