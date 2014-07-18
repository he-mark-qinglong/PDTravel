//
//  UIImage+loadImage.m
//  chengyunapp
//
//  Created by lifuyong on 13-11-18.
//  Copyright (c) 2013年 lifuyong. All rights reserved.
//

#import "UIImage+loadImage.h"

@implementation UIImage (loadImage)

+ (UIImage *)imageWithResourceName:(NSString *)imageName
{
    NSString *path = [[NSBundle mainBundle] pathForResource:[imageName stringByDeletingPathExtension] ofType:[imageName pathExtension]];
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:path];
    return image;
}

@end
