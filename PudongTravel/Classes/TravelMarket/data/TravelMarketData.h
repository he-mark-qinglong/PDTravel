//
//  TravelMarketData.h
//  PudongTravel
//
//  Created by mark on 14-4-1.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "BaseObject.h"

#if 0
//http://103.25.64.81:9500/mobile/travelmarket/getTravelList?pageNum=1
{
handlingTime: 95
    -info: [
            -{
            travelId: "0710df5a9de54ea8b1af124a5b6233e1"
            title: "超值套票上海一日游"
            imgUrl: http://192.168.43.66:8080/test/3.png
                -tags: [
                        "自由"
                        "景区"
                        ]
            travelTime: "3"
            price: 539
            viewId: "1710df5a9de54ea8b1afe2415b613371"
            }
            -{
            travelId: "0710df5a9de54ea8b1af124a5b6233e2"
            title: "浦东一日游"
            imgUrl: http://192.168.43.66:8080/test/3.png
                -tags: [
                        "组团"
                        "景区"
                        ]
            travelTime: "1"
            price: 539
            viewId: "1710df5a9de54ea8b1afe2415b613371"
            }
            -{
            travelId: "0710df5a9de54ea8b1af124a5b6233e3"
            title: "崇明双人二日游"
            imgUrl: http://192.168.43.66:8080/test/3.png
                -tags: [
                        "自由"
                        "景区，组团"
                        ]
            travelTime: "2"
            price: 539
            viewId: "1710df5a9de54ea8b1afe2415b613371"
            }
            -{
            travelId: "0710df5a9de54ea8b1af124a5b6233e4"
            title: "生态科技游"
            imgUrl: http://192.168.43.66:8080/test/3.png
                -tags: [
                        "组团"
                        "多日"
                        "美食"
                        ]
            travelTime: "3"
            price: 539
            viewId: "1710df5a9de54ea8b1afe2415b613371"
            }
            ]
}
#endif

@interface TravelMarketDataInfo : BaseObject{
    @public
    NSString *travelId;
    NSString *title;
    NSString *imgUrl;
    NSArray *tags;
    NSString *travelTime;
    NSString *price;
    NSString *viewId;
}
@end


@interface TravelMarketData : BaseObject{
    @public
    NSArray * arrayTravelMarketDataInfo;
}

@end

#if 0
{
handlingTime: 79
    -coupon: [
              -{
              couponId: "0710df5a9de54ea8b1afe24a5b6133e6"
              couponName: "Coco奶茶屋"
              price: "所有的可丽饼都优惠12元啦"
              remark: "聚美优品4月优惠券，满150元减15元聚美优品优惠券免费领取hot满150减15免费券立即领取还剩20天已领:19207今日剩余:297聚美优品优惠券"
              imgUrl: http://192.168.43.66:8080/test/3.png
              }
              -{
              couponId: "0710df5a9de54ea8b1afe24a5b6133e7"
              couponName: "Coco奶茶屋"
              price: "所有的可丽饼都优惠12元啦"
              remark: "聚美优品4月优惠券，满150元减15元聚美优品优惠券免费领取hot满150减15免费券立即领取还剩20天已领:19207今日剩余:297聚美优品优惠券"
              imgUrl: http://192.168.43.66:8080/test/3.png
              }
              ]
}
#endif

@interface TravelDetailCoupon : BaseObject{
@public
    NSString *couponId;
    NSString *couponName;
    NSString *price;
    NSString *remark;
    NSString *imgUrl;
}
@end
@interface TravelDetailInfo: BaseObject{
@public
    NSString *travelId;
    NSString *imgUrl;
    NSString *title;
    NSArray *tags;
    NSString *travelType;  //inusable ?
    NSString *travelTime;
    float price;
    NSString *viewId;  //new
    NSString *agencyName;
    NSString *agencyAdd;
    NSString *remark;
}@end

@interface TravelDetailData : BaseObject{
@public
    TravelDetailInfo *info;
}
@end

@interface CouponInfo : BaseObject
@property (nonatomic,strong) NSString *remark;
@property (nonatomic,strong) NSString *couponName;
@property (nonatomic,strong) NSString *couponId;
@property NSNumber* price;
@property NSString *imgUrl;
@end

@interface Coupon : BaseObject
@property (nonatomic,strong) CouponInfo *info;
@property (nonatomic,strong) NSNumber *handlingTime;
@end



#if 0
//http://192.168.41.19:8080/mobile/travelmarket/getCouponList?travelId=0710df5a9de54ea8b1afe24a5b6133e3&pageNum=1
#endif

