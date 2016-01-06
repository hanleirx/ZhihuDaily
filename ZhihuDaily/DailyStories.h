//
//  DailyStories.h
//  ZhihuDaily
//
//  Created by 刘阳 on 15/12/27.
//  Copyright © 2015年 刘阳. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Stories.h"

@interface DailyStories : Stories

@property (nonatomic, readonly) NSDate* date;

+(NSDateFormatter *)sharedFormatter;
-(instancetype)initWithData:(NSDictionary*)data;

@end
