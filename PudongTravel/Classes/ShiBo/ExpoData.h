//
//  ExpoData.h
//  PudongTravel
//
//  Created by mark on 14-3-26.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "BaseObject.h"

#if 0
//ExpoViewDetail
{
    "handlingTime": 375,
    "info": {
        "id": "12312",
        "title": "世博园",
        "detail": "世博园世博园世博园世博园世博园"
    }
}
#endif

#if 0
//template
@interface <className>: BaseObject{
@public
    
    <memberType> jsonName;
    <MemberType, self definition> *info;
}
@end

@interface class: BaseObject{
@public
    
}
@end

#endif

@interface ExpoViewDetailInfo: BaseObject{
@public
    NSString *id;
    NSString *title;
    NSString *detail;
}
@end

@interface ExpoViewDetailData : BaseObject{
@public
    
    NSInteger handlingTime;
    ExpoViewDetailInfo *info;
    
}
@end

#if 0
//ExpoSecondView
{
    "handlingTime": 391,
    "info": [
             {
                 "id": "123123123",
                 "imgUrl": "expo.png",
                 "imgType": "1"
             },
             {
                 "id": "123123123",
                 "imgUrl": "expo.png",
                 "imgType": "2"
             },
             {
                 "id": "123123123",
                 "imgUrl": "expo.png",
                 "imgType": "2"
             }
             ]
}
#endif


@interface ExpoSecondViewInfo: BaseObject{
@public
    NSString *id;
    NSString *imgUrl;
    NSString *imgType;
}
@end

@interface ExpoSecondView: BaseObject{
@public
    NSInteger handlingTime;
    NSArray *arrayExpoSecondViewInfo;
}
@end

