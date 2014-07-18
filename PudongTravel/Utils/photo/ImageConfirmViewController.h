//
//  ImageConfirmViewController.h
//  WhereWeGo
//
//  Created by lifuyong on 14-2-19.
//  Copyright (c) 2014年 lifuyong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ImageConfirmViewControllerDelegate <NSObject>

- (void)photoSelectDisAppear;

@end

@interface ImageConfirmViewController : UIViewController

@property (weak, nonatomic) id<ImageConfirmViewControllerDelegate> delegate;
@property (strong, nonatomic) UIImage *image;

@end
