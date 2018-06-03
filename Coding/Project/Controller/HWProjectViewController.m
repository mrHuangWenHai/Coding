//
//  HWProjectViewController.m
//  Coding
//
//  Created by 黄文海 on 2018/6/1.
//  Copyright © 2018年 huang. All rights reserved.
//

#import "HWProjectViewController.h"
#import "HWPageView.h"
#import "UIView+Frame.h"
#import "CodingNetAPIManager.h"
#import "HWGitModel.h"

#define IS_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

@interface HWProjectViewController ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>
@property(nonatomic, strong)HWPageView* pageView;
@property(nonatomic, strong)UITableView* projectTableView;
@property(nonatomic, strong)NSMutableDictionary* dataDictionary;
@property(nonatomic, assign)NSInteger curIndex;
@property(nonatomic, strong)NSArray* typeArray;
@property(nonatomic, strong)HWGitModel* curGitModel;
@end

@implementation HWProjectViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    _curIndex = 0;
    _typeArray = @[@"all"];
    
    NSArray* titleArray = @[@"全部", @"讨论", @"代码", @"其他"];
    _pageView = [[HWPageView alloc] initWith:titleArray and:StaticStyle];
    [self.view addSubview:_pageView];

    _projectTableView = [[UITableView alloc] init];
    _projectTableView.tableFooterView = [UIView new];
  //  _projectTableView.delegate = self;
  //  _projectTableView.dataSource = self;
    
    [self loadProjectDataAtIndex:0];
}

- (void)viewWillLayoutSubviews {
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    _pageView.frame = CGRectMake(0, IS_iPhoneX ? 88 : 64, width, 60);
    _projectTableView.frame = CGRectMake(0, _pageView.getY, width, height - _pageView.getY);
}

- (void)setProject:(Project *)project {
    _project = project;
}

- (void)loadProjectDataAtIndex:(NSInteger)index {

    //https://coding.net/api/project/2664584/activities?last_id=99999999&type=all&user_id=1212474
    self.curIndex = index;
    
    NSString* indexKey = [NSString stringWithFormat:@"%ld",index];
    self.curGitModel = self.dataDictionary[indexKey];
    if (self.curGitModel) {
        [self.projectTableView reloadData];
    } else {
        NSString* type = self.typeArray[index];
        NSString* url = [NSString stringWithFormat:@"api/project/%@/activities?last_id=99999999&type=%@&user_id=%@",self.project.userId,type,self.project.ownerId];
        [[CodingNetAPIManager sharedManager] requestProjectGitMessageWithUrl:url andCallback:^(id gitMessage, NSError *error) {
            if (gitMessage) {
                self.curGitModel = gitMessage;
                self.curGitModel.dataGroup;
                [self.dataDictionary setObject:gitMessage forKey:indexKey];
   //             [self.projectTableView reloadData];
            } else {
                
            }
        }];
    }
    
  
}

- (NSMutableDictionary*)dataDictionary {
    if (_dataDictionary) {
        _dataDictionary = [[NSMutableDictionary alloc] initWithCapacity:5];
    }
    return _dataDictionary;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
