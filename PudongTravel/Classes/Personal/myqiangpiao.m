//
//  myqiangpiao.m
//  pudongapp
//
//  Created by jiangjunli on 14-2-26.
//  Copyright (c) 2014年 jiangjunli. All rights reserved.
//

#import "myqiangpiao.h"
#import "myqiangpiaoCell.h"
#import "RightViewController.h"
#import "StoreCell.h"
#import "myyuyinbaoCell.h"
#import "mydianpingCell.h"
#import "MyOrderCell.h"
#import "SetingCell.h"
#import "CouponDetailCell.h"
#import "HTTPAPIConnection.h"
#import "ConstLinks.h"
#import "LocalCache.h"
#import "User.h"
#import "AlertViewHandle.h"
#import "OrderDetailView.h"


@implementation myqiangpiao

-(void)awakeFromNib
{
    self.tablelview.delegate = self;
    self.tablelview.dataSource = self;
    self.tablelview.backgroundColor = [UIColor clearColor];
    [self.tablelview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tablelview.pullDelegate = self;
    self.tablelview.pullBackgroundColor=[UIColor clearColor];
     [[NSNotificationCenter defaultCenter] addObserver:self
                                              selector:@selector(storeCellListener:)
                                                  name:StoreCellNSNotification
                                                     object:nil];
}
-(void)willMoveToSuperview:(UIView *)newSuperview{
    static BOOL addFromSuperView = YES;
    if(addFromSuperView){
        [self loadDataFromWeb:NO];
    }
    addFromSuperView = !addFromSuperView;
}
- (IBAction)backBtnClick:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showTable" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self removeFromSuperview];
}
- (void)storeCellListener:(NSNotification*)notification
{
    StoreCell *cell = [notification object];
    NSIndexPath *indexpath = [self.tablelview indexPathForCell:cell];
   NSString *path = [NSString stringWithString:(NSString*)deleteStore];
    path = [path stringByAppendingString:
            [NSString stringWithFormat:@"?id=%@",cell.storeid]];
    [HTTPAPIConnection postPathToGetJson:path block:^(NSDictionary *json, NSError *error)
     {
         
         UpdateanicknameData *data = [UpdateanicknameData new];
         [data updateWithJsonDic:json];
         if ([data->code isEqualToString:@"71"]) {
             [self.arrayToShow removeObjectAtIndex:indexpath.row];
             [self.tablelview deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexpath] withRowAnimation:UITableViewRowAnimationFade];
             
              [AlertViewHandle showAlertViewWithMessage:@"删除成功"];
             [[NSNotificationCenter defaultCenter] postNotificationName:@"getnumber" object:nil];
         }else{
             [AlertViewHandle showAlertViewWithMessage:@"删除失败"];
         }
     }
     ];
}
- (void)dealloc
{
     self.tablelview.delegate = nil;
}

#pragma mark - PullTableViewDelegate
- (void)pullTableViewDidTriggerRefresh:(PullTableView *)pullTableView
{
    [self performSelector:@selector(refreshTable) withObject:nil afterDelay:2.0f];
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView *)pullTableView
{
    [self performSelector:@selector(loadMoreDataToTable) withObject:nil afterDelay:2.0f];
}

-(void)refreshTable{
    [self loadDataFromWeb:NO];
    
}
-(void)loadMoreDataToTable{
    [self loadDataFromWeb:YES];
}


#pragma mark data
-(void)loadDataFromWeb:(BOOL)more{
    if(!self.arrayToShow)
        self.arrayToShow = [[NSMutableArray alloc] init];
    if(more){
        self.pageNo++;
    }else{
        self.pageNo = 1;
        [self.arrayToShow removeAllObjects];
    }
    
    User *user = [[LocalCache sharedCache] cachedObjectForKey:@"user"];
    NSString * userid = user.userId;
    
    
    NSString *path = nil;
    switch (self.cellType) {
        case EStoreCell:{   //我的收藏
            path = [NSString stringWithString:(NSString*)userStoreList];
            path = [path stringByAppendingString:
                    [NSString stringWithFormat:@"?userId=%@&pageNum=%d",userid,self.pageNo]];
            [HTTPAPIConnection postPathToGetJson:path block:^(NSDictionary *json, NSError *error)
             {
                 if(error){
                     //TODO 错误处理
                     [self.tablelview reloadData];
                     return;
                 }else{
                     UserStoreListData *data = [UserStoreListData new];
                     [data updateWithJsonDic:json];
                     [self.arrayToShow addObjectsFromArray: data->arrayUserStoreListInfo];
                     [self.tablelview reloadData];
                     self.tablelview.pullTableIsRefreshing = NO;
                     self.tablelview.pullTableIsLoadingMore = NO;
                 }
             }];
            break;
        }
        case ECommentCell:{    //我的点评
            path = [NSString stringWithString:(NSString*)userCommentList];
            path = [path stringByAppendingString:
                    [NSString stringWithFormat:@"?userId=%@&pageNum=%d",userid,self.pageNo]];
            [HTTPAPIConnection postPathToGetJson:path block:^(NSDictionary *json, NSError *error)
             {
                 if(error){
                     //TODO 错误处理
                     [self.tablelview reloadData];
                     return ;
                 }else{
                     UserCommentListData *data = [UserCommentListData new];
                     [data updateWithJsonDic:json];
                     [self.arrayToShow addObjectsFromArray:data->arrayUserCommentListInfo];
                     [self.tablelview reloadData];
                     self.tablelview.pullTableIsRefreshing = NO;
                     self.tablelview.pullTableIsLoadingMore = NO;
                 }
                 
             }];
            break;
        }
        case ECouponDetailCell:{//    我的优惠卷
            path = [NSString stringWithString:(NSString*)userCouponList];
            path = [path stringByAppendingString:
                    [NSString stringWithFormat:@"?userId=%@&pageNum=%d",userid,self.pageNo]];
            [HTTPAPIConnection postPathToGetJson:path block:^(NSDictionary *json, NSError *error)
             {
                 if(error){
                     //TODO 错误处理
                     [self.tablelview reloadData];
                     return ;
                 }else{
                     UserCouponListData *data = [UserCouponListData new];
                     [data updateWithJsonDic:json];
                     [self.arrayToShow addObjectsFromArray:data->arrayUserCouponListInfo];
                     if ([self.arrayToShow count] <= 0) {
                         [AlertViewHandle showAlertViewWithMessage:@"你还么有优惠卷，请去添加优惠卷"];
                     }
                     [self.tablelview reloadData];
                     self.tablelview.pullTableIsRefreshing = NO;
                     self.tablelview.pullTableIsLoadingMore = NO;
                 }
                 
             }];
            break;
        }
        case EOrderCell:{    //我的预定
            path = [NSString stringWithString:(NSString*)userOrderList];
            path = [path stringByAppendingString:
                    [NSString stringWithFormat:@"?userId=%@&pageNum=%d",userid,self.pageNo]];
            [HTTPAPIConnection postPathToGetJson:path block:^(NSDictionary *json, NSError *error)
             {
                 if(error){
                     //TODO 错误处理
                     [self.tablelview reloadData];
                     return ;
                 }else{
                     UserOrderListData *data = [UserOrderListData new];
                     [data updateWithJsonDic:json];
                     [self.arrayToShow addObjectsFromArray:data->arrayUserOrderListInfo];
                     [self.tablelview reloadData];
                     self.tablelview.pullTableIsRefreshing = NO;
                     self.tablelview.pullTableIsLoadingMore = NO;
                 }
             }];
            break;
        }
        case ETicketCell:{    //我的抢票
            path = [NSString stringWithString:(NSString*)userTicketList];
            path = [path stringByAppendingString:
                    [NSString stringWithFormat:@"?userId=%@&pageNum=%d",userid,self.pageNo]];
            [HTTPAPIConnection postPathToGetJson:path block:^(NSDictionary *json, NSError *error)
             {
                 if(error){
                     //TODO 错误处理
                     [self.tablelview reloadData];
                     return ;
                 }else{
                     UserTicktListData *data = [UserTicktListData new];
                     [data updateWithJsonDic:json];
                     [self.arrayToShow addObjectsFromArray:data->arrayUserTicktListInfo];
                     [self.tablelview reloadData];
                     self.tablelview.pullTableIsRefreshing = NO;
                     self.tablelview.pullTableIsLoadingMore = NO;
                 }
             }];
        }
        case EVoiceCell:{    //我的语音包
            path = [NSString stringWithString:(NSString*)userVoiceList];
            path = [path stringByAppendingString:
                    [NSString stringWithFormat:@"?userId=%@&pageNum=%d",userid,self.pageNo]]; 
            [HTTPAPIConnection postPathToGetJson:path block:^(NSDictionary *json, NSError *error)
             {
                 if(error){
                     //TODO 错误处理
                     [self.tablelview reloadData];
                     return ;
                 }else{
                     UserVoiceListData *data = [UserVoiceListData new];
                     [data updateWithJsonDic:json];
                     [self.arrayToShow addObjectsFromArray:data->arrayUserVoiceListInfo];
                     [self.tablelview reloadData];
                     self.tablelview.pullTableIsRefreshing = NO;
                     self.tablelview.pullTableIsLoadingMore = NO;
                 }
             }];
            break;
        }
        default:
            break;
    }
}

#pragma mark UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.arrayToShow count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (self.cellType) {
        case ECommentCell:
            return 145;
            break;
        case EVoiceCell:
            return 70;
            break;
        case EStoreCell:
        case ECouponDetailCell:
        case EOrderCell:
        case ETicketCell:
        default:
            return 80;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    int row = indexPath.row;
    
    
    switch (self.cellType) {
        case EStoreCell:{
            return [StoreCell cell:[self.arrayToShow objectAtIndex:row]];
            break;
        }
        case ECommentCell:{
            return[mydianpingCell cell:[self.arrayToShow objectAtIndex:row]];
            break;
        }
        case ECouponDetailCell:{
            return [CouponDetailCell cell:[self.arrayToShow objectAtIndex:row]];
            break;
        }
        case EOrderCell:{
            return [MyOrderCell cell:[self.arrayToShow objectAtIndex:row]];
            break;
        }
        case ETicketCell:{
            return [myqiangpiaoCell cell:[self.arrayToShow objectAtIndex:row]];
            break;
        }
        case EVoiceCell:
            return [myyuyinbaoCell cell:[self.arrayToShow objectAtIndex:row]];
        default:
            return nil;
            break;
    }
  
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (self.cellType) {
        case ECommentCell:
            
            break;
        case EVoiceCell:
            break;
        case EStoreCell:{
            StoreCell *cell = (StoreCell *)[self.tablelview cellForRowAtIndexPath:indexPath];
            [cell handleDetail];
            break;
        }
        case ECouponDetailCell:{
            CouponDetailCell *cell = (CouponDetailCell *)[self.tablelview cellForRowAtIndexPath:indexPath];
            [cell handleDetail];
        }
            break;
        case EOrderCell:
        {
            MyOrderCell *cell = (MyOrderCell *)[self.tablelview cellForRowAtIndexPath:indexPath];
            [cell handleDetail];
        }
            
            break;
        case ETicketCell:{
            myqiangpiaoCell *cell = (myqiangpiaoCell *)[self.tablelview cellForRowAtIndexPath:indexPath];
            [cell handleDetail];
        }
            break;
        default:
            break;
    }
    return;
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
//        [self.arrayToShow removeObjectAtIndex:indexPath.row];
//        [self.tablelview deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}





@end
