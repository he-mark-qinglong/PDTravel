//
//  HTTPAPIConnection.h
//  PudongTravel
//
//  Created by mark on 14-3-25.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "AFHTTPClient.h"

@interface HTTPAPIConnection : AFHTTPClient

+(void)postPathToGetJson:(NSString*)path block:(void(^)(NSDictionary *, NSError *))block;



+ (void)postConnection:(NSDictionary *)parameters path:(const NSString *)path block:(void(^)(NSDictionary *, NSError *))block;
+ (void)postConnection:(NSDictionary *)parameters block:(void(^)(NSDictionary *, NSError *))block;

+ (void)postPicWithPath:(NSString *)path
             arrayImage:(NSArray *)arrayImage
                 block:(void (^)(NSDictionary *, NSError *))block;

+ (void)personalSettingPicWithUserId:(NSString *)path image:(UIImage *)image block:(void (^)(NSDictionary *, NSError *))block;
+ (void)postRegiterWithPath:(NSString *)path block:(void (^)(NSDictionary *, NSError *))block;

@end
