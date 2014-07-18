//
//  HUDHandle.h
//  PromotionDemo
//
//  Created by lifuyong on 13-8-20.
//
//

#import <Foundation/Foundation.h>

@interface HUDHandle : NSObject

// if the view is nil, the hud will add on the window.
+ (void)startLoadingWithView:(UIView *)view;
+ (void)stopLoading;

@end
