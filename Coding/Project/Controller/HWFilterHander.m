//
//  HWFilterHander.m
//  Coding
//
//  Created by 黄文海 on 2018/3/19.
//  Copyright © 2018年 huang. All rights reserved.
//

#import "HWFilterHander.h"
#import "HWProjectModel.h"
#import "ProjectCount.h"
#import "HWCodingProjectViewController.h"
#import <UIKit/UIKit.h>
#import "CodingNetAPIManager.h"
#import "UIColor+Expanded.h"

@interface HWFilterHander()<UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>
@property(nonatomic, strong)UITableView* filterTableView;
@property(nonatomic, strong)UIView* filterBackGroundView;
@property(nonatomic, strong)NSArray* titleList;
@property(nonatomic, strong)ProjectCount* projectCount;
@property(nonatomic, assign)BOOL isOpen;
@property(nonatomic, assign)NSInteger selectIndex;
@end

@implementation HWFilterHander

- (instancetype)init {
    
    if (self = [super init]) {
        _selectIndex = 0;
        _isOpen = false;
        [self setupBackView];
        [self setupTableView];
    }
    
    return self;
}

- (void)setupBackView {
    
    _filterBackGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, CGRectGetHeight([UIScreen mainScreen].bounds)-64)];
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    UIView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    blurEffectView.frame = _filterBackGroundView.bounds;
    [_filterBackGroundView addSubview:blurEffectView];
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideFilter)];
    tap.delegate = self;
    [_filterBackGroundView addGestureRecognizer:tap];
}

- (void)refreshData {
    __weak typeof(self) weakself = self;
    [[CodingNetAPIManager sharedManager] requestProjectCountsWithCompleteBlock:^(ProjectCount* response, NSError *error) {
        if (response != NULL) {
            weakself.projectCount = response;
            [weakself.filterTableView reloadData];
        }
    }];
}

- (void)setupTableView {
    
    _titleList = @[@"全部项目",@"我创建的",@"我参与的",@"我关注的",@"我收藏的"];
    _filterTableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 0,CGRectGetWidth([UIScreen mainScreen].bounds)-20,CGRectGetHeight([UIScreen mainScreen].bounds)-64)];
    _filterTableView.backgroundColor = [UIColor clearColor];
    UIView*view = [[UIView alloc] init];
    _filterTableView.tableFooterView = view;
    _filterTableView.dataSource = self;
    _filterTableView.delegate = self;
    _filterTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_filterBackGroundView addSubview:_filterTableView];
    
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == NULL) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.backgroundColor = [UIColor clearColor];
    }
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    NSInteger index = [self getDataIndexWithIndexPath:indexPath];
    UILabel* textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 50)];
    if (indexPath.section != 2 && index == self.selectIndex) {
        textLabel.textColor = [UIColor colorWithHexString:@"0x0060FF"];
    } else {
        textLabel.textColor = [UIColor colorWithHexString:@"0x222222"];
    }
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            textLabel.text = [NSString stringWithFormat:@"%@ (%ld)",_titleList[indexPath.row],(long)self.projectCount.all];
        } else if (indexPath.row == 1) {
            textLabel.text = [NSString stringWithFormat:@"%@ (%ld)",_titleList[indexPath.row],(long)self.projectCount.created];
        } else {
                textLabel.text = [NSString stringWithFormat:@"%@ (%ld)",_titleList[indexPath.row],(long)self.projectCount.joined];
        }
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            textLabel.text = [NSString stringWithFormat:@"%@ (%ld)",_titleList[indexPath.row + 3],self.projectCount.watched];
        } else {
            textLabel.text = [NSString stringWithFormat:@"%@ (%ld)",_titleList[indexPath.row+3],self.projectCount.stared];
        }
    }
    cell.imageView.image = NULL;
    if (indexPath.section == 2) {
        textLabel.text = @"项目广场";
        textLabel.frame = CGRectMake(25, 0, 150, 50);
        UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        CGPoint center = imageView.center;
        center.y = textLabel.center.y;
        imageView.center = center;
        imageView.image = [UIImage imageNamed:@"fliter_square"];
        [cell.contentView addSubview:imageView];
    }
    [cell.contentView addSubview:textLabel];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.selectIndex = [self getDataIndexWithIndexPath:indexPath];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self hideFilter];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(10, 0, CGRectGetWidth(tableView.frame) - 10, 1)];
    view.backgroundColor = [UIColor colorWithRed:232/255.0 green:235/255.0 blue:239/255.0 alpha:1];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 2) {
        return 0;
    }
    return 1;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    } else if (section == 1) {
        return 2;
    } else {
        return 1;
    }
}

- (void)hideFilter {
    [self showMoreSelect];
}

- (void)showMoreSelect {
    
    if (!self.isOpen) {
        [self.projectController.view addSubview:self.filterBackGroundView];
        [self refreshData];
        self.isOpen = true;
    } else {
        [self.filterBackGroundView removeFromSuperview];
        self.isOpen = false;
    }
}

- (NSInteger)getDataIndexWithIndexPath:(NSIndexPath*)indexPath {
    NSInteger index = 0;
    switch (indexPath.section) {
        case 0:
            index = indexPath.row;
            break;
        case 1:
            index = indexPath.row + 3;
            break;
        default:
            index = self.selectIndex;
            break;
    }
    return index;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        
        return NO;
        
    }
    
    return YES;
    
}

@end
