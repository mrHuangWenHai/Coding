//
//  HWTaskViewHander.m
//  Coding
//
//  Created by 黄文海 on 2018/3/26.
//  Copyright © 2018年 huang. All rights reserved.
//

#import "HWTaskViewHander.h"
#import "HWTaskCell.h"
#import "HWTaskModel.h"



@interface HWTaskViewHander()<UITableViewDelegate, UITableViewDataSource>
@end

@implementation HWTaskViewHander

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUptab];
    }
    return self;
}

- (void)setUptab {
    
    _tableView = [[UITableView alloc] initWithFrame:self.bounds];
    [_tableView registerClass:[HWTaskCell class] forCellReuseIdentifier:@"cell"];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _tableView.backgroundColor = [UIColor colorWithRed:242/255.0 green:244/255.0 blue:246/255.0 alpha:1];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self addSubview:_tableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    HWTaskCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.task = self.taskModel.list[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.taskModel.list.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    self.selectCell(self.taskModel.list[indexPath.row]);
}

- (void)setTaskModel:(HWTaskModel *)taskModel {
    _taskModel = taskModel;
    NSLog(@"%ld",_taskModel.list.count);
    [self.tableView reloadData];
}

@end
