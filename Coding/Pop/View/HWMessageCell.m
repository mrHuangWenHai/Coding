//
//  HWMessageCell.m
//  Coding
//
//  Created by 黄文海 on 2018/4/15.
//  Copyright © 2018年 huang. All rights reserved.
//

#import "YYText.h"
#import "HWMessageCell.h"
#import "PopHeader.h"
#import "UIView+Frame.h"
#import "Comment.h"
#import "NSDate+Common.h"
#import "UIColor+Expanded.h"
#import "HtmlMedia.h"

@interface HWMessageCell()
@property(nonatomic, strong)UILabel* commentLabel;
@property(nonatomic, strong)YYLabel* statusLabel;
@end

@implementation HWMessageCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    
    self.contentView.backgroundColor = kColorTableSectionBg;
    _commentLabel = [[UILabel alloc] init];
    _commentLabel.textColor = kColorDark4;
    _commentLabel.font = kTweet_CommentFont;
    _commentLabel.numberOfLines = 1;
    _commentLabel.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_commentLabel];

    _statusLabel = [[YYLabel alloc] init];
    _statusLabel.numberOfLines = 1;
    _commentLabel.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_statusLabel];
    
}

- (void)setComment:(Comment *)comment {
    
    _comment = comment;
    HtmlMedia* htmlMedia = [HtmlMedia htmlMediaWithString:_comment.content showType:MediaShowTypeNone];
    self.commentLabel.text = htmlMedia.contentDisplay;
    NSString* name = [NSString stringWithFormat:@"%@    ",_comment.owner.name];
    NSMutableAttributedString* atr = [[NSMutableAttributedString alloc] initWithString:name];
    [atr yy_setFont:[UIFont systemFontOfSize:12] range:NSMakeRange(0, atr.length)];
    [atr yy_setColor:kColorDark7 range:NSMakeRange(0, atr.length)];
    
    UIImage* image = [UIImage imageNamed:@"time_clock_icon"];
    image = [UIImage imageWithCGImage:image.CGImage scale:2 orientation:UIImageOrientationUp];
    NSMutableAttributedString *attachText = [NSMutableAttributedString
                                             yy_attachmentStringWithContent:image
                                             contentMode:UIViewContentModeCenter
                                             attachmentSize:image.size
                                             alignToFont:[UIFont systemFontOfSize:10]
                                             alignment:YYTextVerticalAlignmentCenter];
    NSAttributedString* imageAtr = [[NSAttributedString alloc] initWithAttributedString:attachText];
    [atr appendAttributedString:imageAtr];
    
    NSTimeInterval time = (double)_comment.created_at / 1000;
    NSDate *createAtTime=[NSDate dateWithTimeIntervalSince1970:time];
    NSString* timeString = [NSString stringWithFormat:@"  %@",[createAtTime stringDisplay_HHmm]];
    NSMutableAttributedString* timeAtr = [[NSMutableAttributedString alloc] initWithString:timeString];
    [timeAtr yy_setColor:kColorDark7 range:NSMakeRange(0, timeAtr.length)];
    [atr appendAttributedString:timeAtr];
    self.statusLabel.attributedText = atr;
}

- (void)layoutSubviews {
    
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = CGRectGetHeight(self.frame);
    self.commentLabel.frame = CGRectMake(5, 0, width - 5, height / 2 + 5);
    self.statusLabel.frame = CGRectMake(5, self.commentLabel.getY, width - 5, height / 2 - 10);

}

@end
