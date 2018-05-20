//
//  HWPopViewCell.m
//  Coding
//
//  Created by 黄文海 on 2018/4/11.
//  Copyright © 2018年 huang. All rights reserved.
//

#import "HWPopViewCell.h"
#import "YYText.h"
#import "UIView+Frame.h"
#import "UIImageView+Expanded.h"
#import "HWShowImageView.h"
#import "HWLeaveMessageView.h"
#import "Tweet.h"
#import "NSDate+Common.h"
#import "UIColor+Expanded.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "PopHeader.h"

@interface HWPopViewCell()
@property(nonatomic, strong)UIImageView* headImageView;
@property(nonatomic, strong)UILabel* userNameLabel;
@property(nonatomic, strong)UILabel* timeLabel;
@property(nonatomic, strong)YYLabel* contentLabel;
@property(nonatomic, strong)HWShowImageView* showImageView;
@property(nonatomic, strong)HWLeaveMessageView* leaveMessageView;
@property(nonatomic, strong)CALayer* topLayer;
@end

@implementation HWPopViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpSubViews];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setUpSubViews {
    
    _topLayer = [[CALayer alloc] init];
    _topLayer.backgroundColor = kColorTableSectionBg.CGColor;
    [self.contentView.layer addSublayer:_topLayer];
    _headImageView = [[UIImageView alloc] init];
    _userNameLabel = [[UILabel alloc] init];
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.font = [UIFont systemFontOfSize:12];
    _timeLabel.textColor = [UIColor colorWithHexString:@"0x76808E"];
    _contentLabel = [[YYLabel alloc] init];
    _contentLabel.numberOfLines = 0;
    _contentLabel.font = kTweet_ContentFont;
    _contentLabel.textColor = [UIColor colorWithHexString:@"0x323A45"];
    
    _showImageView = [[HWShowImageView alloc] initWithCellIndex:(NSUInteger) index];
    __weak typeof(self) weakSelf = self;
    _showImageView.showImageView = ^(NSUInteger tweetIndex, NSUInteger imageIndex) {
        weakSelf.handleShowImage(tweetIndex, imageIndex);
    };
    __weak typeof(self) weakself = self;
    _showImageView.imageViewFishLoad = ^(CGFloat height,NSUInteger index) {
        if (weakself.index != index) return;
        weakself.tweet.isFinshImageLoad = true;
        weakself.tweet.imageHeight = height;
        weakself.cellRefreshBlock();
    };
    _leaveMessageView = [[HWLeaveMessageView alloc] init];
    _leaveMessageView.messageHandleBlock = ^{
        weakSelf.handleMessage();
    };
    
    [self.contentView addSubview:_headImageView];
    [self.contentView addSubview:_userNameLabel];
    [self.contentView addSubview:_timeLabel];
    [self.contentView addSubview:_contentLabel];
    [self.contentView addSubview:_showImageView];
    [self.contentView addSubview:_leaveMessageView];
}

- (void)setIndex:(NSUInteger)index {
    _index = index;
    self.showImageView.index = _index;
}

- (void)setTweet:(Tweet *)tweet {
    _tweet = tweet;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:_tweet.owner.avatar]];
    self.userNameLabel.text = _tweet.owner.name;
    NSTimeInterval time = (double)tweet.created_at / 1000;
    NSDate *createAtTime=[NSDate dateWithTimeIntervalSince1970:time];
    self.timeLabel.text = [createAtTime stringDisplay_HHmm];
    self.contentLabel.attributedText = [[NSAttributedString alloc] initWithString:_tweet.content];
    self.showImageView.imageArray = _tweet.htmlMedia.imageItems;
    self.leaveMessageView.tweet = _tweet;
}

- (void)layoutSubviews {
    
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat leftSpare = [Tweet getDefaultLeftSpare];
    CGFloat topSpare = 10;
    CGFloat headHeight = 40;
    CGFloat headWidth = 40;
    CGFloat spare = 8;
    self.topLayer.frame = CGRectMake(0, 0, width, 20);
    self.headImageView.frame = CGRectMake(leftSpare, topSpare + 20, headWidth, headHeight);
    [self.headImageView setCornerRadius];
    self.userNameLabel.frame = CGRectMake(self.headImageView.getX + spare, topSpare + 20, width - self.headImageView.getX + spare , 25);
    self.timeLabel.frame = CGRectMake(self.headImageView.getX + spare , self.userNameLabel.getY + 5, width - self.headImageView.getX + spare, 10);
    
    //10+40+10+10 + 70=140
    CGFloat textTopSpare = 10;
    if (_tweet.content.length > 0) {
        self.contentLabel.frame = CGRectMake(leftSpare, self.headImageView.getY + textTopSpare, width - 2*leftSpare, self.tweet.textHeight);
    } else {
        self.contentLabel.frame = CGRectMake(leftSpare, self.headImageView.getY, 0, 0);
    }
    
    CGFloat imageTopSpare = 10;
    if (_tweet.htmlMedia.imageItems.count > 0) {
        self.showImageView.frame = CGRectMake(leftSpare, self.contentLabel.getY + imageTopSpare, width - 2*leftSpare, self.tweet.imageHeight);
    } else {
        self.showImageView.frame = CGRectMake(leftSpare, self.contentLabel.getY, 0, 0);
    }
    
    CGFloat leaveMessageTopSpare = 10;
    self.leaveMessageView.frame = CGRectMake(leftSpare, self.showImageView.getY + leaveMessageTopSpare, width - 2*leftSpare, _tweet.leaveMessageHeight);

}

@end
