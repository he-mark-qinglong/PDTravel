//
//  UIImage+Resize.h
//  PhotoTribe
//
//  Created by Derick Liu on 7/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ALAsset;
@interface UIImage (Resize)

- (UIImage *)resize:(CGSize)newSize;
- (UIImage *)resize:(CGSize)newSize quality:(CGInterpolationQuality)quality;
- (UIImage *)thumbnailImageMaxPixelSize:(CGFloat)size;
//+ (UIImage *)thumbnailImageMaxPixelSize:(CGFloat)size forAsset:(ALAsset *)myasset;
+ (UIImage *)thumbnailImageMaxPixelSize:(CGFloat)size forImageData:(NSData *)imageData;
-(UIImage *)cropImageToSquar;
- (UIImage *)cropImageWithRect:(CGRect)rect;

- (UIImage *)resizeImageToSize:(CGSize)targetSize;

+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;
@end
