//
//  NearbyData.m
//  PudongTravel
//
//  Created by mark on 14-4-24.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "NearbyData.h"

@implementation NearbyData

@end


@implementation NearbyOtherInfo
-(void)updateWithJsonDic:(NSDictionary *)jsonDic{
    [super updateWithJsonDic:jsonDic];
    if(self->merName == nil){
        self->merName = self->title;
    }
}
@end

@implementation NearbyOtherData
-(void)updateWithJsonDic:(NSDictionary *)jsonDic{
    [super updateWithJsonDic:jsonDic];
    
    //处理数组的情况
    NSArray *arrayDic = [jsonDic objectForKey:@"info"];
    if(arrayDic != nil){
        NSMutableArray *array = [NSMutableArray new];
        for(NSDictionary * dic in arrayDic){
            //变动点
            NearbyOtherInfo *item = [NearbyOtherInfo new];
            [item updateWithJsonDic:dic];
            [array addObject:item];
        }
        //变动点
        self->arrayNearbyOtherInfo = array;
    }
}
@end

@implementation NearbySuggestionInfo @end

@implementation NearbySuggestionData
-(void)updateWithJsonDic:(NSDictionary *)jsonDic{
    [super updateWithJsonDic:jsonDic];
    //处理数组的情况
    NSArray *arrayDic = [jsonDic objectForKey:@"info"];
    if(arrayDic != nil){
        NSMutableArray *array = [NSMutableArray new];
        for(NSDictionary * dic in arrayDic){
            //变动点
            NearbySuggestionInfo *item = [NearbySuggestionInfo new];
            [item updateWithJsonDic:dic];
            [array addObject:item];
        }
        //变动点
        self->arrayNearbySuggestionInfo = array;
    }
}

@end

@implementation CarParkInfo
-(NearbyOtherInfo*)convertToNearbyOtherInfo{
    NearbyOtherInfo *info = [NearbyOtherInfo new];
    info->address = self->address;
    info->lat = self->lat;
    info->lng = self->lng;
    info->merName = self->name;
    return info;
}
@end

@implementation CarParkData
-(void)updateWithJsonDic:(NSDictionary *)jsonDic{
    [super updateWithJsonDic:jsonDic];
    //处理数组的情况
    NSArray *arrayDic = [jsonDic objectForKey:@"info"];
    if(arrayDic != nil){
        NSMutableArray *array = [NSMutableArray new];
        for(NSDictionary * dic in arrayDic){
            //变动点
            CarParkInfo *item = [CarParkInfo new];
            [item updateWithJsonDic:dic];
            [array addObject:item];
        }
        //变动点
        self->arrayCarParkInfo = array;
    }
}


@end


