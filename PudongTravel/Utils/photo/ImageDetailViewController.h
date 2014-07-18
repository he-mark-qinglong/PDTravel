//
//  ImageDetailViewController.h
//  WhereWeGo
//
//  Created by lifuyong on 14-2-19.
//  Copyright (c) 2014年 lifuyong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    Select,
    Release
} DetailType;

@protocol ImageDetailViewControllerDelegate <NSObject>

@optional
- (void)selectImageIndex:(NSInteger)index;
- (void)deleteImageIndex:(NSInteger)index;

@end

@interface ImageDetailViewController : UIViewController

@property (weak, nonatomic) id<ImageDetailViewControllerDelegate> delegate;
@property (assign, nonatomic) DetailType detailType;

@property (strong, nonatomic) UIImage *image;
@property (assign, nonatomic) NSInteger index;

@end
