//
//  LocalCache.h
//  NetworkAndCache
//
//  Created by Woodrow Zhang on 6/30/13.
//  Copyright (c) 2012 lyz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocalCache : NSObject 
- (id)initWithCacheFolderName:(NSString *)cacheRootFolder;
+ (id) sharedCache;

- (id)cachedObjectForKey:(NSString *)key;
- (UIImage *)cachedImageForKey:(NSString*)key;
- (NSData*)cachedDataForKey:(NSString*)key;
- (NSString*)cachedStringForKey:(NSString*)key;
- (id)cachedJsonForKey:(NSString*)key;

- (BOOL)storeCacheObject:(id<NSCoding>)object forKey:(NSString *)key;
- (BOOL)storeCacheImage:(UIImage *)imageData forKey:(NSString *)key;
- (BOOL)storeCacheData:(NSData*)cacheData forKey:(NSString *)key;
- (BOOL)storeCacheString:(NSString*)stringData forKey:(NSString *)key;
- (BOOL)storeCacheJson:(id)jsonData forKey:(NSString *)key;

- (void)removeCacheDataForKey:(NSString *)key;
- (BOOL)isCacheDataExist:(NSString *)key;
- (BOOL)clearAllCacheData;
- (NSDate*)cacheModificationDateOfKey:(NSString*)key;

@end
