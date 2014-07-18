//
//  CameraOverlayView.m
//  WhereWeGo
//
//  Created by lifuyong on 14-2-18.
//  Copyright (c) 2014年 lifuyong. All rights reserved.
//

#import "CameraOverlayView.h"

#import "UIImage+loadImage.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "AlertViewHandle.h"
#import <QuartzCore/QuartzCore.h>
#import "PhotoSelectViewController.h"
#import "WWGImagePickerViewController.h"

//static const NSInteger kMaxImageNumber = 9;

@interface CameraOverlayView ()

@property (weak, nonatomic) IBOutlet UIButton *lightButton;
@property (weak, nonatomic) IBOutlet UIView *lightOptionView;
@property (weak, nonatomic) IBOutlet UIButton *lightAutoButton;
@property (weak, nonatomic) IBOutlet UIButton *lightOnButton;
@property (weak, nonatomic) IBOutlet UIButton *lightCloseButton;
@property (weak, nonatomic) IBOutlet UIButton *cameraFlipButton;
@property (weak, nonatomic) IBOutlet UIButton *cameraButton;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;

@property (weak, nonatomic) UIImagePickerController *imagePickerVC;

@end

@implementation CameraOverlayView

+ (id)cameraOverlayViewWithImagePicker:(WWGImagePickerViewController *)imagePickerVC
{
    CameraOverlayView *cameraOverlayView = [[[NSBundle mainBundle] loadNibNamed:@"CameraOverlayView" owner:nil options:nil] objectAtIndex:0];
    cameraOverlayView.imagePickerVC = imagePickerVC;
    [cameraOverlayView lightOptionButtonSelect:cameraOverlayView.lightAutoButton];
    [cameraOverlayView validateCameraDevice];
    [cameraOverlayView validateFlashWithDevice:UIImagePickerControllerCameraDeviceRear];
    cameraOverlayView.maxImageNumber = imagePickerVC.maxImageNumber;
    return cameraOverlayView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)dealloc{
    self.imagePickerVC.delegate = nil;
}

- (void)getLastedImage
{
    ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
    [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        
        [group setAssetsFilter:[ALAssetsFilter allPhotos]];
        NSUInteger index = [group numberOfAssets] - 1;
        
        NSIndexSet *lastPhotoIndexSet = [NSIndexSet indexSetWithIndex:index];
        
        [group enumerateAssetsAtIndexes:lastPhotoIndexSet options:0 usingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
            if (result == nil) {
                return;
            }
            self.thumbnailImageView.image = [UIImage imageWithCGImage:result.thumbnail];
        }];
        
    } failureBlock:^(NSError *error) {
        [AlertViewHandle showAlertViewWithMessage:@"请在设置中打开访问照片权限"];
    }];
}

#pragma mark - Private methods

- (void)validateCameraDevice
{
    BOOL rear = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
    BOOL front = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
    if (rear && front) {
        self.cameraFlipButton.hidden = NO;
    } else {
        self.cameraFlipButton.hidden = YES;
    }
}

- (void)validateFlashWithDevice:(UIImagePickerControllerCameraDevice)device
{
    BOOL flashAvaliabel = [UIImagePickerController isFlashAvailableForCameraDevice:device];
    if (flashAvaliabel) {
        self.lightButton.hidden = NO;
    } else {
        self.lightButton.hidden = YES;
    }
}

- (void)lightOptionButtonSelect:(UIButton *)button
{
    switch (button.tag) {
        case 0: {
            self.lightAutoButton.selected = YES;
            self.lightOnButton.selected = NO;
            self.lightCloseButton.selected = NO;
            [self.lightButton setImage:[UIImage imageWithResourceName:@"picker_light_auto@2x.png"] forState:UIControlStateNormal];
            self.imagePickerVC.cameraFlashMode = UIImagePickerControllerCameraFlashModeAuto;
            break;
        }
        case 1: {
            self.lightAutoButton.selected = NO;
            self.lightOnButton.selected = YES;
            self.lightCloseButton.selected = NO;
            [self.lightButton setImage:[UIImage imageWithResourceName:@"picker_light_on@2x.png"] forState:UIControlStateNormal];
            self.imagePickerVC.cameraFlashMode = UIImagePickerControllerCameraFlashModeOn;
            break;
        }
        case 2: {
            self.lightAutoButton.selected = NO;
            self.lightOnButton.selected = NO;
            self.lightCloseButton.selected = YES;
            [self.lightButton setImage:[UIImage imageWithResourceName:@"picker_light_close@2x.png"] forState:UIControlStateNormal];
            self.imagePickerVC.cameraFlashMode = UIImagePickerControllerCameraFlashModeOff;
            break;
        }
            
        default:
            break;
    }
    self.lightOptionView.hidden = YES;
}

- (void)takePhotoAnimation:(UIView *)view
{
    CATransition *shutterAnimation = [CATransition animation];
    shutterAnimation.delegate = self;
    shutterAnimation.duration = 0.5f;
    shutterAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    shutterAnimation.type = @"cameraIris";
    shutterAnimation.subtype = @"cameraIris";
    [view.layer addAnimation:shutterAnimation forKey:@"cameraIris"];
}

#pragma mark - Event handle

- (IBAction)lightOptionButtonClicked:(UIButton *)sender {
    [self lightOptionButtonSelect:sender];
}

- (IBAction)cameraFlipButtonClicked:(id)sender {
    self.lightOptionView.hidden = YES;
    if (self.imagePickerVC.cameraDevice == UIImagePickerControllerCameraDeviceRear) {
        self.imagePickerVC.cameraDevice = UIImagePickerControllerCameraDeviceFront;
        [self validateFlashWithDevice:UIImagePickerControllerCameraDeviceFront];
    } else {
        self.imagePickerVC.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        [self validateFlashWithDevice:UIImagePickerControllerCameraDeviceRear];
    }
}

- (IBAction)lightButtonClicked:(id)sender {
    if (self.lightOptionView.hidden == YES) {
        self.lightOptionView.hidden = NO;
    } else {
        self.lightOptionView.hidden = YES;
    }
}

- (IBAction)cameraButtonClicked:(id)sender {
        [self takePhotoAnimation:self.imagePickerVC.view];
    [self.imagePickerVC takePicture];
}

- (IBAction)closeButtonClicked:(id)sender {
    [self.imagePickerVC dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)showPhotoSelectView:(id)sender {
    if ([self.delegate respondsToSelector:@selector(showPhotoSelectViewWithMaxImageNumber:)]) {
        [self.delegate showPhotoSelectViewWithMaxImageNumber:self.maxImageNumber];
    }
}

@end
