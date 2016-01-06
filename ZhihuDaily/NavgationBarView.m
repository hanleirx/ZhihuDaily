//
//  NavgationBarView.m
//  ZhihuDaily
//
//  Created by 刘阳 on 15/12/29.
//  Copyright © 2015年 刘阳. All rights reserved.
//

#import "NavgationBarView.h"

@interface NavgationBarView ()

@property (nonatomic, readonly) UILabel* titleLabel;

@end

@implementation NavgationBarView

@synthesize titleLabel = _titleLabel;

+(UIFont*)defaultFont {
    static UIFont* font = nil;
    @synchronized(self) {
        if (font == nil) {
            font = [UIFont systemFontOfSize:20 weight:UIFontWeightMedium];
        }
    }
    return font;
}

-(void)setTitle:(NSString *)title {
    if (title == nil) {
        return;
    }
    _title = title;
    self.titleLabel.text = _title;
}

-(UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.numberOfLines = 1;
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [NavgationBarView defaultFont];
    }
    return _titleLabel;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])){
        [self setupSubViews];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder*)aDecoder
{
    if ((self = [super initWithCoder:aDecoder])){
        [self setupSubViews];
    }
    return self;
}

-(void)setupSubViews {
    [self addSubview:self.titleLabel];
    [self setupConstraints];
}

-(void)setupConstraints {
    [self.titleLabel.centerYAnchor constraintEqualToAnchor:self.centerYAnchor].active = YES;
    [self.titleLabel.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
}
@end
