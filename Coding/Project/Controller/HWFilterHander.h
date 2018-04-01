//
//  HWFilterHander.h
//  Coding
//
//  Created by 黄文海 on 2018/3/19.
//  Copyright © 2018年 huang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HWProjectModel;
@class HWCodingProjectViewController;

@interface HWFilterHander : NSObject
@property(nonatomic, strong)HWProjectModel* projectModel;
@property(nonatomic, weak)HWCodingProjectViewController* projectController;
- (void)showMoreSelect;
@end
