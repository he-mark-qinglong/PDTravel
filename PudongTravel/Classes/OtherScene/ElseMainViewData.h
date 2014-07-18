//
//  ElseMainViewData.h
//  PudongTravel
//
//  Created by mark on 14-3-26.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "BaseObject.h"

@interface ElseMainViewDataInfo: BaseObject{
@public
    NSString *mainId;
    NSString *imgUrl;
}@end
@interface ElseMainViewData : BaseObject{
    @public
    float handlingTime;
    NSArray *arrayElseMainViewDataInfo;
}@end

@interface ElseViewInfo: BaseObject{
@public
    NSString *mainId;
    NSString *imgUrl;
}@end
@interface ElseViewData: BaseObject{
@public
    NSArray *arrayElseViewInfo;
}@end

@interface ViewDetailInfo: BaseObject{
@public
    NSString *id;         //"id": null,
    NSString *imgUrl;     //"imgUrl": "123123.png",
    NSString *grade;      //"grade": "5A",
    NSString *title;      //"title": "东方明珠电视塔",
    NSString *lat;        //"lat": "121.213123",
    NSString *lng;        //"lng": "30.123122",
    NSString *phone;      //"phone": "021-86189898",
    float score;      //"score": "10.5",
    NSString *peopleWarn; //"peopleWarn": "1"
}
@end
@interface ViewDetailData: BaseObject{
@public
    ViewDetailInfo *info;
}@end

@interface MerchantIntroInfo: BaseObject{
@public
    NSString *viewId;       //    "viewId": "123123123",
    NSString *grade;        //    "grade": "5A",
    NSString *title;        //    "title": "东方明珠电视塔",
    NSString *remark;       //    "remark": "陆家嘴东方明珠电视塔简介",
    NSString *businessTime; //    "businessTime": "11:00 - 22:00",
    NSString *add;          //    "add": "陆家嘴99号",
    NSString *trafic;       //    "trafic": "地铁2号线"
}@end
@interface MerchantIntroData: BaseObject{
@public
    MerchantIntroInfo *info;
}@end

@interface VoiceInfo : BaseObject
{
@public
    NSString * voiceId;
    NSString * area;
    NSString * title;
    NSString * imgUrl;
    NSString * voiceUrl;
    //网络数据不提供这个数据，但是可以通过URL截取出来.
    NSString * fileName;
}@end

@interface VoiceData : BaseObject{
@public
    float HandlingTime;
    NSMutableArray * arrayVoiceInfo;
}
@end
@interface ElseSceneInfo:BaseObject{
@public
    NSString *nearId       ;  //"0710df5a9de54ea8b1afe24a5b6a44e3"
    NSString *id;  //用在其他景点里面，和nearId不同，nearId是用在找附近的数据
    NSString *imgUrl   ;  //http://192.168.43.66:8099/static/attachments/20140317164819.png
    NSString *title    ;  //"TET"
    NSString *busTime  ;  //null
    NSString *phone    ;  //"021-81929201"
    NSString *address  ;  //null
    float distance ;  //"76m"
    float distince;  //更多景点二级界面距离不一样
    float score    ;  //4.5
}@end

@interface ElseSceneData :BaseObject{
@public
    NSArray *arrayElseSceneInfo;
}@end

//这个其实可以借用ElseSceneInfo类的数据，只是其他成员不用填充
@interface SuggestSceneInfo : BaseObject {
    @public
    NSString *id;
    NSString *imgUrl;
    NSString *title;
}@end
@interface SuggestSceneData :BaseObject{
@public
    NSArray *arraySuggestSceneInfo;
}
@end

@interface CommentInfo : BaseObject{
    @public
    NSString * headImg;
    NSString * nickName;
    float score;
    NSString * contents;
    NSMutableArray * commentImg;
    NSString * time;
}
@end

@interface CommentData : BaseObject{
    @public
    float handlingTime;
    NSMutableArray * info;
}


@end
