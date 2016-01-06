//
//  PermanentData.m
//  ZhihuDaily
//
//  Created by 刘阳 on 15/12/25.
//  Copyright © 2015年 刘阳. All rights reserved.
//

#import "PermanentDataManager.h"

@interface PermanentDataManager ()

@property (nonatomic) NSUserDefaults* standardUserDefaults;

@property (nonatomic, readwrite) NSData* launchImageData;
@property (nonatomic, readwrite) NSString* launchCopyright;

@end

@implementation PermanentDataManager

static NSString* launchImageKey = @"launchImage";
static NSString* launchCopyrightKey = @"launchCopyright";

+(instancetype)sharedManager {
    static PermanentDataManager* sharedManager = nil;
    @synchronized(self) {
        if (sharedManager == nil) {
            sharedManager = [[self alloc]init];
        }
    }
    return sharedManager;
}

-(NSUserDefaults*) standardUserDefaults {
    return [NSUserDefaults standardUserDefaults];
}

-(NSData*) launchImageData {
    return [self.standardUserDefaults objectForKey: launchImageKey];
}

-(void) setLaunchImageData:(NSData *)launchImageData {
    if (launchImageData == nil) {
        return;
    }
    [self.standardUserDefaults setObject:launchImageData forKey: launchImageKey];
}

-(NSString *)launchCopyright {
    return [self.standardUserDefaults objectForKey: launchCopyrightKey];
}

-(void)setLaunchCopyright:(NSString *)launchCopyright {
    if (launchCopyrightKey == nil) {
        return;
    }
    [self.standardUserDefaults setObject: launchCopyright forKey: launchCopyrightKey];
}

-(void)setupLaunchDataFromJSONData:(NSData *)data {
    NSError* parseError = nil;
    id object = [NSJSONSerialization JSONObjectWithData: data options: 0 error: &parseError];
    if (parseError) {
        return;
    }
    if ([object isKindOfClass: [NSDictionary class]]) {
        NSDictionary* result = object;
        self.launchCopyright = [result objectForKey: @"text"];
        NSString* imageURLString = [result objectForKey: @"img"];
        NSURL* imageURL = [NSURL URLWithString: imageURLString];
        NSURLSession* session = [NSURLSession sharedSession];
        [[session dataTaskWithURL: imageURL completionHandler:^(NSData* data, NSURLResponse* response, NSError* error) {
            if (data != nil) {
                self.launchImageData = data;
            }
        }] resume];
    }
}

@end
