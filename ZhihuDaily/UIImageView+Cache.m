//
//  UIImageView+Download.m
//  ZhihuDaily
//
//  Created by 刘阳 on 15/12/27.
//  Copyright © 2015年 刘阳. All rights reserved.
//

#import "UIImageView+Cache.h"
#import "GCDQueue.h"
#import "NSData+Cache.h"

@implementation UIImageView (Cache)

-(void)setImageFromURL:(NSURL*)url {
    if (url == nil) { return; }
    NSData* data = [NSData dataCacheWithIdentifier:url.absoluteString];
    if (data != nil) {
        self.image = [UIImage imageWithData:data];
        return;
    }
    NSURLSession* session = [NSURLSession sharedSession];
    [[session dataTaskWithURL: url completionHandler:^(NSData* data, NSURLResponse* response, NSError* error) {
        NSHTTPURLResponse* responseFromServer = (NSHTTPURLResponse*)response;
        if (data != nil && error == nil && responseFromServer.statusCode == 200) {
            [data saveDataCacheWithIdentifier:url.absoluteString];
            [[GCDQueue mainQueue] executeAsync: ^{
                self.image = [UIImage imageWithData:data];
            }];
        }
    }] resume];
}

-(void)setImageFromURL:(NSURL *)url completionHandler:(void (^)(void))completion {
    if (url == nil) { return; }
    [NSData dataCacheWithIdentifier:url.absoluteString completionHandler:^(NSData *dataFromCache) {
        if (dataFromCache != nil) {
            [[GCDQueue mainQueue] executeAsync: ^{
                self.image = [UIImage imageWithData:dataFromCache];
            }];
            if (completion != nil) { completion(); }
            return;
        }
        NSURLSession* session = [NSURLSession sharedSession];
        [[session dataTaskWithURL: url completionHandler:^(NSData* dataFromServer, NSURLResponse* response, NSError* error) {
            NSHTTPURLResponse* responseFromServer = (NSHTTPURLResponse*)response;
            if (dataFromServer != nil && error == nil && responseFromServer.statusCode == 200) {
                [dataFromServer saveDataCacheWithIdentifier:url.absoluteString];
                [[GCDQueue mainQueue] executeAsync: ^{
                    self.image = [UIImage imageWithData:dataFromServer];
                }];
            }
            if (completion != nil) { completion(); }
        }] resume];
    }];
}

@end
