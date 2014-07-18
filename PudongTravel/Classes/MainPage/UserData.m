//
//  UserData.m
//  PudongTravel
//
//  Created by jiangjunli on 14-4-10.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "UserData.h"

@implementation UserInfo @end

@implementation UserData
-(void)updateWithJsonDic:(NSDictionary *)jsonDic{
    [super updateWithJsonDic:jsonDic];

    if([jsonDic objectForKey:@"info"]){
        self->info = [UserInfo new];
        [self->info updateWithJsonDic:[jsonDic objectForKey:@"info"]];
    }else
        self->info = nil;
}


@end

@implementation RegierInfo @end

@implementation RegierData
-(void)updateWithJsonDic:(NSDictionary *)jsonDic{
    [super updateWithJsonDic:jsonDic];
    
    if([jsonDic objectForKey:@"info"]){
        self->info = [RegierInfo new];
        [self->info updateWithJsonDic:[jsonDic objectForKey:@"info"]];
    }else
        self->info = nil;
    }

@end
@implementation UpdateanicknameData @end


@implementation UserStoreListInfo @end

@implementation UserStoreListData

- (void)updateWithJsonDic:(NSDictionary*)jsonDic{
    [super updateWithJsonDic:jsonDic];
    
    //处理数组的情况
    NSArray *arrayDic = [jsonDic objectForKey:@"info"];
    if(arrayDic != nil){
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for(NSDictionary * dic in arrayDic){
            //变动点 begin
            UserStoreListInfo *info = [[UserStoreListInfo alloc] init];
            
            [info updateWithJsonDic:dic];
            [array addObject:info];
        }
        //变动点 begin
        self->arrayUserStoreListInfo = array;
    }
}
@end


@implementation UserCommentListInfo
- (void)updateWithJsonDic:(NSDictionary*)jsonDic{
    [super updateWithJsonDic:jsonDic];
    
    //处理数组的情况
    NSArray *arrayDic = [jsonDic objectForKey:@"imgUrl"];
    if(arrayDic != nil){
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for(NSString * url in arrayDic){
            [array addObject:url];
        }
        //变动点 begin
        self->imgUrl = array;
    }
}

@end

@implementation UserCommentListData

- (void)updateWithJsonDic:(NSDictionary*)jsonDic{
    [super updateWithJsonDic:jsonDic];
    
    //处理数组的情况
    NSArray *arrayDic = [jsonDic objectForKey:@"info"];
    if(arrayDic != nil){
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for(NSDictionary * dic in arrayDic){
            //变动点 begin
            UserCommentListInfo *info = [[UserCommentListInfo alloc] init];
            
            [info updateWithJsonDic:dic];
            [array addObject:info];
        }
        //变动点 begin
        self->arrayUserCommentListInfo = array;
    }
}
@end

@implementation UserCouponListInfo @end

@implementation UserCouponListData

- (void)updateWithJsonDic:(NSDictionary*)jsonDic{
    [super updateWithJsonDic:jsonDic];
    
    //处理数组的情况
    NSArray *arrayDic = [jsonDic objectForKey:@"info"];
    if(arrayDic != nil){
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for(NSDictionary * dic in arrayDic){
            //变动点 begin
            UserCouponListInfo *info = [[UserCouponListInfo alloc] init];
            
            [info updateWithJsonDic:dic];
            [array addObject:info];
        }
        //变动点 begin
        self->arrayUserCouponListInfo = array;
    }
}
@end


@implementation CouponDetailInfo @end



@implementation UserOrderListInfo @end
@implementation UserOrderListData

- (void)updateWithJsonDic:(NSDictionary*)jsonDic{
    [super updateWithJsonDic:jsonDic];
    
    //处理数组的情况
    NSArray *arrayDic = [jsonDic objectForKey:@"info"];
    if(arrayDic != nil){
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for(NSDictionary * dic in arrayDic){
            //变动点 begin
            UserOrderListInfo *info = [[UserOrderListInfo alloc] init];
            
            [info updateWithJsonDic:dic];
            [array addObject:info];
        }
        //变动点 begin
        self->arrayUserOrderListInfo = array;
    }
}

@end
@implementation UserVoiceListInfo @end
@implementation UserVoiceListData

- (void)updateWithJsonDic:(NSDictionary*)jsonDic{
    [super updateWithJsonDic:jsonDic];
    
    //处理数组的情况
    NSArray *arrayDic = [jsonDic objectForKey:@"info"];
    if(arrayDic != nil){
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for(NSDictionary * dic in arrayDic){
            //变动点 begin
            UserVoiceListInfo *info = [[UserVoiceListInfo alloc] init];
            
            [info updateWithJsonDic:dic];
            [array addObject:info];
        }
        //变动点 begin
        self->arrayUserVoiceListInfo = array;
    }
}

@end

@implementation UserTicktListInfo @end
@implementation UserTicktListData

- (void)updateWithJsonDic:(NSDictionary*)jsonDic{
    [super updateWithJsonDic:jsonDic];
    
    //处理数组的情况
    NSArray *arrayDic = [jsonDic objectForKey:@"info"];
    if(arrayDic != nil){
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for(NSDictionary * dic in arrayDic){
            //变动点 begin
            UserTicktListInfo *info = [[UserTicktListInfo alloc] init];
            
            [info updateWithJsonDic:dic];
            [array addObject:info];
        }
        //变动点 begin
        self->arrayUserTicktListInfo = array;
    }
}
@end

@implementation UserOrderDetailInfo @end

@implementation UserTicktDetailInfo @end

@implementation GetNumberInfo @end
