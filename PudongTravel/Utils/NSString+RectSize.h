//
//  NSString+RectSize.h
//  NewProduct
//
//  Created by duwei on 13-8-12.
//  Copyright (c) 2013年 Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (RectSize)

/// 获取指定字体、最大宽度下的最佳size（普通文本）
- (CGSize)labelSizeWithWidth:(int)width font:(UIFont *)font;

@end
