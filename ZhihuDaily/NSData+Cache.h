//
//  NSData+Cache.h
//  ZhihuDaily
//
//  Created by 刘阳 on 15/12/28.
//  Copyright © 2015年 刘阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Cache)

-(void)saveDataCacheWithIdentifier:(NSString*)identifier;
+(NSData*)dataCacheWithIdentifier:(NSString*)identifier;
+(void)dataCacheWithIdentifier:(NSString*)identifier completionHandler:(void(^)(NSData* data))completion;

@end
