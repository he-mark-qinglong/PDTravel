//
//  WWGImagePickerViewController.h
//  WhereWeGo
//
//  Created by lifuyong on 14-2-18.
//  Copyright (c) 2014年 lifuyong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CameraOverlayView;

@interface WWGImagePickerViewController : UIImagePickerController

@property (strong, nonatomic) CameraOverlayView *customOverlayView;
@property (assign, nonatomic) NSInteger maxImageNumber;

@end
