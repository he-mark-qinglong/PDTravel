//
//  UIImage+NSCoding.h
//  Carousel
//
//  Created by Simon Fan on 8/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIImageNSCoding <NSCoding>

- (id)initWithCoder:(NSCoder *)decoder;

- (void)encodeWithCoder:(NSCoder *)encoder;

@end
