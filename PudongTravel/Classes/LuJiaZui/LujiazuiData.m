//
//  LujiazuiData.m
//  PudongTravel
//
//  Created by mark on 14-3-25.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "LujiazuiData.h"

@implementation LujiazuiInfo @end
@implementation SmallImg @end
@implementation BigImg @end

@implementation LujiazuiData
- (void)updateWithJsonDic:(NSDictionary*)jsonDic{
    [super updateWithJsonDic:jsonDic];
    
    self->info = [[LujiazuiInfo alloc] init];
    [self->info updateWithJsonDic: [jsonDic objectForKey: @"info"]];
    
    self->bigImg = [[BigImg alloc]init];
    [self->bigImg updateWithJsonDic:[jsonDic objectForKey: @"bigImg"]];
    
    //处理数组的情况
    NSArray *arrayDic = [jsonDic objectForKey:@"smallImg"];
    if(arrayDic != nil){
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for(NSDictionary * dic in arrayDic){
            //变动点 begin
            SmallImg *item = [[SmallImg alloc] init];
            
            [item updateWithJsonDic:dic];
            [array addObject:item];
        }
        //变动点 begin
        self->arraySmallImg = array;
    }
}
@end

@implementation LujiazuiSecondViewInfo @end

@implementation  LujiazuiSecondViewData
- (void)updateWithJsonDic:(NSDictionary*)jsonDic{
    [super updateWithJsonDic:jsonDic];
    
    //处理数组的情况
    NSArray *arrayDic = [jsonDic objectForKey:@"info"];
    if(arrayDic != nil){
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for(NSDictionary * dic in arrayDic){
            //变动点 begin
            LujiazuiSecondViewInfo *info = [[LujiazuiSecondViewInfo alloc] init];
            
            [info updateWithJsonDic:dic];
            [array addObject:info];
        }
        //变动点 begin
        self->arrayLujiazuiSecondViewInfo = array;
    }
}
@end


@implementation LujiazuiOneViewInfo @end

@implementation  LujiazuiOneViewData
- (void)updateWithJsonDic:(NSDictionary*)jsonDic{
    [super updateWithJsonDic:jsonDic];
    
    //处理数组的情况
    NSArray *arrayDic = [jsonDic objectForKey:@"info"];
    if(arrayDic != nil){
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for(NSDictionary * dic in arrayDic){
            //变动点 begin
            LujiazuiOneViewInfo *info = [[LujiazuiOneViewInfo alloc] init];
            
            [info updateWithJsonDic:dic];
            [array addObject:info];
        }
        //变动点 begin
        self->arrayLujiazuiOneViewInfo = array;
    }
}
@end

@implementation SpecialTravelInfo @end
@implementation SpecialTravel

-(void)updateWithJsonDic:(NSDictionary *)jsonDic{
    [super updateWithJsonDic:jsonDic];
    
    jsonDic = [jsonDic objectForKey:@"info"];
    if(jsonDic){
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for(NSDictionary * dic in jsonDic){
            //变动点 begin
            SmallImg *item = [[SmallImg alloc] init];
            
            [item updateWithJsonDic:dic];
            [array addObject:item];
        }
        //变动点 begin
        self->arraySpecialTravelInfo = array;
    }
}
@end