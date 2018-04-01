//
//  HWCodingTaskViewController.m
//  Coding
//
//  Created by 黄文海 on 2018/3/13.
//  Copyright © 2018年 huang. All rights reserved.
//

#import "HWCodingTaskViewController.h"
#import "HWShowTaskViewController.h"
#import "CodingNetAPIManager.h"
#import "HWTaskViewHander.h"
#import "UIColor+Expanded.h"
#import "HWSegmentHander.h"
#import "HWProjectModel.h"
#import "HWTaskModel.h"
#import "UIView+Frame.h"

#define IS_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

@interface HWCodingTaskViewController ()
@property(nonatomic, strong)UIButton* titleButton;
@property(nonatomic, strong)HWSegmentHander* segmentHander;
@property(nonatomic, strong)HWProjectModel* projectModel;
@property(nonatomic, strong)HWTaskModel* taskModel;
@property(nonatomic, strong)HWTaskViewHander* taskViewHander;
@end

@implementation HWCodingTaskViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupRightButtons];
    [self setupTitleButton];
    [self setupsegmentHander];
    [self setupTask];
    
}

- (void)setupTask {
    
    CGFloat height = CGRectGetHeight(self.view.bounds);
    CGFloat width = CGRectGetWidth(self.view.bounds);
    _taskViewHander = [[HWTaskViewHander alloc] initWithFrame:CGRectMake(0, self.segmentHander.getY, width, height - self.segmentHander.getY)];
    
    __weak typeof(self) weakself = self;
    _taskViewHander.selectCell = ^(Task *task) {
        [weakself loadShowTaskWith:task];
    };
    [self.view addSubview:_taskViewHander];
    
}

- (void)viewWillLayoutSubviews {
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    self.segmentHander.frame = CGRectMake(0, IS_iPhoneX ? 88 : 64, width, height*0.1);
    
}

- (void)setupsegmentHander {
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    _segmentHander = [[HWSegmentHander alloc] initWithFrame:CGRectMake(0, IS_iPhoneX ? 88 : 64, width, height*0.1)];
    [self.view addSubview:_segmentHander];
    [_segmentHander reloadSegmentData];
    
    __weak typeof(self) weakself = self;
    _segmentHander.projectHander = ^(HWProjectModel *projectModel) {
        weakself.projectModel = projectModel;
        Project* project = projectModel.list[0];
        NSLog(@"%@ %@",project.userId,project.ownerId);
        [weakself loadTaskProjectWith:project.ownerId];
    };

    
}

- (void)setupTitleButton {
    
    _titleButton = [[UIButton alloc] init];
    [_titleButton setTitleColor:[UIColor colorWithHexString:@"0x323A45"] forState:UIControlStateNormal];
    UIFont* font = [UIFont systemFontOfSize:18];
    UIImage* buttonImage = [UIImage imageNamed:@"btn_fliter_down"];
    [_titleButton.titleLabel setFont:font];
    [_titleButton addTarget:self action:@selector(fliterClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_titleButton setTitle:@"我的任务" forState:UIControlStateNormal];
    [_titleButton setImage:buttonImage forState:UIControlStateNormal];
    self.navigationItem.titleView = _titleButton;
    
    CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 30);
    CGSize resultSize;
    NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
    style.lineBreakMode = NSLineBreakByWordWrapping;
    resultSize = [@"我的任务" boundingRectWithSize:CGSizeMake(floor(maxSize.width), floor(maxSize.height))
                                          options:(NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin)
                                       attributes:@{NSFontAttributeName: font,
                                                 NSParagraphStyleAttributeName: style}
                                       context:nil].size;
    resultSize = CGSizeMake(floor(resultSize.width + 1), floor(resultSize.height + 1));
    
    _titleButton.titleEdgeInsets = UIEdgeInsetsMake(0, -buttonImage.size.width, 0, buttonImage.size.width);
    _titleButton.imageEdgeInsets = UIEdgeInsetsMake(0, resultSize.width + 10, 0, -resultSize.width);
}

- (void)setupRightButtons {
    
    UIBarButtonItem* addBar = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"addBtn_Nav"] style:UIBarButtonItemStylePlain target:self action:@selector(addButtonClick:)];
    UIBarButtonItem* screenBar = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"addBtn_Artboard"] style:UIBarButtonItemStylePlain target:self action:@selector(screenBarClick:)];
    self.navigationItem.rightBarButtonItems = @[addBar, screenBar];
    
}

- (void)loadTaskProjectWith:(NSString*)userId {
    NSDictionary* params = @{
                             @"owner":userId,
                             @"page":@"1"
                             };
    __weak typeof(self) weakself = self;
    [[CodingNetAPIManager sharedManager] requestTasksSearchWithParams:params CompleteBlock:^(HWTaskModel *taskModel, NSError *error) {
        weakself.taskModel = taskModel;
        weakself.taskViewHander.taskModel = taskModel;
    }];

}

- (void)addButtonClick:(id)sender {
    HWShowTaskViewController* showTask = [[HWShowTaskViewController alloc] initWithType:Create];
    showTask.projectModel = self.projectModel;
    [self.navigationController pushViewController:showTask animated:true];
}

- (void)loadShowTaskWith:(Task*)task {
    HWShowTaskViewController* showTask = [[HWShowTaskViewController alloc] initWithType:Show];
    showTask.task = task;
    [self.navigationController pushViewController:showTask animated:true];
}

- (void)screenBarClick:(id)sender {
    
}

- (void)fliterClicked:(id)sender {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
