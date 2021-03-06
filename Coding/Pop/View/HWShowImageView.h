//
//  HWShowImageView.h
//  Coding
//
//  Created by 黄文海 on 2018/4/11.
//  Copyright © 2018年 huang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ImageViewFishLoad)(CGFloat height, NSUInteger index);
typedef void(^ShowImageView)(NSUInteger tweetIndex, NSUInteger imageIndex);

@interface HWShowImageView : UIView
@property(nonatomic, copy)NSArray* imageArray;
@property(nonatomic, copy)ImageViewFishLoad imageViewFishLoad;
@property(nonatomic, copy)ShowImageView showImageView;
@property(nonatomic, assign)NSUInteger index;

- (instancetype)initWithCellIndex:(NSUInteger)index;
@end
