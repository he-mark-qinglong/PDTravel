//
//  PictureTableView.m
//  PudongTravel
//
//  Created by mark on 14-4-4.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "PictureTableView.h"
#import "PictureCell.h"
#import "ScenicSpotViewController.h"
#import "CommonHeader.h"
#import "LujiazuiData.h"
#import "LeftCell.h"


@interface PictureTableView()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) NSMutableArray *imageDataArray;
@property NSInteger pageNo;
//@property
@end

@implementation PictureTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

#pragma mark tableveiwdelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    [self setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    self.pullTableIsLoadingMore = NO;
    self.pullTableIsRefreshing = NO;

    [HUDHandle stopLoading];
    return [self.imageDataArray count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 360;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = indexPath.row;
    static NSString *cellIdentifier = @"";
    if(!self.isLeftViewDifferent){  //外部设置table的时候设置的
        cellIdentifier = @"PictureCell";
        //自定义cell类
        PictureCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            //通过xib的名称加载自定义的cell
            cell = [[[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil] lastObject];
        }
        [cell setContent:[self.imageDataArray objectAtIndex:row ]];
        cell.backgroundColor = [UIColor clearColor];
        cell.viewController = self.viewController;
        return cell;
    }
    else{  //4张图片
        cellIdentifier = @"LeftCell";
        LeftCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            //通过xib的名称加载自定义的cell
            cell = [[[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil] lastObject];
        }
        [cell setContent:[self.imageDataArray objectAtIndex:row ]
         row:row];
        cell.backgroundColor = [UIColor clearColor];
        cell.viewController = self.viewController;
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

-(void)loadDataFromWeb:(BOOL)more{
    if(!self.imageDataArray)
        self.imageDataArray = [[NSMutableArray alloc] init];
    if(more){
        self.pageNo++;
    }else{
        self.pageNo = 1;
        [self.imageDataArray removeAllObjects];
        //更新数据后记得更新table，否则cellForIndex会索引到数组外面，因为没有更新table的长度
        //更新table长度
        [self reloadData];
    }

    NSString *path = [NSString stringWithString:(NSString*)self.path];
    if(!self.isLeftViewDifferent){
        path = [path stringByAppendingFormat:@"?pageNum=%d",self.pageNo];
        [HTTPAPIConnection postPathToGetJson:(NSString*)path
                                       block:^(NSDictionary *json, NSError *error)
         {
             if ( ([json objectForKey:@"bigImg"] == nil  && [json objectForKey:@"smallImg"] == nil)
                 || error != nil ) {
                 //空数据
                 self.pageNo--;
                 [self reloadData];
                 return;
             }
             LujiazuiData *data = [LujiazuiData new];
             [data updateWithJsonDic:json];
             [self.imageDataArray addObject:data];
             
             if(self.pageNo == 1){
                 [self loadDataFromWeb:YES];
             }else{
                 [self reloadData];
             }
         }];
    }else{
        path = [path stringByAppendingFormat:@"?pageNum=%d&pathId=%@",self.pageNo, self.pathId];
        [HTTPAPIConnection postPathToGetJson:(NSString*)path
                                       block:^(NSDictionary *json, NSError *error)
        {
            if ([json objectForKey:@"info"] == nil) {
                //空数据
                [self reloadData];
                return;
            }
            LujiazuiOneViewData *data = [LujiazuiOneViewData new];
            [data updateWithJsonDic:json];
            [self.imageDataArray addObject:data];
            
            if(self.pageNo == 1){
                [self loadDataFromWeb:YES];
            }else{
                [self reloadData];
            }
        }];
    }
}
@end
