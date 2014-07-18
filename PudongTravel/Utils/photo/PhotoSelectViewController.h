//
//  PhotoSelectViewController.h
//  WhereWeGo
//
//  Created by lifuyong on 14-2-18.
//  Copyright (c) 2014年 lifuyong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PhotoSelectViewControllerDelegate <NSObject>

- (void)photoSelectDisAppear;

@end

@interface PhotoSelectViewController : UIViewController

@property (assign, nonatomic) NSInteger maxImageNumber;
@property (weak, nonatomic) id<PhotoSelectViewControllerDelegate> delegate;

@end
