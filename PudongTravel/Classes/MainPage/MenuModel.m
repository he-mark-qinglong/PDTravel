//
//  MenuModel.m
//  PudongTravel
//
//  Created by mark on 14-5-28.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "MenuModel.h"

@implementation MainPageInfo @end

@implementation MainPageData

-(void)updateWithJsonDic:(NSDictionary *)jsonDic{
    [super updateWithJsonDic:jsonDic];
    
    //处理数组的情况
    NSArray *arrayDic = [jsonDic objectForKey:@"info"];
    if(arrayDic != nil){
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for(NSDictionary * dic in arrayDic){
            //变动点 begin
            MainPageInfo *info = [[MainPageInfo alloc] init];
            
            [info updateWithJsonDic:dic];
            [array addObject:info];
        }
        //变动点 begin
        self->arrayMainPageInfo = array;
    }
    
}

@end
