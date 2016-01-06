//
//  UIImageView+Cache
//  ZhihuDaily
//
//  Created by 刘阳 on 15/12/27.
//  Copyright © 2015年 刘阳. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Cache)

-(void)setImageFromURL:(NSURL*)url;
-(void)setImageFromURL:(NSURL *)url completionHandler:(void (^)(void))completion;

@end
