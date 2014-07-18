//
//  PictureHelper.h
//  PudongTravel
//
//  Created by mark on 14-4-1.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PictureHelper : NSObject
+(void)addPicture:(NSString*)imagPath to:(UIImageView*)addTo /*withSize:(CGRect)withSize*/;
+(void)addPicture:(NSString*)imagPath to:(UIImageView*)addTo withSize:(CGRect)withSize;
+(void)addPictureFromFile:(NSString*)imagPath to:(UIImageView*)addTo withSize:(CGRect)withSize;

+(UIImage *)getImageOfView:(UIImageView*)imageView;
@end
