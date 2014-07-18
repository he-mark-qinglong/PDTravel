//
//  User.h
//  PudongTravel
//
//  Created by jiangjunli on 14-4-15.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject<NSCoding>

@property (strong, nonatomic) NSString *userId;
@property (strong, nonatomic) NSString *nickName;
@property (strong, nonatomic) NSString *userName;
@property (strong, nonatomic) NSString *storeCnt;
@property (strong, nonatomic) NSString *commonCnt;
@property (strong, nonatomic) NSString *imgUrl;
@property (strong, nonatomic) NSString *password;

@property BOOL isLoginSuccess;  //本地保存的字段，确定登录状态

@end

