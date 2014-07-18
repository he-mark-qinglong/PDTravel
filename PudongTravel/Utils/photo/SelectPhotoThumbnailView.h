//
//  SelectPhotoThumbnailView.h
//  WhereWeGo
//
//  Created by lifuyong on 14-2-19.
//  Copyright (c) 2014年 lifuyong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SelectPhoto;

@protocol SelectPhotoThumbnailViewDelegate <NSObject>

- (void)removeSelectImageWithIndex:(NSInteger)index;

@end

@interface SelectPhotoThumbnailView : UIView

@property (weak, nonatomic) id<SelectPhotoThumbnailViewDelegate> delegate;
@property (strong, nonatomic) SelectPhoto *selectPhoto;
- (void)setImageWithSelectPhoto:(SelectPhoto *)selectPhoto;
- (void)showImage;

@end
