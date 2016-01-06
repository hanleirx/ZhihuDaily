//
//  AppDelegate.m
//  ZhihuDaily
//
//  Created by 刘阳 on 15/12/22.
//  Copyright © 2015年 刘阳. All rights reserved.
//

#import "AppDelegate.h"
#import "LaunchScreenViewController.h"
#import "PermanentDataManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame: [[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[LaunchScreenViewController alloc]init];
    [self.window makeKeyAndVisible];
    [self requestLaunchData];
    return YES;
}

-(void)requestLaunchData {
    NSURLSession* session = [NSURLSession sharedSession];
    NSURL* requestURL = [NSURL URLWithString: @"http://news-at.zhihu.com/api/4/start-image/1080*1776"];
    [[session dataTaskWithURL: requestURL completionHandler:^(NSData* data, NSURLResponse* response, NSError* error) {
        if(data != nil) {
            [[PermanentDataManager sharedManager] setupLaunchDataFromJSONData: data];
        }
    }] resume];
}

@end
