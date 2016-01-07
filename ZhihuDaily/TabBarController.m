//
//  TabBarController.m
//  ZhihuDaily
//
//  Created by 刘阳 on 16/1/7.
//  Copyright © 2016年 刘阳. All rights reserved.
//

#import "TabBarController.h"
#import "MainTableViewController.h"
#import "GCDQueue.h"
#import "CustomNavigationController.h"

@interface TabBarController ()

@property (nonatomic, readonly) MainTableViewController* mainTableViewController;
@property (nonatomic, readonly) CustomNavigationController* mainNavigationController;
@property (nonatomic, readonly) CustomNavigationController* classifyNavigationController;

@end

@implementation TabBarController

@synthesize mainNavigationController = _mainNavigationController;
@synthesize mainTableViewController = _mainTableViewController;
@synthesize classifyNavigationController = _classifyNavigationController;

-(CustomNavigationController *)mainNavigationController {
    if (_mainNavigationController == nil) {
        _mainNavigationController = [[CustomNavigationController alloc] init];
        _mainNavigationController.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemTopRated
                                                                                          tag:1];
    }
    return _mainNavigationController;
}

-(CustomNavigationController *)classifyNavigationController {
    if (_classifyNavigationController == nil) {
        _classifyNavigationController = [[CustomNavigationController alloc] init];
        _classifyNavigationController.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemMore
                                                                                          tag:2];

    }
    return _classifyNavigationController;
}

-(MainTableViewController *)mainTableViewController {
    if (_mainTableViewController == nil) {
        _mainTableViewController = [[MainTableViewController alloc] init];
    }
    return _mainTableViewController;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *tabViewControllers = [[NSMutableArray alloc] init];
    [tabViewControllers addObject:self.mainNavigationController];
    [tabViewControllers addObject:self.classifyNavigationController];
    [self.mainTableViewController retrieveDataFromServer:^{
        [[GCDQueue mainQueue] executeAsync:^{
            [self.mainNavigationController setViewControllers:@[self.mainTableViewController] animated:YES];
        }];
    }];
    [self setViewControllers:tabViewControllers];
}

@end
