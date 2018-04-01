//
//  HWSegmentHander.h
//  Coding
//
//  Created by 黄文海 on 2018/3/21.
//  Copyright © 2018年 huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class HWProjectModel;

typedef void(^ProjectHander)(HWProjectModel* projectModel);

@interface HWSegmentHander : UIView
@property(nonatomic, copy)ProjectHander projectHander;
- (void)reloadSegmentData;
@end
