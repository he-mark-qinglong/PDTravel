//
//  LocalCache.m
//  NetworkAndCache
//
//  Created by Woodrow Zhang on 6/30/13.
//  Copyright (c) 2012 lyz. All rights reserved.
//

#import "LocalCache.h"
#import <CommonCrypto/CommonDigest.h>

@interface  LocalCache() 
- (id)initWithCacheFolderName:(NSString *)cacheFolderName;
- (NSString*)md5HashForKey:(NSString*)key;
- (NSString*)cachedFilePathForMD5HashKey:(NSString*)md5Key;
- (void)setupCacheDirectory;

@property (strong, nonatomic) NSString *cacheRootDirectory;
@property (strong, nonatomic) NSString *cacheRootFolderName;
@end

@implementation LocalCache

@synthesize cacheRootDirectory = _cacheRootDirectory;

+ (id)sharedCache
{
    static id instance = nil;
    if (instance == nil) {
        instance = [[self alloc]init];
    }
    return instance;
}

- (id)initWithCacheFolderName:(NSString *)cacheRootFolder
{
    self = [super init];
	if(self) {
        self.cacheRootFolderName = cacheRootFolder;
        [self setupCacheDirectory];
    }
    return self;
}

- (id) init
{
	self = [super init];
	if(self) {
        self.cacheRootFolderName = @"Cache";
        [self setupCacheDirectory];
    }
    return self;
}

#pragma mark cache file path methods.

- (NSString*)cachedFilePathForKey:(NSString *)key
{
    if(key == nil || 0 == key.length) return nil;
    NSString *md5HashValue = [self md5HashForKey:key];
    return [self cachedFilePathForMD5HashKey:md5HashValue];
}

#pragma mark fetch cache methods.
- (id)cachedObjectForKey:(NSString *)key
{
    NSData *cacheData = [self cachedDataForKey:key];
    if (cacheData) {
        return [NSKeyedUnarchiver unarchiveObjectWithData:cacheData];
    }
    return nil;
}

- (UIImage *)cachedImageForKey:(NSString*)key
{
    NSData *cacheData = [self cachedDataForKey:key];
    if (cacheData) {
        return [UIImage imageWithData:cacheData];
    }
    return nil;
}

- (NSData*)cachedDataForKey: (NSString*)key
{
    NSString *filePath = [self cachedFilePathForKey:key];
    if (filePath != nil) {
        if ([[NSFileManager defaultManager]fileExistsAtPath:filePath]) {
            return [NSData dataWithContentsOfFile:filePath];
        }
    }
    return nil;
}

- (NSString*)cachedStringForKey:(NSString*)key
{
    NSData *cacheData = [self cachedDataForKey:key];
    if (cacheData) {
        return [[NSString alloc]initWithData:cacheData encoding:NSUTF8StringEncoding];
    }
    return nil;
}

- (id)cachedJsonForKey:(NSString*)key
{
    NSError *error;
    NSString *cachedStr = [self cachedStringForKey:key];
    if (cachedStr) {
        return [NSJSONSerialization JSONObjectWithData:[cachedStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
    }
    return nil;
}

#pragma mark -

#pragma mark store cache methods.
- (BOOL)storeCacheObject:(id<NSCoding>)object forKey:(NSString *)key
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:object];
    return [self storeCacheData:data forKey:key];
}

- (BOOL)storeCacheImage:(UIImage *)imageData forKey:(NSString *)key
{
    NSData *data = UIImageJPEGRepresentation(imageData, 1);
    return [self storeCacheData:data forKey:key];
}

- (BOOL)storeCacheData:(NSData*)cacheData forKey:(NSString *)key
{
    BOOL rt = NO;
    if ([cacheData length] > 0 && [key length] > 0)
    {
        NSString *filePath = [self cachedFilePathForKey:key];
        if (filePath) {
            rt = [cacheData writeToFile:filePath options:NSDataWritingAtomic error:nil];
        }
    }    
    return rt;
}

- (BOOL)storeCacheString:(NSString*)stringData forKey:(NSString *)key
{
    NSData *data = [stringData dataUsingEncoding:NSUTF8StringEncoding];
    return [self storeCacheData:data forKey:key];
}

- (BOOL)storeCacheJson:(id)jsonData forKey:(NSString *)key
{
    NSError *error;
    NSString *jsonStr = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:jsonData options:NSJSONWritingPrettyPrinted error:&error] encoding:NSUTF8StringEncoding];
    return [self storeCacheString:jsonStr forKey:key];
}

#pragma mark -

- (void)removeCacheDataForKey:(NSString *)key
{
    if(key == nil || 0 == key.length) return;
    NSString *filePath = [self cachedFilePathForKey:key];
    if (filePath) {
        [[NSFileManager defaultManager]removeItemAtPath:filePath error:nil];
    }
}

- (BOOL)isCacheDataExist:(NSString *)key
{
    NSString *filePath =  [self cachedFilePathForKey:key];
    if (filePath) {
        return [[NSFileManager defaultManager]fileExistsAtPath:filePath];
    }
    return NO;
}

- (BOOL)clearAllCacheData
{
    BOOL retValue = NO;
    retValue = [[NSFileManager defaultManager] removeItemAtPath:self.cacheRootDirectory error:nil];
    if (retValue) {
        [self setupCacheDirectory];
    }
    return retValue;
}

- (NSDate*)cacheModificationDateOfKey:(NSString*)key
{
    NSString *filePath = [self cachedFilePathForKey:key];
    if (filePath == nil) {
        return nil;
    }
    NSFileManager* fileManager = [NSFileManager defaultManager];
    NSError *attributesRetrievalError = nil;
    NSDictionary *attributes = [fileManager attributesOfItemAtPath:filePath
                                                             error:&attributesRetrievalError];
    return [attributes objectForKey:NSFileModificationDate];
}

#pragma mark private methods.
- (NSString*)md5HashForKey:(NSString*)key
{
    // encode key
    NSData *encodedKeyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    
    // generate the md5 value for key.
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5([encodedKeyData bytes], [encodedKeyData length], result);
    
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]
            ];
}

- (NSString*)cachedFilePathForMD5HashKey:(NSString*)md5Key
{
    NSString *filePath = [md5Key substringWithRange:NSMakeRange(0, 2)];
    filePath = [self.cacheRootDirectory stringByAppendingPathComponent:filePath];
    if (![[NSFileManager defaultManager]fileExistsAtPath:filePath]) {
         [[NSFileManager defaultManager] createDirectoryAtPath:filePath withIntermediateDirectories:NO attributes:nil error:nil];
    }
    return [filePath stringByAppendingPathComponent:md5Key];
}

- (void)setupCacheDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *cacheLocation = [[paths objectAtIndex:0] stringByAppendingPathComponent: self.cacheRootFolderName];
    [[NSFileManager defaultManager] createDirectoryAtPath:cacheLocation withIntermediateDirectories:NO attributes:nil error:nil];
    self.cacheRootDirectory = cacheLocation;
}

@end
