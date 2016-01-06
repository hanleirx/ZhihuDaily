//
//  ToolBarItemsArray.h
//  ZhihuDaily
//
//  Created by 刘阳 on 16/1/6.
//  Copyright © 2016年 刘阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ToolBarItemsArrayDelegate <NSObject>

-(void)backToMainPageButtonWasPressed;
-(void)nextDetailPageButtonWasPressed;
-(void)commentsButtonWasPressed;

@end

@interface ToolBarItemsArray : NSObject


@end
