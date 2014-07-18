//
//  PTCollectionView.m
//  Carousel
//
//  Created by Derick Liu on 12/4/12.
//
//

#import "PTCollectionView.h"
#import "PTCollectionItemView.h"

@interface PTCollectionView()<UITableViewDataSource, UITableViewDelegate, PTCollectionItemViewDelegate>

@property(strong, nonatomic)UITableView *tableView;

@end

@implementation PTCollectionView

-(void)dealloc
{
    _tableView.dataSource = nil;
    _tableView.delegate = nil;
    _tableView = nil;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.frame.size.width, self.frame.size.height)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.backgroundColor = [UIColor blackColor];
    _tableView.backgroundColor = [UIColor blackColor];
    _tableView.showsVerticalScrollIndicator = NO;
    [self addSubview:_tableView];
}

- (void)scrollToTop
{
    [self.tableView setContentOffset:CGPointZero animated:YES];
}

- (PTCollectionItemView *)collectionItemViewAtIndex:(NSInteger)index
{
    NSInteger currentRow = index / [self.dataSource numberOfItemsPerRowInCollectionView:self];
    
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:currentRow inSection:0]];
    if (cell) {
        for (id subView in cell.contentView.subviews) {
            if ([subView isKindOfClass:[PTCollectionItemView class]]) {
                PTCollectionItemView *collectionItemView = (PTCollectionItemView *)subView;
                if (collectionItemView.index == index) {
                    return collectionItemView;
                }
            }
        }
    }
    return nil;
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger itemsCount = [self.dataSource numberOfItemsInCollectionView:self];
    NSInteger itemsCountPerRow = [self.dataSource numberOfItemsPerRowInCollectionView:self];
    return (itemsCount + itemsCountPerRow - 1) / itemsCountPerRow;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    for (id each in cell.contentView.subviews) {
        [each removeFromSuperview];
    }
    NSInteger itemsCountPerRow = [self.dataSource numberOfItemsPerRowInCollectionView:self];
    NSInteger itemsCount = [self.dataSource numberOfItemsInCollectionView:self];
    NSInteger currentItemIndex = indexPath.row * itemsCountPerRow;
    CGRect tableViewFrame = self.tableView.frame;
    CGFloat heightOfRow = [self.dataSource heightOfRowInCollectionView:self];
    
    for (id each in cell.contentView.subviews) {
        [each removeFromSuperview];
    }
    
    for (; currentItemIndex < itemsCount && currentItemIndex < (indexPath.row + 1) * itemsCountPerRow; currentItemIndex++)
    {
        PTCollectionItemView *itemView =
        (PTCollectionItemView *)[self.dataSource collectionView:self itemAtIndex:currentItemIndex];
        itemView.ptcollectionitemdelegate =self;
        itemView.frame = CGRectMake((currentItemIndex % itemsCountPerRow) * (tableViewFrame.size.width / itemsCountPerRow),
                                    0.0,
                                    tableViewFrame.size.width / itemsCountPerRow,
                                    heightOfRow);
        [cell.contentView addSubview:itemView];
    }
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.dataSource heightOfRowInCollectionView:self];
}

- (void)reloadData
{
    [self.tableView reloadData];
}

#pragma mark-- PTCollectionItemViewDelegate

-(void)collectionItemView:(PTCollectionItemView *)collectionItemView didSingleTapAtIndex:(NSInteger)index
{
    if ([self.delegate respondsToSelector:@selector(collectionView:didSingleTapItemAtIndex:)]) {
        [self.delegate collectionView:self didSingleTapItemAtIndex:index];
    }
}

@end
