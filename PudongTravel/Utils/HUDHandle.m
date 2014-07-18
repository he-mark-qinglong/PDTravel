//
//  HUDHandle.m
//  PromotionDemo
//
//  Created by lifuyong on 13-8-20.
//
//

#import "HUDHandle.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"

static HUDHandle *kHudHandle;

@interface HUDHandle ()<MBProgressHUDDelegate>

@property (nonatomic, strong) MBProgressHUD *hud;
@property (nonatomic, strong) UIView *superView;

@end

@implementation HUDHandle

+ (void)startLoadingWithView:(UIView *)view
{
    if (!kHudHandle) {
        kHudHandle = [[HUDHandle alloc] init];
    }
    if (!view) {
        view = [(AppDelegate *)[UIApplication sharedApplication].delegate window];
    }
    kHudHandle.hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    kHudHandle.hud.delegate = kHudHandle;
}

+ (void)stopLoading
{
    [kHudHandle.hud hide:YES];
}

- (void)hudWasHidden:(MBProgressHUD *)hud
{
    [hud removeFromSuperViewOnHide];
}

@end
