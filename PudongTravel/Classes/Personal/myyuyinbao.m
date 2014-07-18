//
//  myyuyinbao.m
//  pudongapp
//
//  Created by jiangjunli on 14-3-3.
//  Copyright (c) 2014年 jiangjunli. All rights reserved.
//

#import "myyuyinbao.h"
#import "myyuyinbaoCell.h"
@implementation myyuyinbao

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)awakeFromNib
{
    self.tabelview.delegate = self;
    self.tabelview.dataSource = self;
    self.tabelview.backgroundColor = [UIColor clearColor];
    [self.tabelview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
}
- (void)dealloc
{
    self.tabelview.delegate = nil;
    self.tabelview.dataSource = self;
}
- (IBAction)backbtnclidk:(id)sender {
    [self.self removeFromSuperview];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 80;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"myyuyinbaoCell";
    //自定义cell类
    myyuyinbaoCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        //通过xib的名称加载自定义的cell
        cell = [[[NSBundle mainBundle] loadNibNamed:@"myyuyinbaoCell" owner:self options:nil] lastObject];
    }
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame] ;
    cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    //cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

@end
