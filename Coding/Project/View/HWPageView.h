//
//  HWPageView.h
//  Coding
//
//  Created by 黄文海 on 2018/6/1.
//  Copyright © 2018年 huang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HWPageStyle)
{
    StaticStyle,
    RollStyle,
};

@interface HWPageView : UIView
@property(nonatomic, assign)HWPageStyle style;
@property(nonatomic, strong)NSArray* titleArray;

- (instancetype)initWith:(NSArray*)titleArray and:(HWPageStyle)style;

- (void)hideTopAndBottomLayer;

@end
