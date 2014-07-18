//
//  OtherTableView.m
//  PudongTravel
//
//  Created by mark on 14-3-27.
//  Copyright (c) 2014年 mark. All rights reserved.
//

//设计：如果需要自己定义CELL，则可以在这里定义
//SuggestionTanbleView与这个TableView同理
#import "OtherTableView.h"
#import "CommonHeader.h"

#import "ScenicSpotViewController.h"
#import "FoodCell.h"
#import "ElseMainViewData.h"
#import "BaiDuMapManager.h"

@interface OtherTableView()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) NSMutableArray *infoArray;
@property (strong, nonatomic) ElseSceneData *data;
@property NSInteger pageNo;
//@property
@end

@implementation OtherTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = [UIColor clearColor];
        [self setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }
    
    return self;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */
#pragma mark data
-(void)loadDataFromWeb:(BOOL)more{
    if(!self.infoArray)
        self.infoArray = [[NSMutableArray alloc] init];
    if(more){
        self.pageNo++;
    }else{
        self.pageNo = 1;
        [self.infoArray removeAllObjects];
    }
    
    BaiDuMapManager *map = [BaiDuMapManager ShareInstrance];
    NSString *lat = [NSString stringWithFormat:@"%f", map.currentLocation.latitude];
    NSString *lng = [NSString stringWithFormat:@"%f", map.currentLocation.longitude];
    NSString *path = [NSString stringWithString:(NSString*)getElseList];
    path = [path stringByAppendingString:
            [NSString stringWithFormat:@"?pageNum=%d&lat=%@&lng=%@", self.pageNo, lat, lng]];
    [HTTPAPIConnection postPathToGetJson:(NSString*)path block:^(NSDictionary *json, NSError *error){
        if ([json objectForKey:@"info"] == nil) {
            //空数据
            self.pageNo--;
            [self reloadData];
            return;
        }
        self.data = [[ElseSceneData alloc] init];
        [self.data updateWithJsonDic:json];
        [self.infoArray addObjectsFromArray:self.data->arrayElseSceneInfo];
       
        [self reloadData];
    }];
}
#pragma mark tableveiwDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [HUDHandle stopLoading];
    self.pullTableIsRefreshing = NO;
    self.pullTableIsLoadingMore = NO;
    
    // Return the number of rows in the section.
    return [self.infoArray count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"FoodCell";
    //自定义cell类
    FoodCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        //通过xib的名称加载自定义的cell
        cell = [[[NSBundle mainBundle] loadNibNamed:@"FoodCell" owner:self options:nil] lastObject];
    }
    NSUInteger row = [indexPath row];
    ElseSceneInfo *info = [self.infoArray objectAtIndex:row];
    //添加测试数据
    [cell setContentWith:info];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ScenicSpotViewController *ssvc = [ScenicSpotViewController new];

    ElseSceneInfo * info = [self.infoArray objectAtIndex:indexPath.row];
    ssvc.idStr = info->id;

    ssvc.merchantOrSceneTitleText = @"商户信息";
    [self.navController pushViewController:ssvc animated:YES];
}


@end
