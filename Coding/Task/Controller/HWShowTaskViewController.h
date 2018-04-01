//
//  HWShowTaskViewController.h
//  Coding
//
//  Created by 黄文海 on 2018/3/30.
//  Copyright © 2018年 huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HWTaskModel.h"

@class HWProjectModel;
@interface HWShowTaskViewController : UIViewController
@property(nonatomic, strong)HWProjectModel* projectModel;
@property(nonatomic, strong)Task* task;
- (instancetype)initWithType:(TaskStatus)status;
@end
