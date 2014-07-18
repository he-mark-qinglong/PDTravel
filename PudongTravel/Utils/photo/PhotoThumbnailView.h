//
//  PhotoThumbnailView.h
//  WhereWeGo
//
//  Created by lifuyong on 14-2-18.
//  Copyright (c) 2014年 lifuyong. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PTCollectionItemView.h"

@protocol PhotoThumbnailViewDelegate <NSObject>

- (BOOL)selectImageWithIndex:(NSInteger)index;
- (void)unSelectImageWithIndex:(NSInteger)index;
- (void)showImageDetailWithIndex:(NSInteger)index;

@end

@interface PhotoThumbnailView : PTCollectionItemView

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) id<PhotoThumbnailViewDelegate> delegate;
@property (assign, nonatomic) NSInteger index;

- (void)selectOrUnselectImage;

@end
