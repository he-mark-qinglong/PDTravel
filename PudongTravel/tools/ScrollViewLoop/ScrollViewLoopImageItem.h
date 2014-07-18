//
//  ScrollViewLoopImageItem.h
//  ScrollViewLoop
//
//  Created by duwei Tang on 14-4-9.
//  Copyright (c) 2013年 Vincent Tang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScrollViewLoopImageItem : NSObject<NSCopying>

@property (nonatomic, retain)  NSString     *title;
@property (nonatomic, retain)  NSString     *image;
@property (nonatomic, assign)  NSInteger     tag;
@property (nonatomic, retain)  NSString     *imgUrl;

- (id)initWithTitle:(NSString *)title image:(NSString *)image tag:(NSInteger)tag imgUrl:(NSString*)imgUrl;
- (id)initWithDict:(NSDictionary *)dict tag:(NSInteger)tag;
@end
