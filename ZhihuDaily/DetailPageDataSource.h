//
//  DetailPageDataSource.h
//  ZhihuDaily
//
//  Created by 刘阳 on 16/1/5.
//  Copyright © 2016年 刘阳. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DetailStory.h"

@interface DetailPageDataSource : NSObject

@property (nonatomic) DetailStory* detailStory;

-(void)retrieveDataFromServerWithIdentifier:(NSUInteger)identifier CompletionHandler:(void (^)(void)) completion;

@end
