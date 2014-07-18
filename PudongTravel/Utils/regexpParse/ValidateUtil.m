//
//  ValidateUtil.m
//  WhereWeGo
//
//  Created by lifuyong on 14-1-15.
//  Copyright (c) 2014年 lifuyong. All rights reserved.
//

#import "ValidateUtil.h"

@implementation ValidateUtil

+ (ValidateResult)validatePhoneNumber:(NSString *)phoneNumber
{
    if (![self validateEmptyString:phoneNumber]) {
        return Empty;
    }
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression
                                  regularExpressionWithPattern:@"^(1(([35][0-9])|(47)|[8][012356789]))\\d{8}$"
                                  options:0
                                  error:&error];
    
    if (regex != nil) {
        NSTextCheckingResult *firstMatch = [regex firstMatchInString:phoneNumber
                                                             options:0
                                                               range:NSMakeRange(0, [phoneNumber length])];
        if (firstMatch) {
            return Right;
        }
    }
    return NotMatch;
}
+ (ValidateResult)validatePassword:(NSString *)password
{
    if (![self validateEmptyString:password]) {
        return Empty;
    }
    if (password.length < 6 || password.length > 16) {
        return NotMatch;
    }
    return Right;
}
+ (BOOL)validateEmptyString:(NSString *)string
{
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if (string == nil || [string isEqualToString:@""]) {
        return NO;
    }
    return YES;
}

@end
