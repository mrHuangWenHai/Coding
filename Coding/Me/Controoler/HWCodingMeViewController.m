//
//  HWCodingMeViewController.m
//  Coding
//
//  Created by 黄文海 on 2018/3/13.
//  Copyright © 2018年 huang. All rights reserved.
//

#import "HWCodingMeViewController.h"
#import "HWTaskModel.h"
#import "Login.h"
#import "CodingNetAPIManager.h"
#import "UserServiceInfo.h"
#import "MeHeader.h"
#import "UIColor+Expanded.h"
#import "ProjectMessageCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIImageView+Expanded.h"
#import "MeCell.h"

@interface HWCodingMeViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong)UITableView* meTableView;
@property(nonatomic, copy)NSString* urlPath;
@property(nonatomic, strong)UserServiceInfo* userServiceInfo;
@property(nonatomic, copy)NSArray* titleArray;
@property(nonatomic, copy)NSArray* imageurlArray;
@property(nonatomic, strong)User* user;
@end

@implementation HWCodingMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"addUserBtn_Nav"] style:UIBarButtonItemStylePlain target:self action:@selector(gotoAddFriend)];
    
    _meTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
    
    [_meTableView registerClass:[ProjectMessageCell class] forCellReuseIdentifier:@"projectMessage"];
    [_meTableView registerNib:[UINib nibWithNibName:@"MeCell" bundle:nil] forCellReuseIdentifier:@"me"];
    _meTableView.backgroundColor = kColorTableSectionBg;
    _meTableView.dataSource = self;
    _meTableView.delegate = self;
    _meTableView.separatorInset = UIEdgeInsetsMake(0, 50, 0, 0);
    _meTableView.tableFooterView = [[UIView alloc] init];
    _meTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_meTableView];
    
    [self loadData];
}

- (void)loadData {

    _user = [Login getCurUser];
    if (self.urlPath == NULL) {
        _urlPath = [NSString stringWithFormat:@"api/user/key/%@",_user.name];
    }
    
    __weak typeof(self) weakself = self;
    [[CodingNetAPIManager sharedManager] requestServiceInfoBlock:^(UserServiceInfo* userServiceInfo, NSError *error) {
        weakself.userServiceInfo = userServiceInfo;
        [weakself.meTableView reloadData];
    }];
    
}

- (void)gotoAddFriend {
    NSLog(@"11111");
}

- (NSArray*)titleArray {
    if (_titleArray == NULL) {
        _titleArray = @[@"我的码币",@"商城",@"本地文件",@"帮助与反馈",@"设置",@"关于我们"];
    }
    return _titleArray;
}

- (NSArray*)imageurlArray {
    if (_imageurlArray == NULL) {
        _imageurlArray = @[@"user_info_point",@"user_info_shop",@"user_info_file",@"user_info_help",@"user_info_setup",@"user_info_about"];
    }
    return _imageurlArray;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 15;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView* headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 15)];
    CALayer* layerTop = [[CALayer alloc] init];
    layerTop.frame = CGRectMake(0, 0, tableView.frame.size.width, 1);
    layerTop.backgroundColor = kColorD8DDE4.CGColor;
    [headView.layer addSublayer:layerTop];
    
    CALayer* layerBottom = [[CALayer alloc] init];
    layerBottom.frame = CGRectMake(0, 14, tableView.frame.size.width, 1);
    layerBottom.backgroundColor = kColorD8DDE4.CGColor;
    [headView.layer addSublayer:layerBottom];
    return headView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0 || section == 1) {
        return 2;
    } else {
        return 4;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 60;
    } else {
        return 40;
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell;
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            MeCell* meCell = [tableView dequeueReusableCellWithIdentifier:@"me"];
            [meCell.headImageView sd_setImageWithURL:[NSURL URLWithString:self.user.avatar] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                [meCell.headImageView setCornerRadius];
            }];
            meCell.titleLabel.text = self.user.name;
            meCell.userLevel.text = @"普通会员";
            meCell.userLevel.backgroundColor = kColorD8DDE4;
            meCell.userLevel.textColor = kColorDark7;
            meCell.userLevel.font = [UIFont systemFontOfSize:12];
            cell = (MeCell*)meCell;
        } else {
            ProjectMessageCell* messageCell = [tableView dequeueReusableCellWithIdentifier:@"projectMessage"];
            messageCell.privateMessageLabel.text = [NSString stringWithFormat:@"%@",self.userServiceInfo.pri == NULL ? @"_/_":[NSString stringWithFormat:@"%@/%@",self.userServiceInfo.pri,self.userServiceInfo.private_project_quota]];
            messageCell.publiceMessageLabel.text = [NSString stringWithFormat:@"%@",self.userServiceInfo.pub == NULL ?
                                                    @"_/_":[NSString stringWithFormat:@"%@/无限",self.userServiceInfo.pub]];
            cell = (UITableViewCell*)messageCell;
        }
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"othersCell"];
        if (cell == NULL) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"othersCell"];
        }
        
        if (indexPath.section == 1) {
            cell.imageView.image = [UIImage imageNamed:self.imageurlArray[indexPath.row]];
            cell.textLabel.text = self.titleArray[indexPath.row];
            if (indexPath.row == 0) {
                cell.detailTextLabel.text = self.userServiceInfo.point_left;
                cell.detailTextLabel.textColor = kColorLightBlue;
            }
        } else {
            cell.imageView.image = [UIImage imageNamed:self.imageurlArray[indexPath.row + 2]];
            cell.textLabel.text = self.titleArray[indexPath.row + 2];
        }
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
