//
//  ValidateUtil.h
//  WhereWeGo
//
//  Created by lifuyong on 14-1-15.
//  Copyright (c) 2014年 lifuyong. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    Right,
    Empty,
    NotMatch
}ValidateResult;

@interface ValidateUtil : NSObject

+ (ValidateResult)validatePhoneNumber:(NSString *)phoneNumber;
+ (ValidateResult)validatePassword:(NSString *)password;

@end
