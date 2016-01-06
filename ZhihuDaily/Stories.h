//
//  Stories.h
//  ZhihuDaily
//
//  Created by 刘阳 on 15/12/27.
//  Copyright © 2015年 刘阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Stories : NSObject

@property (nonatomic, readonly) NSMutableArray* stories;

-(instancetype)initWithArray:(NSArray*) array;

@end
