//
//  HTTPAPIConnection.m
//  PudongTravel
//
//  Created by mark on 14-3-25.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "HTTPAPIConnection.h"
#import "HTTPClient.h"
#import "HUDHandle.h"
#import "AlertViewHandle.h"
#import "ConstLinks.h"
@implementation HTTPAPIConnection

#pragma mark - Private methods

+(void)postPathToGetJson:(NSString*)path block:(void(^)(NSDictionary *, NSError *))block{
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self postConnection:nil path:path block:block];
}

+ (void)postConnection:(NSDictionary *)parameters path:(const NSString *)path block:(void(^)(NSDictionary *, NSError *))block
{
    NSString *postPath = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[HTTPClient sharedClient] postPath:postPath
                             parameters:parameters
                                success:^(AFHTTPRequestOperation *operation, id JSON) {
                                    if (block) {
                                        block(JSON, nil);
                                    }
                                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                    if (block) {
                                        block(nil, error);
                                    }
#if DEBUG
//                                    NSString *errorStr = [postPath stringByAppendingString:@"网络连接失败"];
//                                    [AlertViewHandle showAlertViewWithMessage:errorStr];
#else
                                    //[AlertViewHandle showAlertViewWithMessage:@"网络连接失败"];
#endif
                                    [HUDHandle stopLoading];
                                }];
}

+ (void)postConnection:(NSDictionary *)parameters block:(void(^)(NSDictionary *, NSError *))block
{
    [[HTTPClient sharedClient] postPath:nil
                             parameters:parameters
                                success:^(AFHTTPRequestOperation *operation, id JSON) {
                                    if (block) {
                                        block(JSON, nil);
                                    }
                                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                    if (block) {
                                        block(nil, error);
                                    }
                                    [AlertViewHandle showAlertViewWithMessage:@"连接失败"];
                                    [HUDHandle stopLoading];
                                }];
}

+ (void)postPicWithPath:(NSString *)path
                        arrayImage:(NSArray *)arrayImage
                             block:(void (^)(NSDictionary *, NSError *))block{
    
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURLRequest* request =
    [[HTTPClient sharedClient] multipartFormRequestWithMethod:@"POST"
                                                         path:path
                                                   parameters:nil
                                    constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     {
         if([arrayImage count] == 0){
             [formData appendPartWithFileData:[NSData new]
                                         name:@"files"
                                     fileName:@"nofile"  //[NSString stringWithFormat:@"image%d.png", i++]
                                     mimeType:@"empty"];
         }
         for(UIImage *image in arrayImage){
             [formData appendPartWithFileData:UIImagePNGRepresentation(image) 
                                         name:@"files"
                                     fileName:@"xxx.png"  //[NSString stringWithFormat:@"image%d.png", i++]
                                     mimeType:@"png"];
         }
     }];
    
    AFHTTPRequestOperation *operation
    = [[HTTPClient sharedClient] HTTPRequestOperationWithRequest:request
                                                         success:
       ^(AFHTTPRequestOperation *operation, id responseObject){
         if (block) {
             block(responseObject, nil);
         }
     }
                                                         failure:
       ^(AFHTTPRequestOperation *operation, NSError *error){
         if (block) {
             block(nil, error);
         }
     }];
    [[HTTPClient sharedClient] enqueueHTTPRequestOperation:operation];
}


+ (void)personalSettingPicWithUserId:(NSString *)path image:(UIImage *)image block:(void (^)(NSDictionary *, NSError *))block{
  
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURLRequest* request =
    [[HTTPClient sharedClient] multipartFormRequestWithMethod:@"POST"
                                                         path:path
                                                   parameters:nil
                                    constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     {
         
    
             [formData appendPartWithFileData:UIImagePNGRepresentation(image)
                                         name:@"file"
                                     fileName:@"xxx.png"  //[NSString stringWithFormat:@"image%d.png", i++]
                                     mimeType:@"png"];
         
     }];
    
    AFHTTPRequestOperation *operation
    = [[HTTPClient sharedClient] HTTPRequestOperationWithRequest:request
                                                         success:
       ^(AFHTTPRequestOperation *operation, id responseObject){
           if (block) {
               block(responseObject, nil);
           }
       }
                                                         failure:
       ^(AFHTTPRequestOperation *operation, NSError *error){
           if (block) {
               block(nil, error);
           }
       }];
    [[HTTPClient sharedClient] enqueueHTTPRequestOperation:operation];

}

+ (void)postRegiterWithPath:(NSString *)path block:(void (^)(NSDictionary *, NSError *))block
{
    NSURLRequest* request =
    [[HTTPClient sharedClient] multipartFormRequestWithMethod:@"POST"
                                                         path:path
                                                   parameters:nil
                                    constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     {
         
         [formData appendPartWithFileData:[NSData new]
                                     name:@"files"
                                 fileName:@"nofile"  //[NSString stringWithFormat:@"image%d.png", i++]
                                 mimeType:@"empty"];
         
     }];
    
    AFHTTPRequestOperation *operation
    = [[HTTPClient sharedClient] HTTPRequestOperationWithRequest:request
                                                         success:
       ^(AFHTTPRequestOperation *operation, id responseObject){
           if (block) {
               block(responseObject, nil);
           }
       }
                                                         failure:
       ^(AFHTTPRequestOperation *operation, NSError *error){
           if (block) {
               block(nil, error);
           }
       }];
    [[HTTPClient sharedClient] enqueueHTTPRequestOperation:operation];
}
@end
