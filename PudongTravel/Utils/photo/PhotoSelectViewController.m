//
//  PhotoSelectViewController.m
//  WhereWeGo
//
//  Created by lifuyong on 14-2-18.
//  Copyright (c) 2014年 lifuyong. All rights reserved.
//

#import "PhotoSelectViewController.h"

#import "UIImage+loadImage.h"
#import "PhotoThumbnailView.h"
#import "UIView+FrameHandle.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "AlertViewHandle.h"
#import "ImageDetailViewController.h"
#import "SelectPhotoThumbnailView.h"
#import "SelectPhoto.h"
#import "UIImage+Resize.h"
#import "AppDelegate.h"
#import "PTCollectionView.h"
#import "UIImage+NSCoding.h"
#import "LocalCache.h"
#import "UIImage+Compress.h"

@interface PhotoSelectViewController () <PhotoThumbnailViewDelegate, SelectPhotoThumbnailViewDelegate, ImageDetailViewControllerDelegate, PTCollectionViewDataSource, PTCollectionViewDelegate> {
    NSInteger _selectImageNumber;
    
}
@property (weak, nonatomic) IBOutlet UILabel *noticeLabel;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;
@property (weak, nonatomic) IBOutlet PTCollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UIScrollView *selectImageScrollView;
@property (strong, nonatomic) NSMutableArray *imageURLArray;
@property (strong, nonatomic) NSMutableArray *selectPhotoViewArray;
@property (strong, nonatomic) NSMutableArray *selectImageArray;

@end

@implementation PhotoSelectViewController

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

    self.collectionView.delegate = self;
    self.collectionView.dataSource = self; 
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
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
    self.navigationItem.title = @"选择照片";
    [self setFonts];
    [self getPhotos];
    self.noticeLabel.text = [NSString stringWithFormat:@"当前选中%i张对多选择%i张", _selectImageNumber, self.maxImageNumber];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    self.collectionView.delegate = nil;
    self.collectionView.dataSource = nil;
}

#pragma mark - Private methods

- (void)getPhotos
{
    self.imageURLArray = [[NSMutableArray alloc] init];
    ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
    [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
            NSString* assetType = [result valueForProperty:ALAssetPropertyType];
            if ([assetType isEqualToString:ALAssetTypePhoto]) {
                [self.imageURLArray addObject:result.defaultRepresentation.url.absoluteString];
                
            }
            if (index == group.numberOfAssets - 1) {
                [self.collectionView reloadData];
            }
        }];
    } failureBlock:^(NSError *error) {
        [AlertViewHandle showAlertViewWithMessage:@"请在设置中打开访问照片权限"];
    }];
}

- (void)setFonts
{
    self.noticeLabel.font = [UIFont fontWithName:@"MingHei_R" size:15];
    self.confirmButton.titleLabel.font = [UIFont fontWithName:@"MingHei_R" size:18];
}

- (void)back
{
    if ([self.delegate respondsToSelector:@selector(photoSelectDisAppear)]) {
        [self.delegate photoSelectDisAppear];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)confirmButtonClicked:(id)sender {
    
    if (self.selectImageArray.count < 1) {
        [AlertViewHandle showAlertViewWithMessage:@"请至少选择一张照片"];
        return;
    }
    
//    NSMutableArray *array = [[NSMutableArray alloc] init];
//    for (SelectPhotoThumbnailView *view in self.selectPhotoViewArray) {
//        [array addObject:view.selectPhoto.bigImage];
//    }
//    ((AppDelegate *)[UIApplication sharedApplication].delegate).imageCacheArray = array;
    [[LocalCache sharedCache] storeCacheObject:self.selectImageArray forKey:@"releaseImages"];
    
    
    
    NSString *mark = [[NSUserDefaults standardUserDefaults] objectForKey:@"imagePickerFrom"];
    if ([mark isEqualToString:@"release"]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"addMoreImage" object:nil];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"showReleaseView" object:nil];
    }
}

- (void)selectPhotolayout
{
    NSArray *subviews = self.selectImageScrollView.subviews;
    for (UIView *view in subviews) {
        [view removeFromSuperview];
    }
    CGFloat maxWidth = 0.0;
    for (int i = 0; i < self.selectPhotoViewArray.count; i++) {
        SelectPhotoThumbnailView *selectPhotoView = [self.selectPhotoViewArray objectAtIndex:i];
        selectPhotoView.originX = i * selectPhotoView.width;
        [self.selectImageScrollView addSubview:selectPhotoView];
        [selectPhotoView showImage];
        if (i == self.selectPhotoViewArray.count - 1) {
            maxWidth = selectPhotoView.originX + selectPhotoView.width;
        }
    }
    self.selectImageScrollView.contentSize = CGSizeMake(maxWidth, 75);
}

#pragma mark - PhotoThumbnailViewDelegate methods

- (BOOL)selectImageWithIndex:(NSInteger)index
{
    if (_selectImageNumber < self.maxImageNumber) {
        _selectImageNumber++;
        
        if (!self.selectPhotoViewArray) {
            self.selectPhotoViewArray = [[NSMutableArray alloc] init];
        }
        
        if (!self.selectImageArray) {
            self.selectImageArray = [[NSMutableArray alloc] init];
        }
        
        SelectPhoto *selectPhoto = [[SelectPhoto alloc] init];
        
        selectPhoto.image = ((PhotoThumbnailView *)[self.collectionView collectionItemViewAtIndex:index]).imageView.image;
        selectPhoto.index = index;
        
        ALAssetsLibrary *assetLibrary=[[ALAssetsLibrary alloc] init];
        NSURL *url=[NSURL URLWithString:[self.imageURLArray objectAtIndex:index]];
        [assetLibrary assetForURL:url resultBlock:^(ALAsset *asset)  {
            UIImage *selectImage =  [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
            selectImage = [UIImage imageWithData:UIImageJPEGRepresentation(selectImage, 0.1)];
            selectImage = [selectImage resize:CGSizeMake(500, 500) quality:kCGInterpolationLow];
            [self.selectImageArray addObject:selectImage];
        }failureBlock:^(NSError *error) {
            NSLog(@"error=%@",error);
        }];
        
        SelectPhotoThumbnailView *selectPhotoView = [[[NSBundle mainBundle] loadNibNamed:@"SelectPhotoThumbnailView" owner:nil options:nil] objectAtIndex:0];
        selectPhotoView.delegate = self;
        [selectPhotoView setImageWithSelectPhoto:selectPhoto];
        [self.selectPhotoViewArray addObject:selectPhotoView];
        [self selectPhotolayout];
        self.noticeLabel.text = [NSString stringWithFormat:@"当前选中%i张对多选择%i张", _selectImageNumber, self.maxImageNumber];
        return YES;
    } else {
        
        [AlertViewHandle showAlertViewWithMessage:@"最多可选择9张照片"];
        return NO;
    }
}

- (void)unSelectImageWithIndex:(NSInteger)index
{
    if (_selectImageNumber > 0) {
        _selectImageNumber--;
        SelectPhotoThumbnailView *selectPhotoThumbnailView;
        int i = 0;
        for (SelectPhotoThumbnailView *selectPhotoView in self.selectPhotoViewArray) {
            if (index == selectPhotoView.selectPhoto.index) {
                selectPhotoThumbnailView = selectPhotoView;
                [self.selectImageArray removeObjectAtIndex:i];
                break;
            }
            i++;
        }
        [self.selectPhotoViewArray removeObject:selectPhotoThumbnailView];
        
        [self selectPhotolayout];
        self.noticeLabel.text = [NSString stringWithFormat:@"当前选中%i张对多选择%i张", _selectImageNumber, self.maxImageNumber];
    }
}

- (void)showImageDetailWithIndex:(NSInteger)index
{
    ALAssetsLibrary *assetLibrary=[[ALAssetsLibrary alloc] init];
    NSURL *url=[NSURL URLWithString:[self.imageURLArray objectAtIndex:index]];
    [assetLibrary assetForURL:url resultBlock:^(ALAsset *asset)  {
        ImageDetailViewController *detailViewController = [[ImageDetailViewController alloc] init];
        UIImage *image = [[UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage]resize:CGSizeMake(1000, 1000) quality:kCGInterpolationMedium];
        detailViewController.image = image;
        detailViewController.index = index;
        detailViewController.detailType = Select;
        detailViewController.delegate = self;
        [self.navigationController pushViewController:detailViewController animated:YES];
        
    }failureBlock:^(NSError *error) {
        NSLog(@"error=%@",error);
    }];
    
}

#pragma mark - SelectPhotoThumbnailViewDelegate method

- (void)removeSelectImageWithIndex:(NSInteger)index
{
    PhotoThumbnailView *thumbnailView = (PhotoThumbnailView *)[self.collectionView collectionItemViewAtIndex:index];
    [thumbnailView selectOrUnselectImage];
}

#pragma mark - ImageDetailViewControllerDelegate methods

- (void)selectImageIndex:(NSInteger)index
{
    PhotoThumbnailView *thumbnailView = (PhotoThumbnailView *)[self.collectionView collectionItemViewAtIndex:index];
    [thumbnailView selectOrUnselectImage];
}


#pragma mark - PTCollectionViewDelegate PTColloectionViewDataSource

- (NSInteger)numberOfItemsPerRowInCollectionView:(PTCollectionView *)collectionView{
    return 4;
}

- (NSInteger)numberOfItemsInCollectionView:(PTCollectionView *)collectionView{
    return self.imageURLArray.count;
}

- (CGFloat)heightOfRowInCollectionView:(PTCollectionView *)collectionView{
    return 80.0;
}

- (PTCollectionItemView*)collectionView:(PTCollectionView *)collectionView itemAtIndex:(NSInteger)index
{
    PhotoThumbnailView *thumbnailView = [[[NSBundle mainBundle] loadNibNamed:@"PhotoThumbnailView" owner:nil options:nil] objectAtIndex:0];
    thumbnailView.delegate = self;
    thumbnailView.index = index;
    ALAssetsLibrary *assetLibrary=[[ALAssetsLibrary alloc] init];
    NSURL *url=[NSURL URLWithString:[self.imageURLArray objectAtIndex:index]];
    [assetLibrary assetForURL:url resultBlock:^(ALAsset *asset)  {
        thumbnailView.imageView.image = [UIImage imageWithCGImage:asset.thumbnail];
    }failureBlock:^(NSError *error) {
        NSLog(@"error=%@",error);
    }];
    
    return thumbnailView;
}


@end
