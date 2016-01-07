//
//  CyclePagingScrollView.m
//  ZhihuDaily
//
//  Created by 刘阳 on 15/12/27.
//  Copyright © 2015年 刘阳. All rights reserved.
//

#import "CyclePagingScrollView.h"
#import "TopStoryView.h"

@interface CyclePagingScrollView ()

@end

@implementation CyclePagingScrollView

@synthesize topStoryViews = _topStoryViews;

-(NSArray *)topStoryViews {
    if (_topStoryViews == nil) {
        _topStoryViews = [[NSMutableArray alloc]init];
        for (int i = 0; i < 3; i++) {
            CGRect frame = CGRectMake(self.bounds.size.width * i, 0, self.bounds.size.width, self.bounds.size.height);
            TopStoryView* topStoryView = [[TopStoryView alloc]initWithFrame:frame];
            [_topStoryViews addObject:topStoryView];
        }
    }
    return _topStoryViews;
}

-(void)initPrivate {
    self.contentSize = CGSizeMake(self.bounds.size.width * 3, self.bounds.size.height);
    self.pagingEnabled = YES;
    [self setupSubViews];
    [self setContentOffset:CGPointMake(self.bounds.size.width, 0)];
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
}

-(instancetype)init {
    self = [super init];
    if (self != nil) {
        [self initPrivate];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self != nil) {
        [self initPrivate];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initPrivate];
    }
    return self;
}

-(void)setupSubViews {
    for (TopStoryView* view in self.topStoryViews) {
        [self addSubview:view];
    }
}

@end
