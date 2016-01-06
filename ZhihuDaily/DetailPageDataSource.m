//
//  DetailPageDataSource.m
//  ZhihuDaily
//
//  Created by 刘阳 on 16/1/5.
//  Copyright © 2016年 刘阳. All rights reserved.
//

#import "DetailPageDataSource.h"
#import "GCDQueue.h"
#import "DetailStory.h"

@implementation DetailPageDataSource

-(void)retrieveDataFromServerWithIdentifier:(NSUInteger)identifier CompletionHandler:(void (^)(void)) completion {
    NSURLSession* session = [NSURLSession sharedSession];
    NSString* requestURLString = [NSString stringWithFormat:@"http://news-at.zhihu.com/api/4/news/%lu",
                                  (unsigned long)identifier];
    NSURL* requestURL = [NSURL URLWithString: requestURLString];
    [[session dataTaskWithURL: requestURL completionHandler:^(NSData* data, NSURLResponse* response, NSError* error) {
        [[GCDQueue mainQueue] executeAsync:^{
            NSHTTPURLResponse* responseFromServer = (NSHTTPURLResponse*)response;
            if (data != nil && error == nil && responseFromServer.statusCode == 200) {
                NSError* parseError = nil;
                id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
                if (parseError) { return; }
                if ([object isKindOfClass: [NSDictionary class]]) {
                    NSDictionary* result = object;
                    self.detailStory = [[DetailStory alloc] initWithData:result];
                }
            }
            completion();
        }];
    }] resume];
}

@end
