//
//  HTTPClient.h
//  PromotionDemo
//
//  Created by lifuyong on 13-8-8.
//
//

#import "AFHTTPClient.h"

@interface HTTPClient : AFHTTPClient

+ (HTTPClient *)sharedClient;

@end
