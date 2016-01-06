//
//  DetailStory.h
//  ZhihuDaily
//
//  Created by 刘阳 on 16/1/5.
//  Copyright © 2016年 刘阳. All rights reserved.
//

#import "Story.h"

@interface DetailStory : Story

@property (nonatomic, readonly) NSString* body;
@property (nonatomic, readonly) NSString* imageSource;
@property (nonatomic, readonly) NSString* CSSURLString;

-(instancetype)initWithData:(NSDictionary*) data;

@end
