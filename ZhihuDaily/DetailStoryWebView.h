//
//  DetailStoryWebView.h
//  ZhihuDaily
//
//  Created by 刘阳 on 16/1/5.
//  Copyright © 2016年 刘阳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailStory.h"

@interface DetailStoryWebView : UIView <UIWebViewDelegate>

@property (nonatomic) DetailStory* detailStory;

@end
