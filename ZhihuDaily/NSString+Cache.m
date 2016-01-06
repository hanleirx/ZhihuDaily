//
//  NSString+Cache.m
//  ZhihuDaily
//
//  Created by 刘阳 on 16/1/5.
//  Copyright © 2016年 刘阳. All rights reserved.
//

#import "NSString+Cache.h"
#import "NSData+Cache.h"
#import "GCDQueue.h"

@implementation NSString (Cache)

+(NSString*) stringWithURL:(NSURL*)url {
    if (url == nil) { return nil; }
    NSData* data = [NSData dataCacheWithIdentifier:url.absoluteString];
    if (data != nil) {
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
}

@end
