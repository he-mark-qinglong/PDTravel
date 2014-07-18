//
//  SelectPhotoThumbnailView.m
//  WhereWeGo
//
//  Created by lifuyong on 14-2-19.
//  Copyright (c) 2014年 lifuyong. All rights reserved.
//

#import "SelectPhotoThumbnailView.h"

#import "SelectPhoto.h"

@interface SelectPhotoThumbnailView ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation SelectPhotoThumbnailView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setImageWithSelectPhoto:(SelectPhoto *)selectPhoto
{
    self.selectPhoto = selectPhoto;
}

- (void)showImage
{
    self.imageView.image = self.selectPhoto.image;
}

- (IBAction)unSelectImage:(id)sender {
    if ([self.delegate respondsToSelector:@selector(removeSelectImageWithIndex:)]) {
        [self.delegate removeSelectImageWithIndex:self.selectPhoto.index];
    }
}


@end
