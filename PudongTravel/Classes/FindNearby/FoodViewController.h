//
//  FoodViewController.h
//  pudongapp
//
//  Created by jiangjunli on 14-2-14.
//  Copyright (c) 2014年 jiangjunli. All rights reserved.
//

#import <UIKit/UIKit.h>
enum VCType{
    LvXingSheVC = 6,
    FoodVC = 5,
    ZhuSuVC = 4,
    ShoppingVC = 3,
    YuLeVC = 2,
    JingQuVC = 1,
    CarPark = 7,
};

@interface FoodViewController : UIViewController
@property enum VCType _vcType;
    
@property NSString *titleName;
@end
