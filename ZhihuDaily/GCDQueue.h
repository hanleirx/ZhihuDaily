//
//  GCDQueue.h
//  ZhihuDaily
//
//  Created by 刘阳 on 15/12/26.
//  Copyright © 2015年 刘阳. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, GCDQueueType) {
    GCDQueueTypeNone = 0,
    GCDQueueTypeSerial,
    GCDQueueTypeConcurrent
};

@interface GCDQueue : NSObject

@property (nonatomic) dispatch_queue_t dispatchQueue;

-(instancetype)init;
-(instancetype)initWithType: (GCDQueueType)type;

-(void)executeAsync: (dispatch_block_t)block;
-(void)executeSync: (dispatch_block_t)block;
-(void)execute: (dispatch_block_t)block afterDelaySeconds: (NSTimeInterval) seconds;
-(void)suspend;
-(void)resume;

+(instancetype)mainQueue;
+(instancetype)defaultPriorityGlobalQueue;
+(instancetype)highPriorityGlobalQueue;
+(instancetype)lowPriorityGlobalQueue;
+(instancetype)backgroundPriorityGlobalQueue;


@end
