//
//  TicketData.m
//  PudongTravel
//
//  Created by mark on 14-4-14.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "TicketData.h"

@implementation TicketInfo
@end

@implementation TicketData
-(void)updateWithJsonDic:(NSDictionary *)jsonDic{
    [super updateWithJsonDic:jsonDic];
    
    self.info = [TicketInfo new];
    [self.info updateWithJsonDic:[jsonDic objectForKey:@"info"]];
}
@end