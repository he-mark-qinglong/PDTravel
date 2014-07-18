//
//  PhotoThumbnailView.m
//  WhereWeGo
//
//  Created by lifuyong on 14-2-18.
//  Copyright (c) 2014年 lifuyong. All rights reserved.
//

#import "PhotoThumbnailView.h"

@interface PhotoThumbnailView ()

@property (weak, nonatomic) IBOutlet UIButton *selectButton;

@end

@implementation PhotoThumbnailView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)selectOrUnselectImage
{
    [self selectButtonClicked:nil];
}

- (IBAction)selectButtonClicked:(id)sender {
    if (self.selectButton.selected == NO) {
        if ([self.delegate respondsToSelector:@selector(selectImageWithIndex:)]) {
            if ([self.delegate selectImageWithIndex:self.index]) {
                self.selectButton.selected = YES;
                
            }
        }
    } else {
        if ([self.delegate respondsToSelector:@selector(unSelectImageWithIndex:)]) {
            [self.delegate unSelectImageWithIndex:self.index];
        }
        self.selectButton.selected = NO;
    }
}

- (IBAction)tapGesture:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(showImageDetailWithIndex:)]) {
        [self.delegate showImageDetailWithIndex:self.index];
    }
    
}

@end
