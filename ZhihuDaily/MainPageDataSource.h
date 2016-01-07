//
//  MainPageDataSource.h
//  ZhihuDaily
//
//  Created by 刘阳 on 15/12/28.
//  Copyright © 2015年 刘阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Stories;
@class Story;

@interface MainPageDataSource : NSObject

-(void)retrieveDataFromServer: (void (^)(void)) completion;
-(void)getLastStoriesDataFromServer:(void (^)(BOOL)) completion;
-(NSInteger)numberOfTopStories;
-(NSInteger)numberOfSections;
-(NSInteger)numberOfStoriesInSection:(NSInteger)section;
-(Story*)topStoryAtIndex:(NSInteger)index;
-(Story*)dailyStoryAtIndex:(NSInteger)index inSection:(NSInteger)section;
-(NSDate*)dateOfStoriesInSection:(NSInteger)section;

@end
