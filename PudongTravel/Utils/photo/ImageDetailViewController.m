//
//  ImageDetailViewController.m
//  WhereWeGo
//
//  Created by lifuyong on 14-2-19.
//  Copyright (c) 2014年 lifuyong. All rights reserved.
//

#import "ImageDetailViewController.h"

#import "UIImage+loadImage.h"

@interface ImageDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *ImageView;

@end

@implementation ImageDetailViewController

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
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.ImageView.image = self.image;
    button.frame = CGRectMake(0, 0, 25, 25);
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageWithResourceName:@"back@2x.png"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageWithResourceName:@"back_highlight@2x.png"] forState:UIControlStateHighlighted];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    if(IOS7) {
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
        negativeSpacer.width = -10;
        self.navigationItem.leftBarButtonItems = @[negativeSpacer, backButton];
    } else {
        self.navigationItem.leftBarButtonItem = backButton;
    }
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 25, 25);
    switch (self.detailType) {
        case Select:{
            [rightButton addTarget:self action:@selector(selectImage) forControlEvents:UIControlEventTouchUpInside];
            [rightButton setImage:[UIImage imageWithResourceName:@"select_confirm@2x.png"] forState:UIControlStateNormal];
            [rightButton setImage:[UIImage imageWithResourceName:@"select_confirm_highlight@2x.png"] forState:UIControlStateHighlighted];
            break;
        }
        case Release:{
            [rightButton addTarget:self action:@selector(deleteImage) forControlEvents:UIControlEventTouchUpInside];
            [rightButton setImage:[UIImage imageWithResourceName:@"release_delete@2x.png"] forState:UIControlStateNormal];
            [rightButton setImage:[UIImage imageWithResourceName:@"release_delete_highlight@2x.png"] forState:UIControlStateHighlighted];
            break;
        }
        default:
            break;
    }
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    if (IOS7) {
        self.extendedLayoutIncludesOpaqueBars = YES;
    } else {
        self.wantsFullScreenLayout = YES;
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (BOOL)prefersStatusBarHidden
//{
//    return YES;
//}

#pragma mark - Private methods

- (void)deleteImage
{
    if ([self.delegate respondsToSelector:@selector(deleteImageIndex:)]) {
        [self.delegate deleteImageIndex:self.index];
        [self back];
    }
}

- (void)selectImage
{
    if ([self.delegate respondsToSelector:@selector(selectImageIndex:)]) {
        [self.delegate selectImageIndex:self.index];
        [self back];
    }
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)tapImage:(id)sender {
    if (self.navigationController.navigationBarHidden == NO) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    } else {
        [self.navigationController setNavigationBarHidden:NO animated:NO];
    }
    
    
}


@end
