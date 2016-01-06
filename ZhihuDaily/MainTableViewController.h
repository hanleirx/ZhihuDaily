//
//  MainTableViewController.h
//  ZhihuDaily
//
//  Created by 刘阳 on 15/12/26.
//  Copyright © 2015年 刘阳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CyclePagingScrollViewController.h"

@interface MainTableViewController : UITableViewController <CyclePagingScrollViewDataSource>

-(void)retrieveDataFromServer: (void (^)(void)) completion;

@end
