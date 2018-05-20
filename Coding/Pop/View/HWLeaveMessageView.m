//
//  HWLeaveMessageView.m
//  Coding
//
//  Created by 黄文海 on 2018/4/11.
//  Copyright © 2018年 huang. All rights reserved.
//

#import "HWLeaveMessageView.h"
#import "YYText.h"
#import "PopHeader.h"
#import "Tweet.h"
#import "HWTweetLikeUserCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIView+Frame.h"
#import "UIButton+Common.h"
#import "HWMessageCell.h"

const CGFloat likeImageWidth = 25;


@interface HWLeaveMessageView()<UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong)UIButton* locationButton;
@property(nonatomic, strong)YYLabel* deviceLabel;
@property(nonatomic, strong)UIButton* likeButton;
@property(nonatomic, strong)UIButton* rewardButton;
@property(nonatomic, strong)UIButton* messageButton;
@property(nonatomic, strong)UIButton* deleteButton;
@property(nonatomic, strong)UIImageView* divisionImageView;
@property(nonatomic, strong)UICollectionView* likeUserCollectionView;
@property(nonatomic, strong)UITableView* messageTableView;
@end

@implementation HWLeaveMessageView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    
    _locationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _locationButton.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    _locationButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _locationButton.titleLabel.adjustsFontSizeToFitWidth = NO;
    _locationButton.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    [_locationButton setTitleColor:kColorBrandBlue forState:UIControlStateNormal];
    
    _deviceLabel = [[YYLabel alloc] init];
    _deviceLabel.textAlignment = NSTextAlignmentLeft;
    
    _likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _rewardButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _messageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_messageButton setImage:[UIImage imageNamed:@"tweet_btn_comment"] forState:UIControlStateNormal];
    [_messageButton addTarget:self action:@selector(messageButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_deleteButton setTitle:@"删除" forState:UIControlStateNormal];
    [_deleteButton setTitleColor:kColorBrandBlue forState:UIControlStateNormal];
    _deleteButton.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    _divisionImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"commentOrLikeBeginImg"]];
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 0);
    layout.itemSize = CGSizeMake(likeImageWidth, likeImageWidth);
    layout.minimumLineSpacing = 5;
    _likeUserCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:layout];
    [_likeUserCollectionView setBackgroundColor:kColorTableSectionBg];
    [_likeUserCollectionView registerClass:[HWTweetLikeUserCell class] forCellWithReuseIdentifier:@"likeCell"];
    _likeUserCollectionView.delegate = self;
    _likeUserCollectionView.dataSource = self;
    
    _messageTableView = [[UITableView alloc] init];
    _messageTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _messageTableView.separatorColor = [UIColor colorWithRed:231/250.0 green:234/250.0 blue:237/255.0 alpha:1];
    _messageTableView.backgroundColor = kColorTableSectionBg;
    [_messageTableView registerClass:[HWMessageCell class] forCellReuseIdentifier:@"messageCell"];
    [_messageTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"loadMoreCell"];
    _messageTableView.dataSource = self;
    _messageTableView.delegate = self;
    
    [self addSubview:_locationButton];
    [self addSubview:_deviceLabel];
    [self addSubview:_likeButton];
    [self addSubview:_rewardButton];
    [self addSubview:_messageButton];
    [self addSubview:_deleteButton];
    [self addSubview:_divisionImageView];
    [self addSubview:_likeUserCollectionView];
    [self addSubview:_messageTableView];

}

- (void)setTweet:(Tweet *)tweet {
    _tweet = tweet;
    [self.locationButton setTitle:_tweet.location forState:UIControlStateNormal];
    
    if (_tweet.device.length != 0) {
        
        UIImage* phone = [UIImage imageNamed:@"little_phone_icon"];
        phone = [UIImage imageWithCGImage:phone.CGImage scale:2 orientation:UIImageOrientationUp];
        
        NSMutableAttributedString *attachText = [NSMutableAttributedString
                                                 yy_attachmentStringWithContent:phone
                                                 contentMode:UIViewContentModeCenter
                                                 attachmentSize:phone.size
                                                 alignToFont:kTweet_TimtFont
                                                 alignment:YYTextVerticalAlignmentCenter];
        
        NSMutableAttributedString* attr = [[NSMutableAttributedString alloc] initWithAttributedString:attachText];
        NSString* deviceString = [NSString stringWithFormat:@"  来自 %@",_tweet.device];
        NSMutableAttributedString* device = [[NSMutableAttributedString alloc] initWithString:deviceString];
        [device yy_setColor:kColorDark7 range:NSMakeRange(0, device.length)];
        [attr appendAttributedString:device];
        self.deviceLabel.attributedText = attr;
        
    } else {
        self.deviceLabel.attributedText = [[NSMutableAttributedString alloc] initWithString:@""];
    }
    
    [self.likeButton setTitle:[NSString stringWithFormat:@"%ld",(long)_tweet.likes] forState:UIControlStateNormal];
    UIImage* likeImage = _tweet.liked ? [UIImage imageNamed:@"tweet_btn_liked"] : [UIImage imageNamed:@"tweet_btn_like"];
    [self.likeButton setImage:likeImage forState:UIControlStateNormal];
    
    [self.rewardButton setTitle:[NSString stringWithFormat:@"%ld",(long)_tweet.rewards] forState:UIControlStateNormal];
    UIImage* rewardImage = _tweet.rewarded ? [UIImage imageNamed:@"tweet_btn_rewarded"] : [UIImage imageNamed:@"tweet_btn_reward"];
    [self.rewardButton setImage:rewardImage forState:UIControlStateNormal];
    
    [self.messageButton setTitle:[NSString stringWithFormat:@"%ld",(long)_tweet.comments] forState:UIControlStateNormal];
    [self.likeUserCollectionView reloadData];
    [self.messageTableView reloadData];

}

- (void)layoutSubviews {
    
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat locationHeight = 20;
    CGFloat deviceHeight = 20;
    CGFloat topSpare;
    CGFloat likeWidth = 50;
    CGFloat likeHeight = 27;
    if (self.tweet.location.length == 0) {
        self.locationButton.frame = CGRectMake(0, 0, 0, 0);
        topSpare = 0;
    } else {
        self.locationButton.frame = CGRectMake(0, 0, width, locationHeight);
        topSpare = 5;
    }
    
    if (self.tweet.device.length == 0) {
        self.deviceLabel.frame = CGRectMake(0, self.locationButton.getY, 0, 0);
    } else {
        self.deviceLabel.frame = CGRectMake(0, self.locationButton.getY + topSpare, width, deviceHeight);
    }
    
    CGFloat top = 20;
    self.likeButton.frame = CGRectMake(0, self.deviceLabel.getY + top, likeWidth, likeHeight);
    [self.likeButton tweetBtnAlignmentLeft:true];
    self.rewardButton.frame = CGRectMake(self.likeButton.getX + 10, self.deviceLabel.getY + top, likeWidth, likeHeight);
    [self.rewardButton tweetBtnAlignmentLeft:true];
    self.messageButton.frame = CGRectMake(width - likeWidth, self.deviceLabel.getY + top, likeWidth, likeHeight);
    
    [self.messageButton tweetBtnAlignmentLeft:true];
    self.deleteButton.frame = CGRectMake(self.messageButton.getX - likeWidth * 2 - 10 , self.deviceLabel.getY + top, likeWidth, likeHeight);
    if (_tweet.like_users.count > 0 ){
        self.divisionImageView.frame = CGRectMake(35, self.likeButton.getY + 5, 15, 7);
        self.likeUserCollectionView.frame = CGRectMake(0, self.divisionImageView.getY, width, 35);
    } else {
        self.divisionImageView.frame = CGRectMake(35, self.likeButton.getY, 0, 0);
        self.likeUserCollectionView.frame = CGRectMake(0, self.divisionImageView.getY, width, 0);
    }
    
    if (_tweet.comment_list.count > 0) {
        self.messageTableView.frame = CGRectMake(0, self.likeUserCollectionView.getY, width, _tweet.contentMessageHeight);
    } else {
        self.messageTableView.frame = CGRectMake(0, self.likeUserCollectionView.getY, width, 0);
    }
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.tweet.like_users.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HWTweetLikeUserCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"likeCell" forIndexPath:indexPath];
    [cell configWithUser:self.tweet.like_users[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row <= 4) {
        return 50;
    } else {
        return 30;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweet.comments > 5 ? 6 : self.tweet.comment_list.count;
}

- (void)messageButtonClick {
    self.messageHandleBlock();
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell* cell;
    if (indexPath.row <= 4) {
        HWMessageCell* commentCell = [tableView dequeueReusableCellWithIdentifier:@"messageCell"];
        commentCell.comment = self.tweet.comment_list[indexPath.row];
        cell = commentCell;
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"loadMoreCell"];
        cell.imageView.image = [UIImage imageNamed:@"tweet_more_comment_icon"];
        cell.textLabel.text = [NSString stringWithFormat:@"查看全部%lu条评论",(unsigned long)self.tweet.comments];
        cell.textLabel.font = kTweet_CommentFont;
        cell.textLabel.textColor = kColorDark4;
        cell.backgroundColor = kColorTableSectionBg;
    }
    return cell;
}


@end
