//
//  LujiazuiData.h
//  PudongTravel
//
//  Created by mark on 14-3-25.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "BaseObject.h"

@interface SmallImg:BaseObject{
@public
    NSString *id;
    NSString *imgUrl;
    NSString *title;
}@end
@interface BigImg:BaseObject{
@public
    NSString *id;
    NSString *imgUrl;
    NSString *title;
}@end
@interface LujiazuiInfo:BaseObject{
@public
    NSString *id;
    NSString *title;
    NSString *detail;
}@end

@interface LujiazuiData : BaseObject{
@public
    LujiazuiInfo *info;
    NSArray *arraySmallImg;
    BigImg *bigImg;
}
@end

@interface LujiazuiSecondViewInfo:BaseObject{
@public
    NSString *id;
    NSString *imgUrl;
    NSString *imgType;
}
@end

@interface  LujiazuiSecondViewData: BaseObject{
@public
    NSArray *arrayLujiazuiSecondViewInfo;
}
@end

@interface LujiazuiOneViewInfo : BaseObject
{
    @public
    NSString *id;
    NSString *title;
    NSString *imgUrl;
}
@end
@interface  LujiazuiOneViewData : BaseObject
{
@public
   NSArray *arrayLujiazuiOneViewInfo;
}
@end

#pragma mark 特色旅游 json解析
@interface SpecialTravelInfo : BaseObject{
@public
    NSString *id;
    NSString *imgUrl;
}
@end


@interface SpecialTravel : BaseObject{
@public
    NSArray *arraySpecialTravelInfo;
}
@end

