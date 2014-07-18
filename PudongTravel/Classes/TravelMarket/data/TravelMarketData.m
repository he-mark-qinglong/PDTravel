//
//  TravelMarketData.m
//  PudongTravel
//
//  Created by mark on 14-4-1.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "TravelMarketData.h"

@implementation TravelMarketDataInfo
-(void)updateWithJsonDic:(NSDictionary *)jsonDic{
    [super updateWithJsonDic:jsonDic];
    
    NSDictionary *tagsDic = [jsonDic objectForKey:@"tags"];
    if(tagsDic){
        NSMutableArray *array = [NSMutableArray new];
        for(NSString *tag in tagsDic){
            [array addObject:tag];
        }
        tags = array;
    }
}
@end

@implementation TravelMarketData
- (void)updateWithJsonDic:(NSDictionary*)jsonDic{
    [super updateWithJsonDic:jsonDic];
        //处理数组的情况
    NSArray *arrayDic = [jsonDic objectForKey:@"info"];
    if(arrayDic != nil){
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for(NSDictionary * dic in arrayDic){
            //变动点 begin
            TravelMarketDataInfo *info = [[TravelMarketDataInfo alloc] init];
            
            [info updateWithJsonDic:dic];
            [array addObject:info];
        }
        //变动点 begin
        self->arrayTravelMarketDataInfo = array;
    }
}
@end

@implementation TravelDetailCoupon
@end

@implementation TravelDetailInfo
-(void)updateWithJsonDic:(NSDictionary *)jsonDic{
    [super updateWithJsonDic:jsonDic];
    NSDictionary *tagsDic = [ jsonDic objectForKey:@"tags"];
    if(tagsDic){
        NSMutableArray *array = [NSMutableArray new];
        for(NSString *tag in tagsDic){
            [array addObject:tag];
        }
        tags = array;
        self->tags = array;
        
    }
}
@end

@implementation TravelDetailData
- (void)updateWithJsonDic:(NSDictionary*)jsonDic{
    [super updateWithJsonDic:jsonDic];
    
    info = [TravelDetailInfo new];
    [info updateWithJsonDic:[jsonDic objectForKey:@"info"]];
}
@end

@implementation CouponInfo
@end

@implementation Coupon
-(void)updateWithJsonDic:(NSDictionary *)jsonDic{
    [super updateWithJsonDic:jsonDic];
    NSDictionary *dic = [jsonDic objectForKey:@"info"];
    if(dic){
        self.info = [CouponInfo new];
        [self.info updateWithJsonDic:dic];
    }
}
@end