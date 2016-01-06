//
//  CyclePagingScrollViewController.h
//  ZhihuDaily
//
//  Created by 刘阳 on 15/12/27.
//  Copyright © 2015年 刘阳. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CyclePagingScrollView;
@class Story;

@protocol CyclePagingScrollViewDataSource

-(NSInteger)numberOfItemsInCyclePagingScrollView:(CyclePagingScrollView*) cyclePagingScrollView;
-(Story*)cyclePagingScrollView:(CyclePagingScrollView*)cyclePagingScrollView storyForItemAtIndex:(NSInteger)index;

@end

@interface CyclePagingScrollViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic) id<CyclePagingScrollViewDataSource> storiesDataSource;

@end