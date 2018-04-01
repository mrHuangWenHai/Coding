//
//  HWTableViewHander.m
//  Coding
//
//  Created by 黄文海 on 2018/3/14.
//  Copyright © 2018年 huang. All rights reserved.
//

#import "HWTableViewHander.h"
#import "HWMainSearchBar.h"
#import "UIColor+Expanded.h"
#import "CodingNetAPIManager.h"
#import "HWProjectTableViewCell.h"
#import "UIImage+Expanded.h"
#import "YLImageView.h"
#import "ODRefreshControl.h"


@interface HWTableViewHander() <UITableViewDataSource, UITableViewDelegate, SWTableViewCellDelegate>
@property(nonatomic, weak)HWCodingProjectViewController* projectController;
@property(nonatomic, strong)YLImageView* loadingImageView;
@property (nonatomic, strong) ODRefreshControl *myRefreshControl;
@end

@implementation HWTableViewHander
- (instancetype)initWithHander:(HWCodingProjectViewController*)projectController {
    self = [super init];
    if (self) {
        _projectController = projectController;
        UIImage* image = [UIImage gifImageWithName:@"loading_monkey@2x.gif"];
        _loadingImageView = [[YLImageView alloc] initWithImage:image];
        _loadingImageView.frame = CGRectMake(0, 0, 90, 90);
        _loadingImageView.center = self.projectController.view.center;
        [self.projectController.view addSubview:_loadingImageView];
        [_loadingImageView bringSubviewToFront:self.projectTableView];
        
    }
    return self;
}

- (void)setupData {
    
    if (self.projectModel.list.count > 0) {
        [self.myRefreshControl endRefreshing];
        return;
    }
    __weak typeof(self) weakself = self;
    if (self.loadingImageView.isHidden && !self.myRefreshControl.isRefreshing) {
        self.loadingImageView.hidden = false;
    }
    
    [[CodingNetAPIManager sharedManager] requestProjectMessageWithPath:@"api/projects" Params:nil andBlock:^(HWProjectModel* projectModel, NSError * error) {
        if (!weakself.loadingImageView.isHidden) {
            weakself.loadingImageView.hidden = true;
        }
        if (projectModel == NULL) {
            
            
        } else {
            weakself.projectModel = projectModel;
            [weakself.projectTableView reloadData];
        }
        [self.myRefreshControl endRefreshing];
    }];
    
}

- (void)setupTableViewWithFrame:(CGRect)frame {
    
    _projectTableView = [[UITableView alloc] initWithFrame:frame];
    _projectTableView.delegate = self;
    _projectTableView.dataSource = self;
    _projectTableView.estimatedRowHeight = 0;
    _projectTableView.separatorInset = UIEdgeInsetsMake(0, 5, 0, 0);
    [_projectTableView registerNib:[UINib nibWithNibName:@"HWProjectTableViewCell" bundle:nil] forCellReuseIdentifier:@"projectCell"];
    _projectTableView.tableFooterView = [[UIView alloc] init];
    
    HWMainSearchBar* searchBar = [[HWMainSearchBar alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 60)];
    [searchBar setPlaceholder:@"搜索"];
    searchBar.barTintColor = [UIColor colorWithRed:242/255.0 green:244/255.0 blue:246/255.0 alpha:1];
    [searchBar.scanButton addTarget:self
                             action:@selector(scanButtonClick:)
                   forControlEvents:UIControlEventTouchUpInside];
    _projectTableView.tableHeaderView = searchBar;
    _myRefreshControl = [[ODRefreshControl alloc] initInScrollView:_projectTableView];
    _myRefreshControl.backgroundColor = [UIColor colorWithRed:242/255.0 green:244/255.0 blue:246/255.0 alpha:1];
    [_myRefreshControl addTarget:self action:@selector(setupData) forControlEvents:UIControlEventValueChanged];

}

- (void)scanButtonClick:(id)sender {
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 110;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    HWProjectTableViewCell* projectCell = [tableView dequeueReusableCellWithIdentifier:@"projectCell"];
    Project* project = self.projectModel.list[indexPath.row];
    projectCell.delegate = self;
    projectCell.project = project;
    return projectCell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.projectModel.list.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(didSelectPerojectCellWithProject:)]) {
        [self.delegate didSelectPerojectCellWithProject:self.projectModel.list[indexPath.row]];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index {
    NSLog(@"%ld",(long)index);
}

@end
