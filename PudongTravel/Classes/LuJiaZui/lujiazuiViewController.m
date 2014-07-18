//
//  lujiazuiViewController.m
//  pudongapp
//
//  Created by jiangjunli on 14-2-20.
//  Copyright (c) 2014年 jiangjunli. All rights reserved.
//

#import "lujiazuiViewController.h"
#import "dongfangbaliViewController.h"
#import "ConstLinks.h"
#import "LujiazuiData.h"
#import "UIView+FitVersions.h"
#import "CommonHeader.h"



#pragma mark lujiazuiViewController

@interface lujiazuiViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *contentTabelView;
@property (strong, nonatomic) NSArray *showTypes;
@property (strong, nonatomic)NSArray *showImage;
@property (strong, nonatomic)NSArray *buttonname1;
@property (strong, nonatomic)NSArray *buttonname2;

@property SpecialTravel* dataSpecialTravel;
@end

@implementation lujiazuiViewController

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
    ((UILabel*)self.navigationItem.titleView).text = self.bigTitle;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (IOS7) {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"top_background.png"] forBarMetrics:UIBarMetricsDefault];
    }else{
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"top44.png"] forBarMetrics:UIBarMetricsDefault];
    }
    
    if([self.bigTitle isEqualToString:@"小陆家嘴"]){
        self.showTypes   = @[@"著名景区", @"娱生活", @"楼宇群"];
        self.showImage   = @[@"picture1.png", @"picture2.png", @"picture3.png"];
        self.buttonname1 = @[@"名胜景点", @"时尚生活", @"金融乐园"];
        self.buttonname2 = @[@"周边推荐", @"心醉夜色", @"周边推荐"];
        [self.contentTabelView reloadData];
    }else if([self.bigTitle isEqualToString:@"世博园区"]){
        self.showTypes   = @[@"世博符号", @"世博源", @"世博记忆"];
        self.showImage   = @[@"expo_tb1.png", @"expo_tb2.png", @"expo_tb3.png"];
        self.buttonname1 = @[@"一轴四馆", @"世博新馆", @"展馆追忆"];
        self.buttonname2 = @[@"其他场馆", @"推荐场馆", @"周边信息"];
        [self.contentTabelView reloadData];
    }else{  //特色旅游 不用本地图片，熟用网络上的数据
        self.showTypes   = @[@"都市观光游", @"乡村生态游", @"科技体验游"];
        //self.showImage = @[@"xianlu_tb1.png", @"xianlu_tb2.png", @"xianlu_tb3.png"];
        self.buttonname1 = @[@"行程推荐", @"行程推荐", @"行程推荐"];
        self.buttonname2 = @[@"周边推荐", @"周边推荐", @"周边推荐"];
        
        [HUDHandle startLoadingWithView:nil];
        [HTTPAPIConnection postPathToGetJson:@"path/getPathList?pageNum=0" block:^(NSDictionary *json, NSError *error) {
            [HUDHandle stopLoading];
            self.dataSpecialTravel = [SpecialTravel new];
            [self.dataSpecialTravel updateWithJsonDic:json];
            [self.contentTabelView reloadData];
        }];
    }
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    if (IOSVersion70){
        [self.contentTabelView FitViewOffsetY];
        [self.contentTabelView FitViewHeight];
    }
    
    self.contentTabelView.dataSource = self;
    self.contentTabelView.delegate = self;
    self.contentTabelView.backgroundColor = [UIColor blackColor];
    [self.contentTabelView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

#pragma  mark TableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    // Return the number of sections.
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // Return the number of rows in the section.
    if([self.bigTitle isEqualToString:@"特色旅游"]){
        if(self.dataSpecialTravel != nil){
            int count = [self.dataSpecialTravel->arraySpecialTravelInfo count];
            return count > 3 ? 3 : count;
        }
        return 0;
    }
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 166;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.backgroundColor   = [UIColor clearColor];
    cell.selectionStyle    = UITableViewCellSelectionStyleNone;
    cell.tag               = indexPath.row;
    NSUInteger row         = [indexPath row];

    if([self.bigTitle isEqualToString:@"特色旅游"]){
        SpecialTravelInfo * info = [self.dataSpecialTravel->arraySpecialTravelInfo objectAtIndex:row];
        [PictureHelper addPicture:info->imgUrl to:(UIImageView*)cell withSize:CGRectMake(0, 0, 300, 160)];
        return cell;
    }else{
        NSString *imageName    = [self.showImage objectAtIndex:row];
        UIImageView *imagview  = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
        imagview.frame         = CGRectMake(0, 0, 300, 160);
        [cell addSubview:imagview];
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    
    dongfangbaliViewController *dfblvc = [[dongfangbaliViewController alloc]init];
    if([self.bigTitle isEqualToString:@"特色旅游"]){
        SpecialTravelInfo * info = [self.dataSpecialTravel->arraySpecialTravelInfo objectAtIndex:indexPath.row];
        dfblvc.pathId = info->id;
        dfblvc.eScenicType = EDfbl;
        dfblvc.mainPictureUrl = info->imgUrl;
        
    }else{
        dfblvc.eScenicType = ELujiaZui_EExpo;
        dfblvc.mainPictureUrl = [self.showImage objectAtIndex:row];
    }
    
    
    dfblvc.showType = [[self.showTypes objectAtIndex:row] copy];
    dfblvc.buttonname1 = [self.buttonname1 objectAtIndex:row];
    dfblvc.buttonname2 = [self.buttonname2 objectAtIndex:row];

    [self.navigationController pushViewController:dfblvc animated:YES];
}
@end

