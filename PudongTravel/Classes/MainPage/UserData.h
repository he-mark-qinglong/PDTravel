//
//  UserData.h
//  PudongTravel
//
//  Created by jiangjunli on 14-4-10.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "BaseObject.h"

@interface UserInfo : BaseObject{
@public
    NSString *userId;
    NSString *nickName;
    NSString *userName;
    NSString *storeCnt;
    NSString *commonCnt;
    NSString *imgUrl;
}@end

@interface  UserData: BaseObject{
@public
    UserInfo *info;
    NSString *code;
}
@end

@interface RegierInfo :BaseObject
{
    @public
    NSString *userId;
    NSString *nickName;
    NSString *userName;
    NSInteger storeCnt;
    NSInteger commonCnt;
    NSString *imgUrl;
}
@end
@interface RegierData: BaseObject
{
@public
    RegierInfo *info;
    NSString *code;

}

@end
#if 0
http://192.168.43.66:8080/mobile/user/updateNickName?userId=123&nickName=12
{
    "handlingTime":15,
    "code":"70"
}
70 表示 数据到最后一页或者已经到期（没有该信息）
71 表示成功
72 表示 重复记录状态码
73 表示 重复存在状态码
74 表示用户账号为空
75 表示用密码为空
76 表示账号或者密码有错误
77 表示用户昵称为空
78 表示 密码与确认密码不匹配
79 表示新旧密码不匹配
#endif
//delete 也是用的这个
@interface UpdateanicknameData : BaseObject
{
    @public
    NSString *code;
}
@end

@interface UserStoreListInfo : BaseObject
{
@public
    NSString * id;
    NSString * storeId;
    NSString * storeTitle;
    NSString * phone;
    NSString * address;
    NSString * date;
    NSString * tableType;
}
@end

@interface UserStoreListData:BaseObject
{
@public
    NSArray *arrayUserStoreListInfo;
}
@end

@interface UserCommentListInfo : BaseObject
{
@public
    NSString * commentId;
    NSString * merchantName;
    NSString * merchantTag;
    NSString * contents;
    NSMutableArray  * imgUrl;
    float score;
    NSString * date;
}
@end
@interface UserCommentListData : BaseObject
{
    @public
    NSArray *arrayUserCommentListInfo;
}
@end


@interface UserCouponListInfo : BaseObject
{
    @public
    NSString * id;
    NSString * merName;
    NSString * couponName;
    NSString * couponId;
    NSString * validTime;
    NSString * address;
}
@end
@interface UserCouponListData : BaseObject
{
    @public
    NSArray *arrayUserCouponListInfo;
}

@end

@interface CouponDetailInfo : BaseObject
{
    @public
    NSString * merName;
    NSString * couponName;
    NSString * validTime;
    NSString * address;
    NSString * remark;
}
@end



@interface UserOrderListInfo : BaseObject
{
    @public
    NSString * marketId;
    NSString * orderNum;
    NSString * date;
    NSString * address;
    NSString * title;
}
@end

@interface UserOrderListData : BaseObject
{
    @public
    NSArray *arrayUserOrderListInfo;
}
@end


@interface UserVoiceListInfo : BaseObject
{
    @public
    NSString * id;
    NSString * voiceId;
    NSString * viewName;
    NSString * viewArea;
    NSString * title;
}
@end

@interface UserVoiceListData : BaseObject
{
    @public
    NSArray *arrayUserVoiceListInfo;
}

@end


@interface UserTicktListInfo : BaseObject
{
    @public
    NSString * id;
    NSString * merName;
    NSString * ticketId;
    NSString * ticketName;
    NSString * tag;
    NSString * validTime;
    NSString * address;
}
@end

@interface UserTicktListData : BaseObject
{
    @public
    NSArray *arrayUserTicktListInfo;
}
@end

@interface UserOrderDetailInfo : BaseObject{
  @public
    NSString * title;
    NSString * marketType;
    NSString * validTime;
    NSString * phone;
    NSString * address;
    NSString * introduction;
    NSString * remark;
}
@end

@interface UserTicktDetailInfo : BaseObject
{
    @public
    NSString * merName;
    NSString * ticketName;
    NSString * validTime;
    NSString * phone;
    NSString * address;
    NSString * remark;
}
@end

@interface GetNumberInfo : BaseObject
{
    @public
    NSString * commentCnt;
    NSString * storeCnt;
}

@end

