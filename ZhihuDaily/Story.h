//
//  Story.h
//  ZhihuDaily
//
//  Created by 刘阳 on 15/12/27.
//  Copyright © 2015年 刘阳. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Story : NSObject

@property (nonatomic, readonly) NSString* imageURLString;
@property (nonatomic, readonly) NSString* title;
@property (nonatomic, readonly) NSUInteger identifier;
@property (nonatomic, readonly) BOOL multiPictures;

-(instancetype)initWithData:(NSDictionary*) data;

@end
