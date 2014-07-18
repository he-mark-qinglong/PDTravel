//
//  ScrollViewLoop.h
//  ScrollViewLoop
//
//  Created by duwei Tang on 14-4-9.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved
//

#import <UIKit/UIKit.h>
@class ScrollViewLoopImageItem;
@class ScrollViewLoop;

#pragma mark - ScrollViewLoopDelegate
@protocol ScrollViewLoopDelegate <NSObject>
@optional
- (void)foucusImageFrame:(ScrollViewLoop *)imageFrame didSelectItem:(ScrollViewLoopImageItem *)item;
- (void)foucusImageFrame:(ScrollViewLoop *)imageFrame currentItem:(int)index;

@end


@interface ScrollViewLoop : UIView <UIGestureRecognizerDelegate, UIScrollViewDelegate>
{
    BOOL _isAutoPlay;
}

- (id)initWithFrame:(CGRect)frame delegate:(id<ScrollViewLoopDelegate>)delegate scrollViewLoopImageItemArray:(NSArray *)scrollViewLoopImageItemArray isAuto:(BOOL)isAuto;

- (id)initWithFrame:(CGRect)frame delegate:(id<ScrollViewLoopDelegate>)delegate imageItems:(NSArray *)items isAuto:(BOOL)isAuto;

- (id)initWithFrame:(CGRect)frame delegate:(id<ScrollViewLoopDelegate>)delegate focusImageItems:(ScrollViewLoopImageItem *)items, ... NS_REQUIRES_NIL_TERMINATION;

- (void)scrollToIndex:(int)aIndex;

- (void)hidenPageControl:(BOOL)isHiden;

@property (nonatomic, assign) id<ScrollViewLoopDelegate> delegate;

@end
