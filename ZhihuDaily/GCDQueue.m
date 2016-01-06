//
//  GCDQueue.m
//  ZhihuDaily
//
//  Created by 刘阳 on 15/12/26.
//  Copyright © 2015年 刘阳. All rights reserved.
//

#import "GCDQueue.h"

@interface GCDQueue ()

@end

@implementation GCDQueue

+(instancetype)mainQueue {
    static GCDQueue* queue = nil;
    @synchronized(self) {
        if (queue == nil) {
            queue = [[GCDQueue alloc] init];
            queue.dispatchQueue = dispatch_get_main_queue();
        }
    }
    return queue;
}

+(instancetype)defaultPriorityGlobalQueue {
    static GCDQueue* queue = nil;
    @synchronized(self) {
        if (queue == nil) {
            queue = [[GCDQueue alloc] init];
            queue.dispatchQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        }
    }
    return queue;
}

+(instancetype)highPriorityGlobalQueue {
    static GCDQueue* queue = nil;
    @synchronized(self) {
        if (queue == nil) {
            queue = [[GCDQueue alloc] init];
            queue.dispatchQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
        }
    }
    return queue;
}

+(instancetype)lowPriorityGlobalQueue {
    static GCDQueue* queue = nil;
    @synchronized(self) {
        if (queue == nil) {
            queue = [[GCDQueue alloc] init];
            queue.dispatchQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);
        }
    }
    return queue;
}

+(instancetype)backgroundPriorityGlobalQueue {
    static GCDQueue* queue = nil;
    @synchronized(self) {
        if (queue == nil) {
            queue = [[GCDQueue alloc] init];
            queue.dispatchQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
        }
    }
    return queue;
}

-(instancetype) init {
    return [self initWithType: GCDQueueTypeNone];
}

-(instancetype) initWithType: (GCDQueueType)type {
    self = [super init];
    if (self) {
        switch (type) {
            case GCDQueueTypeSerial:
                self.dispatchQueue = dispatch_queue_create(nil, DISPATCH_QUEUE_SERIAL);
                break;
            case GCDQueueTypeConcurrent:
                self.dispatchQueue = dispatch_queue_create(nil, DISPATCH_QUEUE_CONCURRENT);
            case GCDQueueTypeNone:
                break;
        }
    }
    return self;
}

-(void)executeAsync: (dispatch_block_t)block {
    dispatch_async(self.dispatchQueue, block);
}

-(void)executeSync: (dispatch_block_t)block {
    dispatch_sync(self.dispatchQueue, block);
}

-(void)execute: (dispatch_block_t)block afterDelaySeconds: (NSTimeInterval) seconds {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(seconds * NSEC_PER_SEC)), dispatch_get_main_queue(), block);
}

-(void)suspend {
    dispatch_suspend(self.dispatchQueue);
}

-(void)resume {
    dispatch_resume(self.dispatchQueue);
}

@end
