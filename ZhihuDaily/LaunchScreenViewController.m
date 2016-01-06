//
//  LaunchScreenViewController.m
//  ZhihuDaily
//
//  Created by 刘阳 on 15/12/25.
//  Copyright © 2015年 刘阳. All rights reserved.
//

#import "LaunchScreenViewController.h"
#import "LaunchScreenView.h"
#import "GCDQueue.h"
#import "MainTableViewController.h"
#import "CustomNavigationController.h"

@interface LaunchScreenViewController ()

@property (nonatomic) LaunchScreenView* launchScreenView;

@end

@implementation LaunchScreenViewController

+(CATransition*) fadeTransition {
    static CATransition* transition = nil;
    @synchronized(self) {
        if (transition == nil) {
            transition = [CATransition animation];
            transition.duration = 1.5;
            transition.type = kCATransitionFade;
        }
    }
    return transition;
}

-(LaunchScreenView *)launchScreenView {
    if (_launchScreenView == nil) {
        _launchScreenView = [[LaunchScreenView alloc] initWithFrame: self.view.bounds];
    }
    return _launchScreenView;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview: self.launchScreenView];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    MainTableViewController* mainTableViewController = [[MainTableViewController alloc]init];
    [mainTableViewController retrieveDataFromServer:^{
        [[GCDQueue mainQueue] execute:^{
            [self.view.window.layer addAnimation:[LaunchScreenViewController fadeTransition] forKey:kCATransition];
            CustomNavigationController *navigationController = [[CustomNavigationController alloc]
                                                     initWithRootViewController:mainTableViewController];
            [self presentViewController:navigationController animated:NO completion:nil];
        } afterDelaySeconds:2];
    }];
}

@end