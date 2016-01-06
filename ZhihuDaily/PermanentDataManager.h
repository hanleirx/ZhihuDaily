//
//  PermanentData.h
//  ZhihuDaily
//
//  Created by 刘阳 on 15/12/25.
//  Copyright © 2015年 刘阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PermanentDataManager : NSObject

+(instancetype) sharedManager;

@property (nonatomic, readonly) NSData* launchImageData;
@property (nonatomic, readonly) NSString* launchCopyright;

-(void) setupLaunchDataFromJSONData:(NSData*) data;

@end
