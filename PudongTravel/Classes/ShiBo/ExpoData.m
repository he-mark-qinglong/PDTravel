//
//  ExpoData.m
//  PudongTravel
//
//  Created by mark on 14-3-26.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "ExpoData.h"

#if 0
@implementation CLass
@end
#endif

@implementation ExpoViewDetailInfo
@end

@implementation ExpoViewDetailData
-(void)updateWithJsonDic:(NSDictionary *)jsonDic{
    [self updateWithJsonDic:jsonDic];
    self->info = [[ExpoViewDetailInfo alloc] init];
    [self->info updateWithJsonDic:jsonDic];
}
@end

@implementation ExpoSecondViewInfo
@end



@implementation ExpoSecondView
-(void)updateWithJsonDic:(NSDictionary *)jsonDic{
    [super updateWithJsonDic:jsonDic];
    
    //处理数组的情况
    NSArray *arrayDic = [jsonDic objectForKey:@"info"];
    if(arrayDic != nil){
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for(NSDictionary * dic in arrayDic){
            //变动点
            ExpoSecondViewInfo *info = [[ExpoSecondViewInfo alloc] init];
            [info updateWithJsonDic:dic];
            [array addObject:info];
        }
        //变动点
        self->arrayExpoSecondViewInfo = array;
    }

}
@end