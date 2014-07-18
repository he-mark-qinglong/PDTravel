//
//  ImageConfirmViewController.m
//  WhereWeGo
//
//  Created by lifuyong on 14-2-19.
//  Copyright (c) 2014年 lifuyong. All rights reserved.
//

#import "ImageConfirmViewController.h"

#import "AppDelegate.h"
#import "LocalCache.h"

@interface ImageConfirmViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ImageConfirmViewController

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
    self.imageView.image = self.image;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error
  contextInfo:(void *)contextInfo{
    NSLog(@"saved..");
}

- (IBAction)confirmButtonClicked:(id)sender {
    UIImageWriteToSavedPhotosAlbum(self.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    NSArray *imageArray = [NSArray arrayWithObjects:self.image, nil];
   [[LocalCache sharedCache] storeCacheObject:imageArray forKey:@"releaseImages"];
    
    
    NSString *mark = [[NSUserDefaults standardUserDefaults] objectForKey:@"imagePickerFrom"];
    if ([mark isEqualToString:@"release"]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"addMoreImage" object:nil];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"showReleaseView" object:nil];
    }
}

- (IBAction)cancelButtonClicked:(id)sender {
    if ([self.delegate respondsToSelector:@selector(photoSelectDisAppear)]) {
        [self.delegate photoSelectDisAppear];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
