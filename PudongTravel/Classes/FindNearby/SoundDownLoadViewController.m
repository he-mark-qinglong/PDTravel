//
//  SoundDownLoadViewController.m
//  pudongapp
//
//  Created by jiangjunli on 14-2-19.
//  Copyright (c) 2014年 jiangjunli. All rights reserved.
//

#import "SoundDownLoadViewController.h"
#import "SoundCell.h"
@interface SoundDownLoadViewController ()
@property (weak, nonatomic) IBOutlet UITableView *soundContenTable;
@property(strong,nonatomic) NSMutableArray *titleArray;
@property(strong,nonatomic)NSMutableArray *nameArray;
@property(strong,nonatomic)NSMutableArray *nameArray2;
@end

@implementation SoundDownLoadViewController

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
    self.soundContenTable.delegate = self;
    self.soundContenTable.dataSource = self;
   // self.titleArray =[[NSMutableArray alloc] initWithObjects:@"东方明珠", @"上海野生动物园",@"上海水族馆", nil];
    //self.soundContenTable.tableHeaderView = [UIImageView ];
    self.nameArray = [[NSMutableArray alloc]initWithObjects:@"A区",@"B区",@"C区", nil];
    self.nameArray2 = [[NSMutableArray alloc]initWithObjects:@"太空仓",@"球体",@"下球体", nil];
    self.soundContenTable.backgroundColor = [UIColor clearColor];
    self.soundContenTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.automaticallyAdjustsScrollViewInsets =NO;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return [self.nameArray count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SoundCell";
    //自定义cell类
    SoundCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        //通过xib的名称加载自定义的cell
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SoundCell" owner:self options:nil] lastObject];
    }
    NSUInteger row = [indexPath row];
    //添加测试数据
    cell.selectionStyle = UITableViewCellSelectionStyleNone;//设置选择cell的颜色
    cell.backgroundColor = [UIColor clearColor];
//    cell.name.text = [tableArray objectAtIndex:row];
//    cell.time.text = @"共有1中优惠卷";
//    cell.renjun.text = [numberArray objectAtIndex:row];
//    cell.address.text = [addressArray objectAtIndex:row];
    cell.nameLabel.text = [self.nameArray objectAtIndex:row];
    cell.nameLabel2.text = [self.nameArray2 objectAtIndex:row];
    NSString *imageName = [NSString stringWithFormat:@"%d.png",row+1];
    UIImage *image = [UIImage imageNamed:imageName];
    cell.imageview.image = image;
    return cell;  }
- (IBAction)backbtnclidk:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
