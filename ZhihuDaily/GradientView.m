//
//  GradientView.m
//  ZhihuDaily
//
//  Created by 刘阳 on 15/12/26.
//  Copyright © 2015年 刘阳. All rights reserved.
//

#import "GradientView.h"

@interface GradientView ()

@property (nonatomic) CAGradientLayer* gradientLayer;

@end

@implementation GradientView

-(CAGradientLayer *)gradientLayer {
    if (_gradientLayer == nil) {
        _gradientLayer = [[CAGradientLayer alloc]init];
        _gradientLayer.colors = @[(id)[UIColor clearColor].CGColor, (id)[UIColor colorWithWhite:0.0 alpha:0.75].CGColor];
        _gradientLayer.locations = @[[NSNumber numberWithFloat:0.0], [NSNumber numberWithFloat:1.0]];
    }
    return _gradientLayer;
}

-(instancetype)init {
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame: (CGRect)frame
{
    if ((self = [super initWithFrame:frame])){
        self.backgroundColor = [UIColor clearColor];
        [self.layer addSublayer:self.gradientLayer];
    }
    return self;
}

- (instancetype)initWithCoder: (NSCoder*)aDecoder
{
    if ((self = [super initWithCoder:aDecoder])){
        self.backgroundColor = [UIColor clearColor];
        [self.layer addSublayer:self.gradientLayer];
    }
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    self.gradientLayer.frame = self.bounds;
}


@end
