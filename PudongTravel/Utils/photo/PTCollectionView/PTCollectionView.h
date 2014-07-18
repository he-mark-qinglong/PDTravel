//
//  PTCollectionView.h
//  Carousel
//
//  Created by Derick Liu on 12/4/12.
//
//

#import <UIKit/UIKit.h>

@class PTCollectionItemView;

@interface PTCollectionView : UIView

@property(weak, nonatomic)id dataSource;
@property(weak, nonatomic)id delegate;

- (void)reloadData;
- (void)scrollToTop;

- (PTCollectionItemView *)collectionItemViewAtIndex:(NSInteger)index;
@end

@protocol PTCollectionViewDataSource <NSObject>

@required
- (NSInteger)numberOfItemsInCollectionView:(PTCollectionView *)collectionView;

@optional
- (PTCollectionItemView *)collectionView:(PTCollectionView *)collectionView itemAtIndex:(NSInteger)index;
- (NSInteger)numberOfItemsPerRowInCollectionView:(PTCollectionView *)collectionView;
- (CGFloat)heightOfRowInCollectionView:(PTCollectionView *)collectionView;

@end

@protocol PTCollectionViewDelegate <UIScrollViewDelegate>

@optional
- (void)collectionView:(PTCollectionView *)collectionView didSingleTapItemAtIndex:(NSInteger)index;

@end
