//
//  HWCodingMeViewController.m
//  Coding
//
//  Created by 黄文海 on 2018/3/13.
//  Copyright © 2018年 huang. All rights reserved.
//

#import "HWCodingMeViewController.h"

@interface HWCodingMeViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong)UITableView* meTableView;
@end

@implementation HWCodingMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"addUserBtn_Nav"] style:UIBarButtonItemStylePlain target:self action:@selector(gotoAddFriend)];
    
    _meTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
    _meTableView.dataSource = self;
    _meTableView.delegate = self;
    _meTableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_meTableView];
    
}


- (void)gotoAddFriend {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
