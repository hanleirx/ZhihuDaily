//
//  DetailStory.m
//  ZhihuDaily
//
//  Created by 刘阳 on 16/1/5.
//  Copyright © 2016年 刘阳. All rights reserved.
//

#import "DetailStory.h"

@interface DetailStory ()

@property (nonatomic, readwrite) NSString* body;
@property (nonatomic, readwrite) NSString* imageSource;
@property (nonatomic, readwrite) NSString* CSSURLString;

@end

@implementation DetailStory

-(instancetype)initWithData:(NSDictionary*) data {
    self = [super initWithData:data];
    if (self) {
        self.body = [data objectForKey:@"body"];
        self.imageSource = [data objectForKey:@"image-source"];
        self.CSSURLString = [[data objectForKey:@"css"] objectAtIndex:0];
    }
    return self;
}

@end
