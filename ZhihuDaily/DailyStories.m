//
//  DailyStories.m
//  ZhihuDaily
//
//  Created by 刘阳 on 15/12/27.
//  Copyright © 2015年 刘阳. All rights reserved.
//

#import "DailyStories.h"

@interface DailyStories ()

@property (nonatomic, readwrite) NSDate* date;

@end

@implementation DailyStories

+(NSDateFormatter *)sharedFormatter {
    static NSDateFormatter* formatter = nil;
    @synchronized(self) {
        if (formatter == nil) {
            formatter = [[NSDateFormatter alloc]init];
            formatter.dateFormat = @"yyyyMMdd";
        }
    }
    return formatter;
}

-(instancetype)initWithData:(NSDictionary*)data {
    NSArray* array = [data objectForKey:@"stories"];
    self = [super initWithArray:array];
    if (self) {
        NSString* dateString = [data objectForKey:@"date"];
        self.date = [[DailyStories sharedFormatter] dateFromString:dateString];
    }
    return self;
}

@end
