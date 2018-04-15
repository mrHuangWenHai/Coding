//
//  HWShowImageView.m
//  Coding
//
//  Created by 黄文海 on 2018/4/11.
//  Copyright © 2018年 huang. All rights reserved.
//

#import "HWShowImageView.h"
#import "HtmlMedia.h"
#import "Tweet.h"
#import <SDWebImage/UIImageView+WebCache.h>

#define singleImageWidth  [UIScreen mainScreen].bounds.size.width / 2 + 10

@interface HWShowImageView ()
@property(nonatomic, copy)NSArray* imageViewArray;
@end

@implementation HWShowImageView

- (instancetype)initWithCellIndex:(NSUInteger)index {
    self = [super init];
    if (self) {
        _index = index;
    }
    return self;
}

- (void)setImageArray:(NSArray *)imageArray{
    
    _imageArray = imageArray;
    __block NSMutableArray* imageViewArray = [NSMutableArray new];
    __weak typeof(self) weakself = self;
    if (_imageArray.count == 1) {
        HtmlMediaItem* htmlMediaItem = [_imageArray firstObject];
        UIImageView* imageView = [[UIImageView alloc] init];
        NSUInteger index = weakself.index;
        [imageView sd_setImageWithURL:[NSURL URLWithString:htmlMediaItem.src]
                     placeholderImage:[UIImage imageNamed:@"placeholder_coding_square_150"]
                            completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                                if (!error) {
                                    CGFloat height = image.size.height / image.size.width * singleImageWidth;
                                    weakself.imageViewFishLoad(height,index);
                                }
        }];
        
        [imageViewArray addObject:imageView];
        [self addSubview:imageView];
    } else {
        
        [_imageArray enumerateObjectsUsingBlock:^(HtmlMediaItem* htmlMediaItem, NSUInteger idx, BOOL * _Nonnull stop) {
            UIImageView* imageView = NULL;
            imageView = [[UIImageView alloc] init];
            
            [imageView sd_setImageWithURL:[NSURL URLWithString:htmlMediaItem.src]
                         placeholderImage:[UIImage imageNamed:@"placeholder_coding_square_80"]
                                completed:nil];
            [imageViewArray addObject:imageView];
            [weakself addSubview:imageView];
        }];
    }
    [self.imageViewArray enumerateObjectsUsingBlock:^(UIImageView* imageView, NSUInteger idx, BOOL * _Nonnull stop) {
        [imageView removeFromSuperview];
    }];
    self.imageViewArray = imageViewArray;
}

- (void)layoutSubviews {
    
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = CGRectGetHeight(self.frame);
    NSUInteger count = _imageArray.count;
    NSUInteger lineCount = (count == 4 ? 2 : 3);
    CGFloat imageWidth = (count == 1 ? singleImageWidth : (width - 10) / 3);
    CGFloat imageHeight = (count == 1 ? height : imageWidth);
  //  __weak typeof(self) weakself = self;
    [_imageViewArray enumerateObjectsUsingBlock:^(UIImageView* imageView, NSUInteger idx, BOOL * _Nonnull stop) {
        CGRect frame;
        frame.origin.x = imageWidth * (idx % lineCount) + 5 * (idx % lineCount);
        frame.origin.y = imageHeight * (idx / lineCount) + 5 * (idx / lineCount);
        frame.size = CGSizeMake(imageWidth, imageHeight);
        imageView.frame = frame;
    }];
}


@end
