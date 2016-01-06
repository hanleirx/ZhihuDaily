//
//  NSData+Cache.m
//  ZhihuDaily
//
//  Created by 刘阳 on 15/12/28.
//  Copyright © 2015年 刘阳. All rights reserved.
//

#import "NSData+Cache.h"
#import "GCDQueue.h"
#import <CommonCrypto/CommonDigest.h>

#define kSDMaxCacheFileAmount 256

@implementation NSData (Cache)

+(NSString*)cachePath {
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    path = [path stringByAppendingPathComponent:@"Caches"];
    path = [path stringByAppendingPathComponent:@"KSCODataCache"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return path;
}

+ (NSString *)creatMD5StringWithString:(NSString *)string
{
    const char *original_str = [string UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, (CC_LONG)strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02X", result[i]];
    [hash lowercaseString];
    return hash;
}

+ (NSString *)dataPathWithString:(NSString *)string
{
    NSString *path = [NSData cachePath];
    path = [path stringByAppendingPathComponent:[self creatMD5StringWithString:string]];
    return path;
}

-(void)saveDataCacheWithIdentifier:(NSString*)identifier {
    NSString *path = [NSData dataPathWithString:identifier];
    [self writeToFile:path atomically:YES];
}

+(NSData*)dataCacheWithIdentifier:(NSString*)identifier {
    static BOOL isCheckedCacheDisk = NO;
    if (!isCheckedCacheDisk) {
        NSFileManager *manager = [NSFileManager defaultManager];
        NSArray *contents = [manager contentsOfDirectoryAtPath:[self cachePath] error:nil];
        if (contents.count >= kSDMaxCacheFileAmount) {
            [manager removeItemAtPath:[self cachePath] error:nil];
        }
        isCheckedCacheDisk = YES;
    }
    NSString *path = [self dataPathWithString:identifier];
    NSData *data = [NSData dataWithContentsOfFile:path];
    return data;
}

+(void)dataCacheWithIdentifier:(NSString*)identifier completionHandler:(void(^)(NSData* data))completion {
    [[GCDQueue defaultPriorityGlobalQueue] executeAsync:^{
        NSData* data = [NSData dataCacheWithIdentifier:identifier];
        if (completion != nil) { completion(data); }
    }];
}

@end
