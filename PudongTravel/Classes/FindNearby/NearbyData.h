//
//  NearbyData.h
//  PudongTravel
//
//  Created by mark on 14-4-24.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "BaseObject.h"

@interface NearbyData : BaseObject{
    @public
}
@end

@interface NearbyOtherInfo : BaseObject{
    @public
    NSString *nearId;
    NSString *imgUrl;
    NSString *merName;
    NSString *pushTag;
    NSString *score;
    NSString *address;
    NSString *distance;
    NSString *title;
    //地图模块使用的数据，在列表模式中不会显示
    float lat;
    float lng;
}
@end

@interface NearbyOtherData : BaseObject{
    @public
    NSMutableArray *arrayNearbyOtherInfo;
}
@end


@interface NearbySuggestionInfo : BaseObject{
    @public
    NSString *detail;
}
@end
@interface NearbySuggestionData : BaseObject{
    @public
    NSMutableArray *arrayNearbySuggestionInfo;
}
@end

@interface CarParkInfo : BaseObject{
@public
    NSString *name;
    NSString *address;
    NSString *feeText;
   
    float lat;
    float lng;
}
-(NearbyOtherInfo*)convertToNearbyOtherInfo;
@end

@interface CarParkData : BaseObject{
@public
    NSMutableArray *arrayCarParkInfo;
}

@end

