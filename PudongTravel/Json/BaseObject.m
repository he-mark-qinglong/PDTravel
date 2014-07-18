//
//  BaseObject.m
//  QianJiHuDong
//
//  Created by lifuyong on 13-9-29.
//  Copyright (c) 2013年 lifuyong. All rights reserved.
//

#import "BaseObject.h"

@implementation BaseObject

- (void)updateWithJsonDic:(NSDictionary*)jsonDic
{
    if([jsonDic isKindOfClass:[NSNull class]]){
        @throw [[NSException alloc] initWithName:@"json解析数据异常" reason:@"jsonDic不应该为空" userInfo:jsonDic];
        return;
    }
    
    for (NSString *key in [jsonDic allKeys]) {
        id value = [jsonDic objectForKey:key];
        if([value isKindOfClass:[NSNull class]]){
            continue;
        }
        
        NSString *strValue;
        if([value isKindOfClass:[NSString class]]){
            [self setValue:value forKey:key];
        }
        if([value isKindOfClass:[NSNumber class]]){
            strValue = [NSString stringWithFormat:@"%@", value];
            [self setValue:strValue forKey:key];
        }
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
 //   NSLog(@"undifined key: %@, value: %@", key, value);
    return;
}

@end
