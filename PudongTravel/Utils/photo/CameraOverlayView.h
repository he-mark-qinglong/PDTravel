//
//  CameraOverlayView.h
//  WhereWeGo
//
//  Created by lifuyong on 14-2-18.
//  Copyright (c) 2014年 lifuyong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CameraOverlayViewDelegate <NSObject>

- (void)showPhotoSelectViewWithMaxImageNumber:(NSInteger)maxImageNumber;

@end

@interface CameraOverlayView : UIView

@property (assign, nonatomic) NSInteger maxImageNumber;
@property (weak, nonatomic) id<CameraOverlayViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnailImageView;

+ (id)cameraOverlayViewWithImagePicker:(UIImagePickerController *)imagePickerVC;
- (void)getLastedImage;


@end
