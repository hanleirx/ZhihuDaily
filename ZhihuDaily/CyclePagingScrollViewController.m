//
//  CyclePagingScrollViewController.m
//  ZhihuDaily
//
//  Created by 刘阳 on 15/12/27.
//  Copyright © 2015年 刘阳. All rights reserved.
//

#import "CyclePagingScrollViewController.h"
#import "CyclePagingScrollView.h"
#import "TopStoryView.h"
#import "Story.h"
#import "DetailViewController.h"

@interface CyclePagingScrollViewController ()

@property (nonatomic, readonly) CyclePagingScrollView* cyclePagingScrollView;
@property (nonatomic) NSUInteger currentIndex;

@end

@implementation CyclePagingScrollViewController

@synthesize cyclePagingScrollView = _cyclePagingScrollView;

-(CyclePagingScrollView *)cyclePagingScrollView {
    if (_cyclePagingScrollView == nil) {
        _cyclePagingScrollView = [[CyclePagingScrollView alloc]initWithFrame:self.view.bounds];
    }
    return _cyclePagingScrollView;
}

-(void)viewDidLoad {
    UITapGestureRecognizer* tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                                          action:@selector(pushToDetailView:)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
    self.view.userInteractionEnabled = YES;
}

-(void)pushToDetailView:(UITapGestureRecognizer *)recognizer {
    DetailViewController* detailViewController = [[DetailViewController alloc]init];
    Story* selectedDailyStory = [self.storiesDataSource cyclePagingScrollView:self.cyclePagingScrollView
                                                          storyForItemAtIndex:self.currentIndex];
    detailViewController.identifier = selectedDailyStory.identifier;
    [self.navigationController pushViewController:detailViewController animated:YES];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.cyclePagingScrollView.delegate = self;
    [self.view addSubview: self.cyclePagingScrollView];
    [self setStoryViewsForIndex:self.currentIndex];
}

-(void)setStoryViewsForIndex:(NSInteger)index {
    if (self.storiesDataSource == nil) { return; }
    NSInteger numberOfStories = [self.storiesDataSource numberOfItemsInCyclePagingScrollView:self.cyclePagingScrollView];
    if (numberOfStories == 0) { return; }
    for (NSInteger i = 0; i < 3; i++) {
        NSInteger realIndex = ((index - 1) + i) % numberOfStories;
        realIndex = realIndex < 0 ? realIndex + numberOfStories: realIndex;
        TopStoryView* currentView = [self.cyclePagingScrollView.topStoryViews objectAtIndex:i];
        Story* story = [self.storiesDataSource cyclePagingScrollView:self.cyclePagingScrollView
                                                 storyForItemAtIndex:realIndex];
        currentView.story = story;
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (self.storiesDataSource == nil) {
        return;
    }
    NSInteger numberOfStories = [self.storiesDataSource numberOfItemsInCyclePagingScrollView:self.cyclePagingScrollView];
    if (scrollView.contentOffset.x >= scrollView.bounds.size.width * 2) {
        self.currentIndex = (self.currentIndex + 1) % numberOfStories;
    } else if (scrollView.contentOffset.x <= 0) {
        self.currentIndex -= 1;
        if (self.currentIndex == -1) {
            self.currentIndex = numberOfStories - 1;
        }
    }
    [scrollView setContentOffset:CGPointMake(scrollView.bounds.size.width, 0)];
    [self setStoryViewsForIndex:self.currentIndex];
}

@end
