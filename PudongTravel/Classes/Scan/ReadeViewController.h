//
//  ReadeViewController.h
//  PudongTravel
//
//  Created by jiangjunli on 14-3-28.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReadeViewController : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate, ZBarReaderDelegate>
{
    int num;
    BOOL upOrdown;
    NSTimer * timer;
    
}
@property (nonatomic, strong) UIImageView * line;

@end
