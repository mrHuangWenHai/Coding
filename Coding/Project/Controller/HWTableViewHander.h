//
//  HWTableViewHander.h
//  Coding
//
//  Created by 黄文海 on 2018/3/14.
//  Copyright © 2018年 huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HWCodingProjectViewController.h"
#import "HWProjectModel.h"

@protocol ProjectCellDelegate<NSObject>

@optional
- (void)didSelectPerojectCellWithProject:(Project*)project;
@end

@interface HWTableViewHander : NSObject
@property(nonatomic, strong)UITableView* projectTableView;
@property(nonatomic, weak)id<ProjectCellDelegate> delegate;
@property(nonatomic, strong)HWProjectModel* projectModel;


- (instancetype)initWithHander:(HWCodingProjectViewController*)projectController;
- (void)setupData;
- (void)setupTableViewWithFrame:(CGRect)frame;

@end
