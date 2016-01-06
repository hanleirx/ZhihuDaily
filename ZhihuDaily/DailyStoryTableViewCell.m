//
//  DailyStoryTableViewCell.m
//  ZhihuDaily
//
//  Created by 刘阳 on 15/12/28.
//  Copyright © 2015年 刘阳. All rights reserved.
//

#import "DailyStoryTableViewCell.h"
#import "UIImageView+Cache.h"

@interface DailyStoryTableViewCell ()

@property (nonatomic, readonly) UILabel* titleLabel;
@property (nonatomic, readonly) UIImageView* storyImageView;
@property (nonatomic, readonly) UIImageView* multiPicturesImageView;

@end

@implementation DailyStoryTableViewCell

@synthesize titleLabel = _titleLabel;
@synthesize storyImageView = _storyImageView;
@synthesize multiPicturesImageView = _multiPicturesImageView;

+(UIFont*)defaultFont {
    static UIFont* font = nil;
    @synchronized(self) {
        if (font == nil) {
            font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
        }
    }
    return font;
}

-(void)setStory:(Story *)story {
    if (story == nil) {
        return;
    }
    _story = story;
    self.storyImageView.image = nil;
    [self.storyImageView setImageFromURL:[[NSURL alloc] initWithString:_story.imageURLString] completionHandler:nil];
    self.titleLabel.text = _story.title;
    if (_story.multiPictures) {
        self.multiPicturesImageView.hidden = NO;
    }
}

-(UIImageView *)storyImageView {
    if (_storyImageView == nil) {
        _storyImageView = [[UIImageView alloc]init];
        _storyImageView.contentMode = UIViewContentModeScaleAspectFill;
        _storyImageView.translatesAutoresizingMaskIntoConstraints = NO;
        _storyImageView.clipsToBounds = YES;
    }
    return _storyImageView;
}

-(UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.numberOfLines = 0;
        _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _titleLabel.font = [DailyStoryTableViewCell defaultFont];
        _titleLabel.textColor = [UIColor darkTextColor];
    }
    return _titleLabel;
}

-(UIImageView *)multiPicturesImageView {
    if (_multiPicturesImageView == nil) {
        _multiPicturesImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"multi_pictures"]];
        _multiPicturesImageView.contentMode = UIViewContentModeScaleAspectFit;
        _multiPicturesImageView.translatesAutoresizingMaskIntoConstraints = NO;
        _multiPicturesImageView.hidden = YES;
    }
    return _multiPicturesImageView;
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

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        [self setupSubViews];
    }
    return self;
}

-(void)setupSubViews {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self addSubview:self.storyImageView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.multiPicturesImageView];
    [self setupConstraints];
}

-(void)setupConstraints {
    [self.storyImageView.trailingAnchor constraintEqualToAnchor: self.trailingAnchor constant:-15.0].active = YES;
    [self.storyImageView.topAnchor constraintEqualToAnchor: self.topAnchor constant:15.0].active = YES;
    [self.storyImageView.bottomAnchor constraintLessThanOrEqualToAnchor: self.bottomAnchor constant:-15.0].active = YES;
    
    [NSLayoutConstraint constraintWithItem:self.storyImageView
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:60].active = YES;
    
    [NSLayoutConstraint constraintWithItem:self.storyImageView
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.storyImageView
                                 attribute:NSLayoutAttributeHeight
                                multiplier:4.0f/3.0f
                                  constant:0.0f].active = YES;
    
    [self.titleLabel.topAnchor constraintEqualToAnchor:self.topAnchor constant:15.0].active = YES;
    [self.titleLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:15.0].active = YES;
    [self.titleLabel.trailingAnchor constraintEqualToAnchor:self.storyImageView.leadingAnchor constant:-15.0].active = YES;
    [self.titleLabel.bottomAnchor constraintLessThanOrEqualToAnchor: self.bottomAnchor constant:-15.0].active = YES;
    
    [self.multiPicturesImageView.bottomAnchor constraintEqualToAnchor:self.storyImageView.bottomAnchor].active = YES;
    [self.multiPicturesImageView.trailingAnchor constraintEqualToAnchor:self.storyImageView.trailingAnchor].active = YES;
}

-(void)prepareForReuse {
    [super prepareForReuse];
    self.storyImageView.image = nil;
}

@end
