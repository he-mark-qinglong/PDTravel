//
//  PTCollectionItemView.h
//  Carousel
//
//  Created by Derick Liu on 12/4/12.
//
//

#import <UIKit/UIKit.h>

@interface PTCollectionItemView : UIView

@property(assign, nonatomic)NSInteger index;

@property(weak, nonatomic)id ptcollectionitemdelegate;

- (void)singleTapped:(id)sender;

@end

@protocol PTCollectionItemViewDelegate <NSObject>
@optional
- (void)collectionItemView:(PTCollectionItemView *)collectionItemView didSingleTapAtIndex:(NSInteger)index;

@end