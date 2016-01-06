//
//  DetailStoryWebView.m
//  ZhihuDaily
//
//  Created by 刘阳 on 16/1/5.
//  Copyright © 2016年 刘阳. All rights reserved.
//

#import "DetailStoryWebView.h"
#import "GCDQueue.h"
#import "NSString+Cache.h"
#import "TopStoryView.h"

@interface DetailStoryWebView ()

@property (nonatomic, readonly) TopStoryView* detailStoryHeaderView;
@property (nonatomic, readonly) UIWebView* detailStoryWebView;

@end

@implementation DetailStoryWebView

@synthesize detailStoryHeaderView = _detailStoryHeaderView;
@synthesize detailStoryWebView = _detailStoryWebView;

-(void)setDetailStory:(DetailStory *)detailStory {
    if (detailStory == nil) { return; }
    _detailStory = detailStory;
    [[GCDQueue highPriorityGlobalQueue] executeAsync:^{
        NSString* CSSString = [NSString stringWithURL: [NSURL URLWithString:self.detailStory.CSSURLString]];
        NSString* htmlFormatString = @"<html><head><style>%@</style></head><body>%@</body></html>";
        NSString* htmlString = [NSString stringWithFormat:htmlFormatString, CSSString, detailStory.body];
        [[GCDQueue mainQueue] executeAsync:^{
            [self.detailStoryWebView loadHTMLString:htmlString baseURL:nil];
            self.detailStoryHeaderView.story = _detailStory;
        }];
    }];
}

-(UIWebView *)detailStoryWebView {
    if (_detailStoryWebView == nil) {
        _detailStoryWebView = [[UIWebView alloc]initWithFrame:self.bounds];
    }
    return _detailStoryWebView;
}

-(TopStoryView *)detailStoryHeaderView {
    if (_detailStoryHeaderView == nil) {
        _detailStoryHeaderView = [[TopStoryView alloc]initWithFrame:CGRectMake(0, -20, self.bounds.size.width, 223)];
    }
    return _detailStoryHeaderView;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])){
        [self initPrivate];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder*)aDecoder
{
    if ((self = [super initWithCoder:aDecoder])){
        [self initPrivate];
    }
    return self;
}

-(void)initPrivate {
    self.backgroundColor = [UIColor blackColor];
    [self addSubview:self.detailStoryWebView];
    [self.detailStoryWebView.scrollView addSubview:self.detailStoryHeaderView];
    [self moveDownWebViewWithHeight:0];
    self.detailStoryWebView.scrollView.showsHorizontalScrollIndicator = NO;
    self.detailStoryWebView.scrollView.showsVerticalScrollIndicator = NO;
}

-(void)moveDownWebViewWithHeight:(NSUInteger)height {
    CGRect detailStoryHeaderViewBounds = self.detailStoryWebView.bounds;
    for (UIView* view in self.detailStoryWebView.scrollView.subviews) {
        if (CGRectEqualToRect(view.frame, detailStoryHeaderViewBounds)) {
            CGRect frame = view.frame;
            frame.origin.y += height;
            view.frame = frame;
        }
    }
}

@end
