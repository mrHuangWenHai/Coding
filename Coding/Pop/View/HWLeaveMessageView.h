//
//  HWLeaveMessageView.h
//  Coding
//
//  Created by 黄文海 on 2018/4/11.
//  Copyright © 2018年 huang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Tweet;
typedef void(^MessageHandleBlock)(void);

@interface HWLeaveMessageView : UIView
@property(nonatomic, copy)NSArray* likeUsrArray;
@property(nonatomic, strong)Tweet* tweet;
@property(nonatomic, copy)MessageHandleBlock messageHandleBlock;
@end
