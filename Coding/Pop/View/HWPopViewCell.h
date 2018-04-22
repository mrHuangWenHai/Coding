//
//  HWPopViewCell.h
//  Coding
//
//  Created by 黄文海 on 2018/4/11.
//  Copyright © 2018年 huang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Tweet;
typedef void (^CellRefreshBlock)(void);
typedef void(^HandleShowImage)(NSUInteger tweetIndex, NSUInteger imageIndex);

@interface HWPopViewCell : UITableViewCell
@property(nonatomic, strong)Tweet* tweet;
@property(nonatomic, copy)CellRefreshBlock cellRefreshBlock;
@property(nonatomic, copy)HandleShowImage handleShowImage;
@property(nonatomic, assign)NSUInteger index;
@end
