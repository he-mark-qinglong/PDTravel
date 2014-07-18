//
//  User.m
//  PudongTravel
//
//  Created by jiangjunli on 14-4-15.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "User.h"

@implementation User
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.userName  = [aDecoder decodeObjectForKey:@"userName"];
        self.userId    = [aDecoder decodeObjectForKey:@"userId"];
        self.nickName  = [aDecoder decodeObjectForKey:@"nickName"];
        self.imgUrl    = [aDecoder decodeObjectForKey:@"imgUrl"];
        self.storeCnt  = [aDecoder decodeObjectForKey:@"storeCnt"];
        self.commonCnt = [aDecoder decodeObjectForKey:@"commonCnt"];
        self.isLoginSuccess = [aDecoder decodeBoolForKey:@"isLoginSuccess"];
        self.password  = [aDecoder decodeObjectForKey:@"password"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.userName forKey:@"userName"];
	[coder encodeObject:self.userId forKey:@"userId"];
    [coder encodeObject:self.nickName forKey:@"nickName"];
    [coder encodeObject:self.imgUrl forKey:@"imgUrl"];
    [coder encodeObject:self.storeCnt forKey:@"storeCnt"];
    [coder encodeObject:self.commonCnt forKey:@"commonCnt"];
    [coder encodeBool:self.isLoginSuccess forKey:@"isLoginSuccess"];
    [coder encodeObject:self.password forKey:@"password"];
}

@end
