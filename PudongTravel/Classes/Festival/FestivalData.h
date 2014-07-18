//
//  FestivalData.h
//  PudongTravel
//
//  Created by mark on 14-4-9.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "BaseObject.h"

#if 0
//http://192.168.43.66:8080/mobile/activity/getActivityList?pageNum=1
//
{
handlingTime: 16
    -info: [
            -{
            activityId: "054ab8713c45486b9cf2b7375d06c0b1"
            imgUrl: http://192.168.43.66:8080/test/1.png
            title: "test"
            }
            -{
            activityId: "100"
            imgUrl: http://192.168.43.66:8080/test/1.png
            title: "浦东绿地铂骊酒店品珍轩中餐厅海鲜优惠大酬宾"
            }
            -{
            activityId: "102"
            imgUrl: http://192.168.43.66:8080/test/1.png
            title: "千株樱花绽放世纪公园"
            }
            -{
            activityId: "103"
            imgUrl: http://192.168.43.66:8080/test/1.png
            title: "见证生命的奇迹——IMAX巨幕新片《最后的珊瑚礁3D》在上海科技馆全新上映"
            }
            ]
}
#endif

@interface FestivalInfo : BaseObject{
@public
    NSString *activityId;
    NSString *imgUrl;
    NSString *title;
}
@end

@interface FestivalData : BaseObject{
    @public
    NSArray * arrayFestivalInfo;
}
@end

#if 0
{
handlingTime: 16
    -info: {
    activityId: "054ab8713c45486b9cf2b7375d06c0b1"
    title: "test"
    remark: "<img src="http://192.168.43.66:9090/img/8471461a-e07f-456e-b61d-30ace25c336f.jpg" alt="" />"
    address: null
    activityTime: null
    phone: null
    trafic: null
    }
}
#endif
@interface FestivalDetailInfo: BaseObject{
@public
    NSString *activityId     ;
    NSString *title          ;
    NSString *remark         ;
    NSString *address        ;
    NSString *activityTime   ;
    NSString *        phone  ;
    NSString *        trafic ;
}
@end
@interface FestivalDetail: BaseObject{
    @public
    FestivalDetailInfo *info;
}
@end
