//
//  FestivalData.m
//  PudongTravel
//
//  Created by mark on 14-4-9.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "FestivalData.h"

@implementation FestivalInfo
@end

@implementation FestivalData
-(void)updateWithJsonDic:(NSDictionary *)jsonDic{
    [super updateWithJsonDic:jsonDic];
    
    //处理数组的情况
    NSArray *arrayDic = [jsonDic objectForKey:@"info"];
    if(arrayDic != nil){
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for(NSDictionary * dic in arrayDic){
            //变动点 begin
            FestivalInfo *item = [[FestivalInfo alloc] init];
            
            [item updateWithJsonDic:dic];
            [array addObject:item];
        }
        //变动点 begin
        self->arrayFestivalInfo = array;
    }
}
@end

@implementation FestivalDetailInfo @end
@implementation FestivalDetail
-(void)updateWithJsonDic:(NSDictionary *)jsonDic{
    [super updateWithJsonDic:jsonDic];
    
    self->info = [FestivalDetailInfo new];
    [self->info updateWithJsonDic:[jsonDic objectForKey:@"info"]];
}
@end