//
//  LaunchScreenView.m
//  ZhihuDaily
//
//  Created by 刘阳 on 15/12/25.
//  Copyright © 2015年 刘阳. All rights reserved.
//

#import "LaunchScreenView.h"
#import "PermanentDataManager.h"
#import "GradientView.h"

@interface LaunchScreenView ()

@property (nonatomic, readonly) UIImageView* launchImageView;
@property (nonatomic, readonly) UIImageView* logoImageView;
@property (nonatomic, readonly) GradientView* gradientView;
@property (nonatomic, readonly) UILabel* copyrightLabel;

@end

@implementation LaunchScreenView

@synthesize launchImageView = _launchImageView;
@synthesize logoImageView = _logoImageView;
@synthesize gradientView = _gradientView;
@synthesize copyrightLabel = _copyrightLabel;

+(UIFont*)defaultFont {
    static UIFont* font = nil;
    @synchronized(self) {
        if (font == nil) {
            font = [UIFont systemFontOfSize:10 weight:UIFontWeightMedium];
        }
    }
    return font;
}

-(UIImageView*)launchImageView {
    if (_launchImageView == nil) {
        NSData* imageData = [[PermanentDataManager sharedManager] launchImageData];
        UIImage* image = [[UIImage alloc]initWithData: imageData];
        _launchImageView = [[UIImageView alloc]initWithImage: image];
        _launchImageView.contentMode = UIViewContentModeScaleAspectFit;
        _launchImageView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _launchImageView;
}

-(UIImageView*)logoImageView {
    if (_logoImageView == nil) {
        UIImage* logoImage = [UIImage imageNamed:@"launch_screen_logo"];
        _logoImageView = [[UIImageView alloc] initWithImage: logoImage];
        _logoImageView.contentMode = UIViewContentModeScaleAspectFit;
        _logoImageView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _logoImageView;
}

-(GradientView *)gradientView {
    if (_gradientView == nil) {
        _gradientView = [[GradientView alloc]init];
        _gradientView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _gradientView;
}

-(UILabel *)copyrightLabel {
    if (_copyrightLabel == nil) {
        _copyrightLabel = [[UILabel alloc]init];
        _copyrightLabel.numberOfLines = 1;
        _copyrightLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _copyrightLabel.font = [LaunchScreenView defaultFont];
        _copyrightLabel.textColor = [UIColor lightTextColor];
        _copyrightLabel.text = [PermanentDataManager sharedManager].launchCopyright;
        _copyrightLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _copyrightLabel;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])){
        self.backgroundColor = [UIColor darkGrayColor];
        [self setupSubViews];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder*)aDecoder
{
    if ((self = [super initWithCoder:aDecoder])){
        self.backgroundColor = [UIColor darkGrayColor];
        [self setupSubViews];
    }
    return self;
}

- (void) setupSubViews
{
    [self addSubview:self.launchImageView];
    [self addSubview:self.gradientView];
    [self addSubview:self.logoImageView];
    [self addSubview:self.copyrightLabel];
    [self setupConstraints];
    [self setupScaleAnimation];
}

-(void)setupConstraints {
    [self.launchImageView.leadingAnchor constraintEqualToAnchor: self.leadingAnchor].active = YES;
    [self.launchImageView.trailingAnchor constraintEqualToAnchor: self.trailingAnchor].active = YES;
    [self.launchImageView.topAnchor constraintEqualToAnchor: self.topAnchor].active = YES;
    [self.launchImageView.bottomAnchor constraintEqualToAnchor: self.bottomAnchor].active = YES;
    
    [self.gradientView.leadingAnchor constraintEqualToAnchor: self.launchImageView.leadingAnchor].active = YES;
    [self.gradientView.trailingAnchor constraintEqualToAnchor: self.launchImageView.trailingAnchor].active = YES;
    [self.gradientView.topAnchor constraintEqualToAnchor: self.launchImageView.topAnchor].active = YES;
    [self.gradientView.bottomAnchor constraintEqualToAnchor: self.launchImageView.bottomAnchor].active = YES;
    
    [self.logoImageView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor].active = YES;
    [self.logoImageView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor].active = YES;
    [self.logoImageView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-30.0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.logoImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40].active = YES;
    
    [self.copyrightLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor].active = YES;
    [self.copyrightLabel.trailingAnchor constraintEqualToAnchor:self.trailingAnchor].active = YES;
    [self.copyrightLabel.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-10.0].active = YES;
}

-(void)setupScaleAnimation {
    [UIView animateWithDuration:15.0 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.launchImageView.transform = CGAffineTransformMakeScale(1.6, 1.6);
    } completion:nil];
}

@end
