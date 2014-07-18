//
//  OtherTable_Nearby.m
//  PudongTravel
//
//  Created by mark on 14-3-27.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "OtherTable_Nearby.h"
#import "FoodCell.h"
#import "ScenicSpotViewController.h"
#import "BaiDuMapManager.h"

@interface  OtherTable_Nearby()<UITableViewDelegate,UITableViewDataSource>
@property ElseSceneData *data;
@end

@implementation OtherTable_Nearby
@synthesize pageNo, arrayToShow;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}

-(void)loadDataFromWeb:(BOOL)more{
    if(arrayToShow == nil){
        arrayToShow = [NSMutableArray new];
    }
    if(more){
        self.pageNo++;
    }else{
        self.pageNo = 1;
        [self.arrayToShow removeAllObjects];
    }
    
    BaiDuMapManager *map = [BaiDuMapManager ShareInstrance];
    NSString *path = [getNearList copy];
    path = [path stringByAppendingString:
            [NSString stringWithFormat:@"?pageNum=%d&isPush=%d&type=%d&lat=%f&lng=%f",
             self.pageNo, self.isPush, self.vctype,
             map.currentLocation.latitude, map.currentLocation.longitude]];
    [HTTPAPIConnection postPathToGetJson:(NSString*)path block:^(NSDictionary *json, NSError *error){
        if ([json objectForKey:@"info"] == nil) {
            /*
            //空数据
            ElseSceneInfo *info = [ElseSceneInfo new];
            
            info->address = @"闸北";
            info->distince = @"2km";
            info->imgUrl = @"http://img.nr99.com/attachment/forum/201403/30/142508tw53jbupm5tpmfqt.jpg";
            info->title = @"好吃的土豆黄瓜";
            info->id = @"不知道id是多少";
            info->busTime  = @"上午9:00-下午6:00";
            info->phone = @"18502192585";
            info->score = 5.1;
            
            [self.arrayToShow addObject:info];
            */
            self.pageNo--;
            [self reloadData];
            return;
        }
        
        self.data = [ElseSceneData new];
        [self.data updateWithJsonDic:json];
        [self.arrayToShow addObjectsFromArray:self.data->arrayElseSceneInfo];
        
        [self reloadData];
    }];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    self.pullTableIsRefreshing = NO;
    self.pullTableIsLoadingMore = NO;
    [HUDHandle stopLoading];
    
    return [self.arrayToShow count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"FoodCell";
    FoodCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"FoodCell" owner:self options:nil] lastObject];
    }
    NSUInteger row = [indexPath row];
    ElseSceneInfo *info = [self.arrayToShow objectAtIndex:row];
   
    [cell setContentWith:info];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ScenicSpotViewController *ssvc = [[ScenicSpotViewController alloc]init];
    ssvc.merchantOrSceneTitleText = @"景区信息";
    NSUInteger row = [indexPath row];
    ElseSceneInfo *info = [self.arrayToShow objectAtIndex:row];
    ssvc.idStr = info->nearId;
    [self.navController pushViewController:ssvc animated:YES];
}


@end