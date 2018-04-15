//
//  HWCodingPopViewController.m
//  Coding
//
//  Created by 黄文海 on 2018/3/13.
//  Copyright © 2018年 huang. All rights reserved.
//

#import "HWCodingPopViewController.h"
#import "HWBannderHandler.h"
#import "CodingNetAPIManager.h"
#import "UIView+Frame.h"
#import "HWBannerModel.h"
#import "HWPopViewCell.h"
#import "Tweet.h"

#define IS_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

@interface HWCodingPopViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong)HWBannderHandler* bannderHandler;
@property(nonatomic, strong)UITableView* tableView;
@property(nonatomic, strong)Tweets* tweets;
@end

@implementation HWCodingPopViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setUpTableView];
}

- (void)setUpTableView {
    
    CGFloat y = IS_iPhoneX ? 88:64;
    CGFloat tabBarHeight = IS_iPhoneX ? 83 : 49;
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    CGFloat bannderHeight = width * 0.4 + 44;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, y, width, height - y - tabBarHeight)];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[HWPopViewCell class] forCellReuseIdentifier:@"static"];
    _tableView.tableFooterView = [[UIView alloc] init];
    _bannderHandler = [[HWBannderHandler alloc] initWithFrame:CGRectMake(0, 0, width, bannderHeight)];
    _tableView.tableHeaderView = _bannderHandler;
    [self.view addSubview:_tableView];
    __weak typeof(self) weakself = self;
    [[CodingNetAPIManager sharedManager] requestBannersWithBlock:^(id bannerList, NSError *error) {
        weakself.bannderHandler.bannerModels = ((HWBannerList*)bannerList).data;
    }];
    
    [[CodingNetAPIManager sharedManager] requestTweetsWithComplectionBlock:^(id data, NSError *error) {
        if (data) {
            weakself.tweets = (Tweets*)data;
            [weakself.tableView reloadData];
        } else {
            
        }
    }];
}

- (void)viewDidLayoutSubviews {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    Tweet* tweet = self.tweets.data[indexPath.row];
    NSLog(@"%f",tweet.totalHeight);
    return tweet.totalHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    Tweet* tweet = self.tweets.data[indexPath.row];

    HWPopViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"static"];
    __weak typeof(tableView) weakTabel = tableView;
    __weak typeof (cell) weakCell = cell;
    cell.index = indexPath.row;
    cell.cellRefreshBlock = ^{
        NSIndexPath* indexPath = [NSIndexPath indexPathForRow:weakCell.index inSection:0];
        CGRect rect = [weakTabel rectForRowAtIndexPath:indexPath];
        rect.origin.y -= CGRectGetHeight(weakTabel.tableHeaderView.bounds);
        CGRect frame = weakTabel.frame;
        if (weakTabel.contentOffset.y - rect.origin.y < rect.size.height || rect.origin.y - weakTabel.contentOffset.y < frame.size.height) {
            [weakTabel reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:false];
        } else {
            return;
        }
    };
    cell.tweet = tweet;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.tweets.data.count;
}

@end
