//
//  SetingCell.m
//  PudongTravel
//
//  Created by jiangjunli on 14-4-18.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "SetingCell.h"
@interface SetingCell()

@property (weak, nonatomic) IBOutlet UILabel *name;

@end
@implementation SetingCell


+(id)cellAtIndex:(NSInteger)index;
{
    static NSArray *names = nil;
    if(names == nil)
        names = [[NSArray alloc] initWithObjects:@"官方微信", @"官方微博"
                 , @"检查版本更新", nil];
    SetingCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"SetingCell" owner:nil options:nil] objectAtIndex:0];;
    if(index > 2)
        return nil;
    cell.name.text = [names objectAtIndex:index];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
@end
