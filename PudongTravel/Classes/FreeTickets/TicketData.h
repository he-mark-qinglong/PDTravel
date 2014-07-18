//
//  TicketData.h
//  PudongTravel
//
//  Created by mark on 14-4-14.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "BaseObject.h"

#if 0
ticketId: "0710df5a9de54ea8b1afe24a5b6133e3"
imgUrl: http://192.168.43.66:8080/test/2.png
currTime: "2014-04-14 14:13:41"
ticketName: "龙之梦影城蜘蛛侠"
startTime: "2014-04-13 12:00:00"
endTime: "2014-04-12 00:00:00"
validTime: "2013年12月5日-- 2014年12月5日"
surplusCnt: 3
remark: "自2014年1月8日起，“G”字头列车起售时间移至14：00，“D”、“C”字头列车起售时间仍为11：00。普通列车起售时间，请旅客按乘车站查询。"
#endif

@interface TicketInfo : BaseObject

@property (nonatomic,strong) NSString *ticketId;
@property (nonatomic,strong) NSString *imgUrl;
@property (nonatomic,strong) NSString *currTime;
@property (nonatomic,strong) NSString *ticketName;
@property (nonatomic,strong) NSString *startTime;
@property (nonatomic,strong) NSString *endTime;
@property (nonatomic,strong) NSString *validStartTime;
@property (nonatomic,strong) NSString *validEndTime;
@property (nonatomic,strong) NSNumber *surplusCnt;
@property (nonatomic,strong) NSString *remark;
@property (nonatomic,strong) NSString *nextFlag;
@end

@interface TicketData : BaseObject

@property (nonatomic,strong) TicketInfo *info;
@property (nonatomic,strong) NSNumber *handlingTime;

@end