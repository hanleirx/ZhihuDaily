//
//  CyclePagingScrollView.h
//  ZhihuDaily
//
//  Created by 刘阳 on 15/12/27.
//  Copyright © 2015年 刘阳. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Stories.h"
#import "Story.h"

@interface CyclePagingScrollView : UIScrollView

@property (nonatomic, readonly) NSMutableArray* topStoryViews;

@end