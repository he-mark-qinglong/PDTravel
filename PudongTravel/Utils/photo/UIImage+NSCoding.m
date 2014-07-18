//
//  UIImage+NSCoding.m
//  Carousel
//
//  Created by Simon Fan on 8/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UIImage+NSCoding.h"

#define kEncodingKey @"UIImage"

@implementation UIImage(NSCoding)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"

- (id)initWithCoder:(NSCoder *)decoder
{
    if ((self = [super init]))
    {
        NSData *data = [decoder decodeObjectForKey:kEncodingKey];
        self = [self initWithData:data];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    NSData *data = UIImagePNGRepresentation(self);
    [encoder encodeObject:data forKey:kEncodingKey];
}

//#pragma clang diagnostic pop

@end