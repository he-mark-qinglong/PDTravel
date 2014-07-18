//
//  SuggestionTable_Nearby.m
//  PudongTravel
//
//  Created by mark on 14-3-27.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "SuggestionTable_Nearby.h"
#import "FoodCell.h"
#import "ScenicSpotViewController.h"
#import "DDMenuController.h"
#import "CommonHeader.h"
#import "BaiDuMapManager.h"

@interface SuggestionTable_Nearby()
<UITableViewDelegate,UITableViewDataSource>
@property NearbySuggestionData *data;
@end

@implementation SuggestionTable_Nearby
@synthesize arrayToShow, pageNo;

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
    
    BaiDuMapManager *map = [BaiDuMapManager ShareInstrance ];

    NSString *path = [NSString stringWithString:(NSString*)getNearList];
    path = [path stringByAppendingString:
            [NSString stringWithFormat:@"?pageNum=%d&isPush=1&type=%d&lat=%f&lng=%f",
             self.pageNo, self.vctype, map.currentLocation.latitude, map.currentLocation.longitude]];
    [HTTPAPIConnection postPathToGetJson:(NSString*)path block:^(NSDictionary *json, NSError *error){
        if ([json objectForKey:@"info"] == nil) {
            //空数据
            [self reloadData];
            return;
        }
        
        self.data = [NearbySuggestionData new];
        [self.data updateWithJsonDic:json];
        [self.arrayToShow addObjectsFromArray:self.data->arrayNearbySuggestionInfo];
        
        [self reloadData];
    }];
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.arrayToShow count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"FoodCell";
    //自定义cell类
    FoodCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        //通过xib的名称加载自定义的cell
        cell = [[[NSBundle mainBundle] loadNibNamed:@"FoodCell" owner:self options:nil] lastObject];
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ScenicSpotViewController *ssvc = [[ScenicSpotViewController alloc]init];
    ssvc.merchantOrSceneTitleText = @"景区信息";
    [self.navController pushViewController:ssvc animated:YES];
}
@end
