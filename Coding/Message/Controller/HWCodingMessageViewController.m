//
//  HWCodingMessageViewController.m
//  Coding
//
//  Created by 黄文海 on 2018/3/13.
//  Copyright © 2018年 huang. All rights reserved.
//

#import "HWCodingMessageViewController.h"
#import "MessageHeader.h"
#import "CodingNetAPIManager.h"
#import "MessageModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIView+Expanded.h"
#import "UIColor+Expanded.h"
#import "SystemTableViewCell.h"
#import "NSDate+Common.h"

@interface HWCodingMessageViewController ()<UITableViewDataSource, UITableViewDelegate>
@property(nonatomic, strong)UITableView* tableView;
@property(nonatomic, assign)NSUInteger page;
@property(nonatomic, assign)NSUInteger pageSize;
@property(nonatomic, strong)MessageModel* messageModel;
@property(nonatomic, copy)NSDictionary* unreadCountDictionary;
@end

@implementation HWCodingMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息";
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"tweetBtn_Nav"] style:UIBarButtonItemStylePlain target:self action:@selector(sendMsgBtnClicked:)] animated:NO];
    
    _tableView = [[UITableView alloc] init];
    CGFloat y = IS_iPhoneX ? 88 : 64;
    _tableView.frame = CGRectMake(0, y, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - y);
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:@"SystemTableViewCell" bundle:nil] forCellReuseIdentifier:@"systemCell"];
    _tableView.tableFooterView = [UIView new];
    [self.view addSubview:_tableView];
    
    _page = 0;
    _pageSize = 20;
    
    [self refresh];
}

- (void)loadTableViewData {
    
    __weak typeof(self) weakself = self;
    [[CodingNetAPIManager sharedManager] requestMessageWithParam:@{@"page":@(self.page),@"pageSize":@(self.pageSize)} andBlock:^(MessageModel *messageModel, NSError *error) {
        if (messageModel) {
            weakself.messageModel = messageModel;
            [weakself.tableView reloadData];
        } else {
            NSLog(@"error");
        }
    }];

}

- (void)refresh {
    __weak typeof(self) weakself = self;
    [[CodingNetAPIManager sharedManager] requestUnReadNotificationsWithBlock:^(id data, NSError *error) {
        NSLog(@"%@",data);
        weakself.unreadCountDictionary = data;
        [weakself loadTableViewData];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger row = 3;
    if (self.messageModel.list) {
        row += self.messageModel.totalRow;
    }
    return row;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < 3) {
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == NULL) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            cell.textLabel.font = [UIFont systemFontOfSize:17];
            cell.textLabel.textColor = kColorDark3;
        }
        
        if (cell.accessoryView) {
            [cell.accessoryView removeFromSuperview];
            cell.accessoryView = NULL;
        }
        
        int unredCount = 0;
        UILabel* unredCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        unredCountLabel.font = [UIFont systemFontOfSize:11];
        unredCountLabel.textAlignment = NSTextAlignmentCenter;
        unredCountLabel.backgroundColor = [UIColor redColor];
        unredCountLabel.textColor = [UIColor whiteColor];
        [unredCountLabel setCornerRadius];
        switch (indexPath.row) {
            case 0:
                cell.imageView.image = [UIImage imageNamed:@"messageAT"];
                unredCount = [[self.unreadCountDictionary valueForKey:@"notification_at"] intValue];
                cell.textLabel.text = @"@我的";
                break;
            case 1:
                cell.imageView.image = [UIImage imageNamed:@"messageComment"];
                unredCount = [[self.unreadCountDictionary valueForKey:@"notification_comment"] intValue];
                cell.textLabel.text = @"评论";
                break;
            case 2:
                cell.imageView.image = [UIImage imageNamed:@"messageSystem"];
                unredCount = [[self.unreadCountDictionary valueForKey:@"notification_system"] intValue];
                cell.textLabel.text = @"系统通知";
                break;
        }
        
        if (unredCount != 0) {
            unredCountLabel.text = [NSString stringWithFormat:@"%d",unredCount];
            cell.accessoryView = unredCountLabel;
        } else {
            if (indexPath.row == 0 ) {
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            } else {
            }
        }
        return  cell;
    } else {
        SystemTableViewCell* systemCell = [tableView dequeueReusableCellWithIdentifier:@"systemCell"];
        Message* message = self.messageModel.list[indexPath.row - 3];
        systemCell.contentLabel.text = message.content;
        systemCell.contentLabel.textColor = kColorDark7;
        systemCell.contentLabel.font = [UIFont systemFontOfSize:15];
        systemCell.separatorInset = UIEdgeInsetsMake(0, 70, 0, 0);
        
        systemCell.titleLabel.text = message.sender.name;
        systemCell.titleLabel.font = [UIFont systemFontOfSize:17];
        systemCell.timeLabel.textColor = kColorDark3;

        NSTimeInterval time = (double)message.created_at / 1000;
        NSDate *createAtTime=[NSDate dateWithTimeIntervalSince1970:time];
        systemCell.timeLabel.text = [createAtTime stringDisplay_MMdd];
        systemCell.timeLabel.font = [UIFont systemFontOfSize:12];
        systemCell.timeLabel.textColor = kColorDark7;
        
        [systemCell.headImageView sd_setImageWithURL:[NSURL URLWithString:message.sender.avatar]];
        return systemCell;
    }
}

- (void)sendMsgBtnClicked:(id)sender {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
