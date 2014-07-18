//
//  NSString+Cuting.m
//  PudongTravel
//
//  Created by duwei on 14-4-23.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "NSString+Interception.h"

typedef enum
{
    Interception_back,
    Interception_front
}InterceptionType;

@implementation NSString (Interception)

- (NSString*)backWardsSearchInterception:(NSString*)string
{
    return [self stringInterception:string options:Interception_front];
}

- (NSString*)frontWardsSearchInterception:(NSString*)string;
{
    return [self stringInterception:string options:Interception_back];
}

- (NSString*)stringInterception:(NSString*)string options:(InterceptionType)mask;

{
    if(string == nil || string.length == 0 || string.length == self.length)
        return nil;
    
    NSRange subToRange = [self rangeOfString:string options:NSBackwardsSearch];
    
    int location = -1;
    if(subToRange.length > 0)
    {
        if (self.length <= subToRange.location + string.length)
            location = self.length;
        else
            location = subToRange.location + string.length;
    }
    
    if (location != -1)
    {
        if (mask == Interception_front)//ttp:wwww.baidu.com/
            return [self substringFromIndex:location];
        else
            return [self substringToIndex:location];

    }
    return nil;
}

@end
