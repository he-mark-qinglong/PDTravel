//
//  SuggestionTable.m
//  PudongTravel
//
//  Created by mark on 14-3-27.
//  Copyright (c) 2014年 mark. All rights reserved.
//

//设计：如果需要自己定义CELL，则可以在这里定义
//OtherTableView与这个TableView同理
#import "SuggestionTable.h"
#import "ScenicSpotViewController.h"
#import "ElseMainViewData.h"
#import "CommonHeader.h"
#import "ImangeCell.h"

@interface SuggestionTable()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) SuggestSceneData *data;
@property (strong, nonatomic) NSMutableArray *infoArray;
@property NSInteger pageNo;
@end

@implementation SuggestionTable


- (id)initWithFrame:(CGRect)frame{
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

-(void)loadDataFromWeb:(BOOL)more{
    if(!self.infoArray)
        self.infoArray = [[NSMutableArray alloc] init];
    
    if(more){
        self.pageNo++;
    }else{
        self.pageNo = 1;
        [self.infoArray removeAllObjects];
    }
    NSString *path = [NSString stringWithString:(NSString*)getTjList];
    path = [path stringByAppendingString:
            [NSString stringWithFormat:@"?pageNum=%d",self.pageNo]];
    [HTTPAPIConnection postPathToGetJson:(NSString*)path block:^(NSDictionary *json, NSError *error){
        if ([json objectForKey:@"info"] == nil) {
            //空数据
            self.pageNo--;
            [self reloadData];
            return;
        }

        self.data = [[SuggestSceneData alloc] init];
        [self.data updateWithJsonDic:json];
        [self.infoArray addObjectsFromArray:self.data->arraySuggestSceneInfo];
        
        [self reloadData];
    }];
}

#pragma mark tableveiwdelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    // Return the number of sections.
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section{
    [HUDHandle stopLoading];
    self.pullTableIsRefreshing = NO;
    self.pullTableIsLoadingMore = NO;
    // Return the number of rows in the section.
    return self.infoArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"ImangeCell";
    //自定义cell类
    ImangeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        //通过xib的名称加载自定义的cell
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ImangeCell" owner:self options:nil] lastObject];
    }
    NSUInteger row = [indexPath row];
    
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
   
  
    SuggestSceneInfo * info = [self.infoArray objectAtIndex:row];
    [PictureHelper addPicture:info->imgUrl to:cell.bgImageview
                     withSize:CGRectMake(0, 0, 320, 129)];
    cell.title.text = info->title;
    return cell;
}

-(void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ScenicSpotViewController *ssvc = [[ScenicSpotViewController alloc]init];
    
    SuggestSceneInfo * info = [self.infoArray objectAtIndex:indexPath.row];
    ssvc.idStr = info->id;
    ssvc.merchantOrSceneTitleText = @"商户信息";
    [self.navController pushViewController:ssvc animated:YES];
}

@end
