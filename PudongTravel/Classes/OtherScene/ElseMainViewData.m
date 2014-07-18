//
//  ElseMainViewData.m
//  PudongTravel
//
//  Created by mark on 14-3-26.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "ElseMainViewData.h"

@implementation ElseMainViewDataInfo @end

@implementation ElseMainViewData
-(void)updateWithJsonDic:(NSDictionary *)jsonDic{
    [super updateWithJsonDic:jsonDic];
    
    //处理数组的情况
    NSArray *arrayDic = [jsonDic objectForKey:@"info"];
    if(arrayDic != nil){
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for(NSDictionary * dic in arrayDic){
            //变动点
            ElseMainViewDataInfo *info = [[ElseMainViewDataInfo alloc] init];
            [info updateWithJsonDic:dic];
            [array addObject:info];
        }
        //变动点
        self->arrayElseMainViewDataInfo = array;
    }
}
@end

@implementation ElseViewInfo @end
@implementation ElseViewData @end

@implementation ViewDetailInfo @end
@implementation ViewDetailData
-(void)updateWithJsonDic:(NSDictionary *)jsonDic{
    [super updateWithJsonDic:jsonDic];
    self->info = [[ViewDetailInfo alloc]init];
    [self->info updateWithJsonDic:[jsonDic objectForKey:@"info"]];
}
@end

@implementation MerchantIntroInfo @end
@implementation MerchantIntroData
-(void)updateWithJsonDic:(NSDictionary *)jsonDic{
    [super updateWithJsonDic:jsonDic];
    
    self->info = [[MerchantIntroInfo alloc] init];
    [self->info updateWithJsonDic:[jsonDic objectForKey:@"info"]];
}
@end

@implementation VoiceInfo @end

@implementation VoiceData
-(void)updateWithJsonDic:(NSDictionary *)jsonDic{
    [super updateWithJsonDic:jsonDic];
    
    NSDictionary *infoDic = [jsonDic objectForKey:@"info"];
    if(infoDic){
        self->arrayVoiceInfo = [NSMutableArray new];
        for (NSDictionary *item in infoDic){
            VoiceInfo *vInfo  = [VoiceInfo new];
            [vInfo updateWithJsonDic:item];
            [self->arrayVoiceInfo addObject:vInfo];
        }
    }
}
@end


@implementation ElseSceneInfo @end
@implementation ElseSceneData
-(void)updateWithJsonDic:(NSDictionary *)jsonDic{
    [super updateWithJsonDic:jsonDic];
    
    //处理数组的情况
    NSArray *arrayDic = [jsonDic objectForKey:@"info"];
    if(arrayDic != nil){
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for(NSDictionary * dic in arrayDic){
            //变动点
            ElseSceneInfo *item = [[ElseSceneInfo alloc] init];
            [item updateWithJsonDic:dic];
            [array addObject:item];
        }
        //变动点
        self->arrayElseSceneInfo = array;
    }
}
@end

@implementation SuggestSceneInfo @end
@implementation SuggestSceneData
-(void)updateWithJsonDic:(NSDictionary *)jsonDic{
    [super updateWithJsonDic:jsonDic];
    
    //处理数组的情况
    NSArray *arrayDic = [jsonDic objectForKey:@"info"];
    if(arrayDic != nil){
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for(NSDictionary * dic in arrayDic){
            //变动点
            SuggestSceneInfo *item = [[SuggestSceneInfo alloc] init];
            [item updateWithJsonDic:dic];
            [array addObject:item];
        }
        //变动点
        self->arraySuggestSceneInfo = array;
    }
}
@end

@implementation CommentInfo
-(void)updateWithJsonDic:(NSDictionary *)jsonDic{
    [super updateWithJsonDic:jsonDic];
    //处理数组的情况
    NSArray *arrayDic = [jsonDic objectForKey:@"commentImg"];
    if(arrayDic != nil  && ![arrayDic isKindOfClass:[NSNull class]]){
        NSMutableArray *array = [NSMutableArray new];
        for(NSString * item in arrayDic){
            //变动点
            [array addObject:item];
        }
        //变动点
        self->commentImg = array;
    }
}
@end

@implementation CommentData
-(void)updateWithJsonDic:(NSDictionary *)jsonDic{
    [super updateWithJsonDic:jsonDic];
    //处理数组的情况
    NSArray *arrayDic = [jsonDic objectForKey:@"info"];
    if(arrayDic != nil){
        NSMutableArray *array = [NSMutableArray new];
        for(NSDictionary * dic in arrayDic){
            //变动点
            CommentInfo *item = [CommentInfo new];
            [item updateWithJsonDic:dic];
            [array addObject:item];
        }
        //变动点
        self->info = array;
    }
}

@end