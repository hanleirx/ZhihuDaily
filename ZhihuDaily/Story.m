//
//  Story.m
//  ZhihuDaily
//
//  Created by 刘阳 on 15/12/27.
//  Copyright © 2015年 刘阳. All rights reserved.
//

#import "Story.h"

@interface Story ()

@property (nonatomic, readwrite) NSString* imageURLString;
@property (nonatomic, readwrite) NSString* title;
@property (nonatomic, readwrite) NSUInteger identifier;
@property (nonatomic, readwrite) BOOL multiPictures;

@end

@implementation Story

-(instancetype)initWithData:(NSDictionary*) data {
    self = [super init];
    if (self) {
        self.title = [data objectForKey:@"title"];
        self.identifier = [[data objectForKey:@"id"] unsignedIntegerValue];
        self.imageURLString = [data objectForKey:@"image"];
        if (self.imageURLString == nil) {
            self.imageURLString = [[data objectForKey:@"images"] objectAtIndex:0];
        }
        self.multiPictures = [[data objectForKey:@"multipic"] boolValue];
    }
    return self;
}

@end
