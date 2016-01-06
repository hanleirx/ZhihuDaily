//
//  DailyStoryHeaderViewCell.m
//  ZhihuDaily
//
//  Created by 刘阳 on 15/12/29.
//  Copyright © 2015年 刘阳. All rights reserved.
//

#import "DailyStoryHeaderViewCell.h"

@interface DailyStoryHeaderViewCell ()

@property (nonatomic, readonly) UILabel* titleLabel;

@end

@implementation DailyStoryHeaderViewCell

@synthesize titleLabel = _titleLabel;

+(NSDateFormatter *)formatter {
    static NSDateFormatter* formatter = nil;
    @synchronized(self) {
        if (formatter == nil) {
            formatter = [[NSDateFormatter alloc]init];
            formatter.dateFormat = @"MM 月 dd 日 EEEE";
        }
    }
    return formatter;
}

-(void)setDate:(NSDate *)date {
    if (date == nil) {
        return;
    }
    _date = date;
    self.titleLabel.text = [[DailyStoryHeaderViewCell formatter]stringFromDate:_date];
}

-(UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.numberOfLines = 1;
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
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

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        [self setupSubViews];
    }
    return self;
}

-(void)setupSubViews {
    [self.contentView addSubview:self.titleLabel];
    [self setupConstraints];
}

-(void)setupConstraints {
    [self.titleLabel.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor].active = YES;
    [self.titleLabel.centerXAnchor constraintEqualToAnchor:self.contentView.centerXAnchor].active = YES;
}

@end
