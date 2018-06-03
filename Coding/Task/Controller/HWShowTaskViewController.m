//
//  HWShowTaskViewController.m
//  Coding
//
//  Created by 黄文海 on 2018/3/30.
//  Copyright © 2018年 huang. All rights reserved.
//

#import "HWShowTaskViewController.h"
#import "HWAddTaskDescription.h"
#import "HWTextCell.h"
#import "HWProjectModel.h"
#import "UIImageView+Expanded.h"
#import <SDWebImage/UIImageView+WebCache.h>


@interface HWShowTaskViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)UITableView* tableView;
@property(nonatomic, copy)NSArray* titleArray;
@property(nonatomic, copy)NSArray* imageArray;
@property(nonatomic, copy)NSArray* statusTitleArray;
@property(nonatomic, assign)TaskStatus status;
@end

@implementation HWShowTaskViewController

- (instancetype)initWithType:(TaskStatus)status {
    self = [super init];
    if (self) {
        _status = status;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"创建任务";
    _titleArray = @[@"所属项目",@"执行者",@"优先级",@"截止日期",@"关注者"];
    _imageArray = @[@"taskProject",@"taskOwner",@"taskPriority",@"taskDeadline",@"taskWatchers",@"taskProgress",@"taskResourceReference"];
    _statusTitleArray = @[@"未指定",@"未指定",@"正常处理",@"未指定",@"未添加"];
    [self setTab];
}

- (void)setTab {
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, width, height - 64)];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor colorWithRed:242/255.0 green:244/255.0 blue:246/255.0 alpha:1];
    [_tableView registerNib:[UINib nibWithNibName:@"HWTextCell" bundle:nil] forCellReuseIdentifier:@"first"];
    HWAddTaskDescription* addTask = [[HWAddTaskDescription alloc] initWithType:self.status];
    if (self.status == Create) {
        addTask.projectModel = self.projectModel;
    } else {
        addTask.task = self.task;
    }
    addTask.frame = CGRectMake(0, 0, width, 230);
    _tableView.tableHeaderView = addTask;
    _tableView.tableFooterView = [UIView new];
    _tableView.separatorInset = UIEdgeInsetsMake(0, 50, 0, 0);
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titleArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = NULL;
    if (indexPath.section == 0) {
        HWTextCell* textCell = [tableView dequeueReusableCellWithIdentifier:@"first"];
        if (self.status == Create || indexPath.row != 0) {
            textCell.textImageView.image = [UIImage imageNamed:self.imageArray[indexPath.row]];
        } else {
            NSURL* url;
            if ([_task.user.avatar hasPrefix:@"https"]) {
                url = [NSURL URLWithString:_task.user.avatar];
            } else {
                url = [NSURL URLWithString:[NSString stringWithFormat:@"https://coding.net%@",_task.user.avatar]];
            }
            [textCell.textImageView sd_setImageWithURL:url];
        }
        textCell.nameLabel.text = self.titleArray[indexPath.row];
        textCell.statusLabel.text = self.statusTitleArray[indexPath.row];
        textCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell = (UITableViewCell*)textCell;
    }
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
