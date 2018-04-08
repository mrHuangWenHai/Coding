//
//  HWSwipeBetweenViewControllers.h
//  Coding
//
//  Created by 黄文海 on 2018/4/7.
//  Copyright © 2018年 huang. All rights reserved.
//

#import "HWCodingNavigationController.h"

@interface HWSwipeBetweenViewControllers : HWCodingNavigationController

@property(nonatomic, copy)NSArray* viewControllerArray;
@property(nonatomic, strong)UIPageViewController* pageViewController;
@property(nonatomic, copy)NSArray* buttonTitleArray;
+ (instancetype)newHWSwipeBetweenViewControllers;

@end
