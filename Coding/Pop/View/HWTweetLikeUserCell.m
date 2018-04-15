//
//  HWTweetLikeUserCell.m
//  Coding
//
//  Created by 黄文海 on 2018/4/14.
//  Copyright © 2018年 huang. All rights reserved.
//

#import "HWTweetLikeUserCell.h"
#import "Tweet.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIImageView+Expanded.h"

@interface HWTweetLikeUserCell()
@property(nonatomic, strong)UIImageView* headImageView;
@end

@implementation HWTweetLikeUserCell

- (void)configWithUser:(User *)user {
    
    if (!self.headImageView) {
        self.headImageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
        [self.contentView addSubview:self.headImageView];
    }
  //  [self.headImageView sd_setImageWithURL:[NSURL URLWithString:user.avatar]];
    __weak typeof(self) weakself = self;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:user.avatar] placeholderImage:[UIImage imageNamed:@"placeholder_coding_square_80"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        [weakself.headImageView setCornerRadius];
    }];
   
}

@end
