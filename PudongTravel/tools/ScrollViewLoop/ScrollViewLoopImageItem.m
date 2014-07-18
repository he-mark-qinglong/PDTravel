//
//  ScrollViewLoopImageItem.m
//  ScrollViewLoop
//
//  Created by duwei Tang on 14-4-9.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved
//

#import "ScrollViewLoopImageItem.h"

@implementation ScrollViewLoopImageItem
@synthesize title = _title;
@synthesize image = _image;
@synthesize tag = _tag;
@synthesize imgUrl = _imgUrl;

- (id)copyWithZone:(NSZone *)zone
{
    ScrollViewLoopImageItem *loopItem = [[ScrollViewLoopImageItem alloc]init];
    
    loopItem.title = self.title;
    loopItem.image = self.image;
    loopItem.tag = self.tag;
    loopItem.imgUrl = self.imgUrl;
    
    return loopItem;
}

- (void)dealloc
{
    self.title = nil;
    self.image = nil;
    self.imgUrl = nil;
}
- (id)initWithTitle:(NSString *)title image:(NSString *)image tag:(NSInteger)tag imgUrl:(NSString*)imgUrl
{
    self = [super init];
    if (self) {
        self.title = title;
        self.image = image;
        self.tag = tag;
        self.imgUrl = imgUrl;
    }
    
    return self;
}

- (id)initWithDict:(NSDictionary *)dict tag:(NSInteger)tag{
    self = [super init];
    if (self){
        if ([dict isKindOfClass:[NSDictionary class]]){
            self.title = dict[@"title"];
            self.image = dict[@"image"];
            self.imgUrl = dict[@"imgUrl"];
            self.tag = tag;
        }
    }
    return self;
}
@end
