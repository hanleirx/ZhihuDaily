//
//  MainPageDataSource.m
//  ZhihuDaily
//
//  Created by 刘阳 on 15/12/28.
//  Copyright © 2015年 刘阳. All rights reserved.
//

#import "MainPageDataSource.h"
#import "Stories.h"
#import "Story.h"
#import "DailyStories.h"
#import "GCDQueue.h"

@interface MainPageDataSource ()

@property (nonatomic) Stories* topStories;
@property (nonatomic, readonly) NSMutableArray* dailyStoriesArray;

@end

@implementation MainPageDataSource

@synthesize dailyStoriesArray = _dailyStoriesArray;

-(Stories *)topStories {
    if (_topStories == nil) {
        _topStories = [[Stories alloc]init];
    }
    return _topStories;
}

-(NSMutableArray *)dailyStoriesArray {
    if (_dailyStoriesArray == nil) {
        _dailyStoriesArray = [[NSMutableArray alloc]init];
    }
    return _dailyStoriesArray;
}

-(void)retrieveDataFromServer: (void (^)(void)) completion {
    completion = completion == nil ? ^(){return;} : completion;
    NSURLSession* session = [NSURLSession sharedSession];
    NSURL* requestURL = [NSURL URLWithString: @"http://news-at.zhihu.com/api/4/news/latest"];
    [[session dataTaskWithURL: requestURL completionHandler:^(NSData* data, NSURLResponse* response, NSError* error) {
        [[GCDQueue mainQueue] executeAsync:^{
            NSHTTPURLResponse* responseFromServer = (NSHTTPURLResponse*)response;
            if (data != nil && error == nil && responseFromServer.statusCode == 200) {
                NSError* parseError = nil;
                id object = [NSJSONSerialization JSONObjectWithData: data options: 0 error: &parseError];
                if (parseError) { return; }
                if ([object isKindOfClass: [NSDictionary class]]) {
                    NSDictionary* result = object;
                    self.topStories = [[Stories alloc]initWithArray:[result objectForKey:@"top_stories"]];
                    DailyStories* dailyStories = [[DailyStories alloc]initWithData:result];
                    [self.dailyStoriesArray removeAllObjects];
                    [self.dailyStoriesArray addObject:dailyStories];
                }
            }
            completion();
        }];
    }] resume];
}

-(void)getLastStoriesDataFromServer:(void (^)(BOOL)) completion {
    completion = completion == nil ? ^(BOOL succeed){return;} : completion;
    NSURLSession* session = [NSURLSession sharedSession];
    NSURL* URL = [NSURL URLWithString: @"http://news.at.zhihu.com/api/4/news/before/"];
    NSDateFormatter* formatter = [DailyStories sharedFormatter];
    NSString* dateString = [formatter stringFromDate:((DailyStories*)[self.dailyStoriesArray lastObject]).date];
    if (dateString == nil) {
        completion(NO);
        return;
    }
    NSURL* requestURL = [NSURL URLWithString:dateString relativeToURL:URL];
    [[session dataTaskWithURL:requestURL completionHandler:^(NSData* data, NSURLResponse* response, NSError* error) {
        [[GCDQueue mainQueue] executeAsync:^{
            NSHTTPURLResponse* responseFromServer = (NSHTTPURLResponse*)response;
            if (data != nil && error == nil && responseFromServer.statusCode == 200) {
                NSError* parseError = nil;
                id object = [NSJSONSerialization JSONObjectWithData: data options: 0 error: &parseError];
                if (parseError) { return; }
                if ([object isKindOfClass: [NSDictionary class]]) {
                    NSDictionary* result = object;
                    DailyStories* dailyStories = [[DailyStories alloc]initWithData:result];
                    [self.dailyStoriesArray addObject:dailyStories];
                    completion(YES);
                    return;
                }
            }
            completion(NO);
        }];
    }] resume];
}

-(NSInteger)numberOfTopStories {
    return self.topStories.stories.count;
}

-(NSInteger)numberOfSections {
    return self.dailyStoriesArray.count;
}

-(NSInteger)numberOfStoriesInSection:(NSInteger)section {
    DailyStories* dailyStories = self.dailyStoriesArray[section];
    return dailyStories.stories.count;
}

-(Story*)topStoryAtIndex:(NSInteger)index {
    return self.topStories.stories[index];
}

-(Story*)dailyStoryAtIndex:(NSInteger)index inSection:(NSInteger)section {
    DailyStories* dailyStories = self.dailyStoriesArray[section];
    return dailyStories.stories[index];
}

-(NSDate*)dateOfStoriesInSection:(NSInteger)section {
    DailyStories* dailyStories = self.dailyStoriesArray[section];
    return dailyStories.date;
}


@end
