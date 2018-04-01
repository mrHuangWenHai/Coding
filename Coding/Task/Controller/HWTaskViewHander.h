//
//  HWTaskViewHander.h
//  Coding
//
//  Created by 黄文海 on 2018/3/26.
//  Copyright © 2018年 huang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HWTaskModel;
@class Task;

typedef void(^SelectCell)(Task* task);
@interface HWTaskViewHander : UIView
@property(nonatomic, strong)UITableView* tableView;
@property(nonatomic, strong)HWTaskModel* taskModel;
@property(nonatomic, copy)SelectCell selectCell;
@end
