//
//  NSString+RectSize.m
//  NewProduct
//
//  Created by duwei on 13-8-12.
//  Copyright (c) 2013年 Lee. All rights reserved.
//

#import "NSString+RectSize.h"

@implementation NSString (RectSize)

// 计算显示文字需要的矩形尺寸
- (CGSize)labelSizeWithWidth:(int)width font:(UIFont *)font
{
    CGSize maxSize = CGSizeMake(width, 9999);
    CGSize expectedSize =CGSizeZero;
    
    if (IOS7)
    {
        NSDictionary *fontDict = @{NSFontAttributeName:font};
        expectedSize = [self boundingRectWithSize:maxSize
                                          options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                       attributes:fontDict
                                          context:nil].size;
        expectedSize.height *= 1.035;
    }
    else
    {
        expectedSize = [self sizeWithFont:font
                        constrainedToSize:maxSize
                            lineBreakMode:NSLineBreakByWordWrapping];
    }
    return expectedSize;
}

@end
