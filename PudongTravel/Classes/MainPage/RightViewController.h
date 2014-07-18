//
//  RightViewController.h
//  pudongapp
//
//  Created by jiangjunli on 14-1-7.
//  Copyright (c) 2014年 jiangjunli. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface RightViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
     NSArray *array ;
    
}
- (IBAction)loginBtnClick:(id)sender;

@end
