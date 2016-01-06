//
//  Stories.m
//  ZhihuDaily
//
//  Created by 刘阳 on 15/12/27.
//  Copyright © 2015年 刘阳. All rights reserved.
//

#import "Stories.h"
#import "Story.h"

@interface Stories ()

@end

@implementation Stories

@synthesize stories = _stories;

-(NSMutableArray *)stories {
    if (_stories == nil) {
        _stories = [[NSMutableArray alloc]init];
    }
    return _stories;
}

-(instancetype)initWithArray:(NSArray*) array {
    self = [super init];
    if (self) {
        for (NSDictionary* data in array) {
            Story* story = [[Story alloc] initWithData:data];
            [self.stories addObject:story];
        }
    }
    return self;
}

@end
