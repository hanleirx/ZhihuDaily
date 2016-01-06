//
//  TopStoryView.m
//  ZhihuDaily
//
//  Created by 刘阳 on 15/12/27.
//  Copyright © 2015年 刘阳. All rights reserved.
//

#import "TopStoryView.h"
#import "GradientView.h"
#import "UIImageView+Cache.h"

@interface TopStoryView ()

@property (nonatomic, readonly) UIImageView* imageView;
@property (nonatomic, readonly) GradientView* gradientView;
@property (nonatomic, readonly) UILabel* titleLabel;

@end

@implementation TopStoryView

@synthesize imageView = _imageView;
@synthesize gradientView = _gradientView;
@synthesize titleLabel = _titleLabel;

+(UIFont*)defaultFont {
    static UIFont* font = nil;
    @synchronized(self) {
        if (font == nil) {
            font = [UIFont systemFontOfSize:22 weight:UIFontWeightMedium];
        }
    }
    return font;
}

-(void)setStory:(Story *)story {
    if (story == nil) {
        return;
    }
    _story = story;
    [self.imageView setImageFromURL:[[NSURL alloc] initWithString:_story.imageURLString]];
    self.titleLabel.text = _story.title;
}

-(UIImageView *)imageView {
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc]init];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.translatesAutoresizingMaskIntoConstraints = NO;
        _imageView.clipsToBounds = YES;
        self.imageView.image = [UIImage imageNamed:@"default_image"];
    }
    return _imageView;
}

-(GradientView *)gradientView {
    if (_gradientView == nil) {
        _gradientView = [[GradientView alloc]init];
        _gradientView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _gradientView;
}

-(UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.numberOfLines = 0;
        _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _titleLabel.font = [TopStoryView defaultFont];
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

-(instancetype)init {
    if ((self = [super init])) {
        [self setupSubViews];
    }
    return self;
}

-(void)setupSubViews {
    [self addSubview:self.imageView];
    [self addSubview:self.gradientView];
    [self addSubview:self.titleLabel];
    [self setupConstraints];
}

-(void)setupConstraints {
    [self.imageView.leadingAnchor constraintEqualToAnchor: self.leadingAnchor].active = YES;
    [self.imageView.trailingAnchor constraintEqualToAnchor: self.trailingAnchor].active = YES;
    [self.imageView.topAnchor constraintEqualToAnchor: self.topAnchor].active = YES;
    [self.imageView.bottomAnchor constraintEqualToAnchor: self.bottomAnchor].active = YES;
    
    [self.gradientView.leadingAnchor constraintEqualToAnchor: self.imageView.leadingAnchor].active = YES;
    [self.gradientView.trailingAnchor constraintEqualToAnchor: self.imageView.trailingAnchor].active = YES;
    [self.gradientView.topAnchor constraintEqualToAnchor: self.imageView.topAnchor].active = YES;
    [self.gradientView.bottomAnchor constraintEqualToAnchor: self.imageView.bottomAnchor].active = YES;

    [self.titleLabel.leadingAnchor constraintEqualToAnchor:self.gradientView.leadingAnchor constant:20].active = YES;
    [self.titleLabel.trailingAnchor constraintEqualToAnchor:self.gradientView.trailingAnchor constant:-20].active = YES;
    [self.titleLabel.bottomAnchor constraintEqualToAnchor:self.gradientView.bottomAnchor constant:-20].active = YES;
}

@end
