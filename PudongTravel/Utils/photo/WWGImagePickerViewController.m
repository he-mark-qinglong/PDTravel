//
//  WWGImagePickerViewController.m
//  WhereWeGo
//
//  Created by lifuyong on 14-2-18.
//  Copyright (c) 2014年 lifuyong. All rights reserved.
//

#import "WWGImagePickerViewController.h"

#import "CameraOverlayView.h"
#import "UIView+FrameHandle.h"
#import "PhotoSelectViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "ImageConfirmViewController.h"
#import "UIImage+Resize.h"

@interface WWGImagePickerViewController () <CameraOverlayViewDelegate, PhotoSelectViewControllerDelegate, ImageConfirmViewControllerDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation WWGImagePickerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.delegate = self;
    if (!IOS7) {
        UIApplication *app = [UIApplication sharedApplication];
        [app setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    }
    
    CameraOverlayView *cameraOverlayView = [CameraOverlayView cameraOverlayViewWithImagePicker:self];
    cameraOverlayView.delegate = self;
    self.customOverlayView = cameraOverlayView;
    if (IS_IPHONE5 && IOS7) {
        NSArray *subviews = self.view.subviews;
        for (UIView *view in subviews) {
            view.originY = 50;
        }
        [self.view addSubview:cameraOverlayView];
    } else {
        cameraOverlayView.height -= 88;
        self.cameraOverlayView = cameraOverlayView;
    }
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.customOverlayView getLastedImage];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

#pragma mark - CameraOverlayDelegate methods

- (void)showPhotoSelectViewWithMaxImageNumber:(NSInteger)maxImageNumber
{
    PhotoSelectViewController *photoSelectViewController = [[PhotoSelectViewController alloc] init];
    photoSelectViewController.maxImageNumber = maxImageNumber;
    photoSelectViewController.delegate = self;
    
    if (IS_IPHONE5 && IOS7) {
        NSArray *subviews = self.view.subviews;
        for (UIView *view in subviews) {
            if ([view isKindOfClass:[CameraOverlayView class]]) {
                view.hidden = YES;
            }
            view.originY = 0;
        }
    }
    [self pushViewController:photoSelectViewController animated:YES];
}

#pragma mark - PhotoSelectViewControllerDelegate method

- (void)photoSelectDisAppear
{
    if (IS_IPHONE5 && IOS7) {
        NSArray *subviews = self.view.subviews;
        for (UIView *view in subviews) {
            if ([view isKindOfClass:[CameraOverlayView class]]) {
                view.hidden = NO;
                view.originY = 0;
            } else {
                view.originY = 50;
            }
            
        }
    }
}

#pragma mark - UIImagePickerControllerDelegate methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString* type = [info objectForKey:UIImagePickerControllerMediaType];
    if (picker.sourceType==UIImagePickerControllerSourceTypeCamera &&[type isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage *orignaImage = [info objectForKey:UIImagePickerControllerOriginalImage];
//        CGSize orignalSize = orignaImage.size;
        
        CGSize newSize = CGSizeMake(500,500);
        
        UIImage *newImage = [orignaImage resize:newSize quality:kCGInterpolationLow];
        ImageConfirmViewController *imageConfirmVC = [[ImageConfirmViewController alloc] init];
        imageConfirmVC.image = newImage;
        imageConfirmVC.delegate = self;
        
        [self pushViewController:imageConfirmVC animated:YES];
        if (IS_IPHONE5 && IOS7) {
            NSArray *subviews = self.view.subviews;
            for (UIView *view in subviews) {
                if ([view isKindOfClass:[CameraOverlayView class]]) {
                    view.hidden = YES;
                }
                view.originY = 0;
            }
        }
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
}

@end
