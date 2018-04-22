//
//  HWImageView.h
//  Coding
//
//  Created by 黄文海 on 2018/4/14.
//  Copyright © 2018年 huang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^TapImageView)(void);
@interface HWImageView : UIImageView
@property(nonatomic, copy)TapImageView tap;
@end
