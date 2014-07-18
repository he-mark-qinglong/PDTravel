//
//  ConstLinks.h
//  PudongTravel
//
//  Created by mark on 14-3-25.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "HTTPAPIConnection.h"

//#define RELEASE_URL 1
#if RELEASE
//正式版的数据，只用于实习生测试数据使用。没发布前不要打开
//////////#define TEST_DATA_RELEASE 1
//#define TEST_PROGRAM_RELEASE 1
#endif

#define YANGLIANG 1


#if RELEASE_URL

#if TEST_DATA_RELEASE
static const NSString *kAPIBaseURLString   = @"http://103.25.64.81:9500/mobile-test/";
#else
static const NSString *kAPIBaseURLString   = @"http://103.25.64.81:9500/pd-mobile/";
#endif

#elif YANGLIANG
static const NSString *kAPIBaseURLString   = @"http://114.80.9.3:8080/pd-mobile/";
//static const NSString *kAPIBaseURLString   = @"http://103.25.64.82:9502/pd-mobile/";
//static const NSString *kAPIBaseURLString   = @"http://192.168.41.64:8080/pd-mobile/";
#else
static const NSString *kAPIBaseURLString   = @"http://192.168.0.66:8080/mobile-test/";
#endif

#pragma mark - 主页
static const NSString *getCarouselList   = @"carousel/getCarouselList";
static const NSString *getCarouselDetail = @"carousel/getCarouselDetail";

#pragma  mark - 陆家嘴
static const NSString *getTjxDetail    = @"lujiazui/getTjxDetail";
static const NSString *getMsjdList     = @"lujiazui/getMsjdList";
static const NSString *getTjxZbtjList  = @"lujiazui/getTjxZbtjList";

static const NSString *getDfblDetail   = @"lujiazui/getDfblDetail";
static const NSString *getSsshList     = @"lujiazui/getSsshList";
static const NSString *getXzysList     = @"lujiazui/getXzysList";

static const NSString *getJrjlyDetail  = @"lujiazui/getJrjlyDetail";
static const NSString *getJrjyList     = @"lujiazui/getJrjyList";
static const NSString *getJrjlyZbtjList= @"lujiazui/getJrjlyZbtjList";
#pragma  mark - 世博园
//a
static const NSString *getSbfhDetail = @"expo/getSbfhDetail";
static const NSString *getYzsgList   = @"expo/getYzsgList";
static const NSString *getQtcgList   = @"expo/getQtcgList";
//b
static const NSString *getSbxgDetail = @"expo/getSbxgDetail";
static const NSString *getSbxgList   = @"expo/getSbxgList";
static const NSString *getTjcgList   = @"expo/getTjcgList";
//c
static const NSString *getSbjyDetail = @"expo/getSbjyDetail";
static const NSString *getZgzyList   = @"expo/getZgzyList";
static const NSString *getZbxxList   = @"expo/getZbxxList";

/*
 userId(用户id)
 viewId(景点Id)
 score(评分)
 contents(评论内容)
 */

#pragma  mark - 推荐路线
//参数同 《陆家嘴／世博园》模块
static const NSString *getPathList   = @"path/getPathList";
//三个模块用一样的网络接口
static const NSString *getPathDetail = @"path/getPathDetail";
static const NSString *getXctjList   = @"path/getXctjList";
static const NSString *getZbtjList   = @"path/getZbtjList";

#pragma  mark - 其他景点
static const NSString *getTjList        = @"view/getTjList";
static const NSString *getElseList      = @"view/getElseList";
static const NSString *getViewDetail    = @"view/getViewDetail";  //?viewId=
static const NSString *getMerchantIntro = @"view/getMerchantIntro";  //?viewId=
static const NSString *getCouponList    = @"view/getCouponList";  ///&pageNum=1
static const NSString *getCouponDetail  = @"view/getCouponDetail";  //couponId=1
static const NSString *storeCoupon      = @"view/storeCoupon";
static const NSString *addCoupon        = @"view/addCoupon";

static const NSString *getVoiceList     = @"view/getVoiceList";  //viewId(景区Id)&pageNum(当前所在页)
static const NSString *getCommentList   = @"view/getCommentList";  //viewId(景点Id)&pageNum(当前所在页)
static const NSString *getVoicePic      = @"view/getVoicePic";
//点评功能
static const NSString *saveUserComment  = @"view/saveUserComment";  //viewId=&UserId=score contents

//加入收藏 功能
static const NSString *storeView        = @"view/storeView";//?viewId=&UserId=

static const NSString *orderTicket      = @"view/orderTicket";


//点评功能

#pragma  mark - 找附近
static const NSString *getNearList    = @"near/getNearList";
static const NSString *getNearDisList = @"near/getNearDisList";
static const NSString *getStopList    = @"stop/getStopList";

#pragma  mark - 节庆活动
static const NSString *getActivityList   = @"activity/getActivityList";
static const NSString *getActivityDetail = @"activity/getActivityDetail";

#pragma  mark - 免费抢票
static const NSString *currShowTicket  = @"ticket/currShowTicket";
static const NSString *nextTicket      = @"ticket/nextTicket";
static const NSString *grabTicket      = @"ticket/grabTicket";

#pragma  mark - 旅游大超市
static const NSString *getTravelList       = @"travelmarket/getTravelList";
static const NSString *getTravelDetail     = @"travelmarket/getTravelDetail";

static const NSString *getTravelCouponList = @"travelmarket/getCouponList";
/*
 1:travelId(主键Id)
 2：pageNum(当前所在页)
 */

static const NSString *getTtravelCouponDetail = @"travelmarket/getCouponDetail";
/*
 1:couponId(优惠券Id)
 */

static const NSString *addOrder = @"travelmarket/addOrder";
/*
 1:marketId(大超市Id)  //travelId
 2:userId(用户Id)
 3:orderTime(预定的日期)
 4:orderNum(预定的票数)
 */
static const NSString *addStore = @"travelmarket/addStore";
/*@param
 1:marketId(大超市Id)  //travelId
 2:userId(用户Id)
 */

#pragma  mark - 个人中心

//static const NSString *getVoiceList;  = @"view/getVoiceList"; //其他景点里已定义
static const NSString *reg             = @"user/reg";//?1:account=(账户)&passWord=(密码)&passWordAgain=(确认密码)&nickName=(用户昵称)
static const NSString *login           = @"user/login";//1:account(帐户)&passWord=（密码）

static const NSString *updateNickName  = @"user/updateNickName";//1:userId(用户Id)2:nickName(用户昵称)

static const NSString *updatePassWord  = @"user/updatePassWord";//1：userId(用户Id2：nowPassWord(用户当前登陆的密码)3：newPassWord(新密码)4：againPassWord(确认新密码)
static const NSString *checkVersion    = @"user/checkVersion";
static const NSString *userStoreList   = @"user/userStoreList";
static const NSString *deleteStore     = @"user/deleteStore";
static const NSString *userCommentList = @"user/userCommentList";
static const NSString *userCouponList  = @"user/userCouponList";
static const NSString *deleteCoupon    = @"user/deleteCoupon";
static const NSString *couponDetail    = @"user/couponDetail";
static const NSString *userOrderList   = @"user/userOrderList";
static const NSString *userOrderDetail = @"user/userOrderDetail";
static const NSString *userTicketList  = @"user/userTicketList";
static const NSString *deleteTicket    = @"user/deleteTicket";
static const NSString *getTicketDetail = @"user/getTicketDetail";
static const NSString *userVoiceList   = @"user/userVoiceList";

static const NSString *updateHeadImg   = @"user/updateHeadImg";

//static const NSString *userVoiceList=@"user/userVoiceList";

static const NSString *getNumberInfo   = @"user/getNumberInfo";

static const NSString *verification    = @"user/verification";
static const NSString *regCheck        = @"user/regCheck";
#pragma  mark - common Or others

static const NSString *getStopViewList = @"view/getStopViewList";

