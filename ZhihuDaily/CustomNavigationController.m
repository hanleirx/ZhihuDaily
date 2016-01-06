//
//  CustomNavigationController.m
//  ZhihuDaily
//
//  Created by 刘阳 on 16/1/5.
//  Copyright © 2016年 刘阳. All rights reserved.
//

#import "CustomNavigationController.h"

@implementation CustomNavigationController

// 处理在 Navigation Bar 隐藏的时候 Swipe Back 失效的问题

- (void)setNavigationBarHidden:(BOOL)hidden animated:(BOOL)animated {
    [super setNavigationBarHidden:hidden animated:animated];
    self.interactivePopGestureRecognizer.delegate = self;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (self.viewControllers.count > 1) {
        return YES;
    }
    return NO;
}

@end
