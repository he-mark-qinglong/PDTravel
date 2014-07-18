//
//  PTCollectionItemView.m
//  Carousel
//
//  Created by Derick Liu on 12/4/12.
//
//

#import "PTCollectionItemView.h"

@implementation PTCollectionItemView

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self singleTapped:nil];
}

- (void)singleTapped:(id)sender
{
    if ([self.ptcollectionitemdelegate respondsToSelector:@selector(collectionItemView:didSingleTapAtIndex:)]) {
        [self.ptcollectionitemdelegate collectionItemView:self didSingleTapAtIndex:_index];
    }
}

@end
