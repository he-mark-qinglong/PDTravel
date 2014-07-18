//
//  PictureHelper.m
//  PudongTravel
//
//  Created by mark on 14-4-1.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "PictureHelper.h"
#import "UIImageView+AFNetworking.h"

@implementation PictureHelper
//这个函数的内部API已经做了图片的缓存，不需要再额外缓存图片
+(void)addPicture:(NSString*)imageUrlPath to:(UIImageView*)addTo /*withSize:(CGRect)withSize*/{
    UIImageView *imageView = [[UIImageView alloc] init];
    
    NSURL *activityImageURL = [NSURL URLWithString:imageUrlPath];
    [imageView setImageWithURL:activityImageURL placeholderImage:nil];
    [imageView setContentMode:UIViewContentModeScaleToFill];
    imageView.frame = addTo.frame;
    
    [addTo addSubview:imageView];
}

+(void)addPicture:(NSString*)imageUrlPath to:(UIImageView*)addTo withSize:(CGRect)withSize{
    UIImageView *imageView = [[UIImageView alloc] init];
    
    NSURL *activityImageURL = [NSURL URLWithString:imageUrlPath];
    
    [imageView setImageWithURL:activityImageURL placeholderImage:nil];
    [imageView setContentMode:UIViewContentModeScaleToFill];
    imageView.frame = withSize;
    
    [addTo addSubview:imageView];
}

+(void)addPictureFromFile:(NSString*)filePath to:(UIImageView*)addTo withSize:(CGRect)withSize{
    UIImage *img = [[UIImage alloc] initWithContentsOfFile:filePath];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:img];
    imageView.frame = withSize;
    [addTo addSubview:imageView];
}

+(UIImage *)getImageOfView:(UIImageView*)imageView{
    for(UIView *view in imageView.subviews){
        if([view isKindOfClass:[UIImageView class]]){
            return ((UIImageView*)view).image;
        }
    }
    return nil;
}
@end
