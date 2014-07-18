//
//  NSString+Cuting.h
//  PudongTravel
//
//  Created by duwei on 14-4-23.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Interception)

//返回string之后字符串，不包括string
- (NSString*)backWardsSearchInterception:(NSString*)string;

//返回string之前字符串，包括string
- (NSString*)frontWardsSearchInterception:(NSString*)string;

@end
