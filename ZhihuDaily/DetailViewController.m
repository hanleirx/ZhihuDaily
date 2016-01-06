//
//  DetailViewController.m
//  ZhihuDaily
//
//  Created by 刘阳 on 15/12/30.
//  Copyright © 2015年 刘阳. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailStoryWebView.h"
#import "DetailPageDataSource.h"

@interface DetailViewController ()

@property (nonatomic, readonly) DetailPageDataSource* detailPageDataSource;
@property (nonatomic, readonly) DetailStoryWebView* detailStoryWebView;

@end

@implementation DetailViewController

@synthesize detailPageDataSource = _detailPageDataSource;
@synthesize detailStoryWebView = _detailStoryWebView;

+(UIColor*)themeColor {
    static UIColor* color = nil;
    @synchronized(self) {
        if (color == nil) {
            color = [[UIColor alloc]initWithRed:0.2 green:0.6 blue:0.9 alpha:1.0];
        }
    }
    return color;
}

-(DetailPageDataSource *)detailPageDataSource {
    if (_detailPageDataSource == nil) {
        _detailPageDataSource = [[DetailPageDataSource alloc] init];
    }
    return _detailPageDataSource;
}

-(DetailStoryWebView *)detailStoryWebView {
    if (_detailStoryWebView == nil) {
        _detailStoryWebView = [[DetailStoryWebView alloc] initWithFrame:self.view.bounds];
    }
    return _detailStoryWebView;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [DetailViewController themeColor];
    [self.view addSubview:self.detailStoryWebView];
    [self.detailPageDataSource retrieveDataFromServerWithIdentifier:self.identifier CompletionHandler:^{
        self.detailStoryWebView.detailStory = self.detailPageDataSource.detailStory;
    }];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    // self.navigationController.toolbarHidden = NO;
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    // self.navigationController.toolbarHidden = YES;
}

@end