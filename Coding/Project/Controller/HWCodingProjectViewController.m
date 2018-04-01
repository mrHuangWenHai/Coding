//
//  HWCodingProjectViewController.m
//  Coding
//
//  Created by 黄文海 on 2018/3/13.
//  Copyright © 2018年 huang. All rights reserved.
//

#import "HWCodingProjectViewController.h"
#import "UIColor+Expanded.h"
#import "HWTableViewHander.h"
#import "HWProjectDetailViewController.h"
#import "HWFilterHander.h"
#import "HWPopViewHander.h"


#define IS_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)


@interface HWCodingProjectViewController ()<ProjectCellDelegate>
@property(nonatomic, strong)UIButton* titleButton;
@property(nonatomic, strong)HWTableViewHander* tableViewHander;
@property(nonatomic, strong)HWFilterHander* fileterHander;
@property(nonatomic, strong)HWPopViewHander* popHander;
@end

@implementation HWCodingProjectViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupTitleBtn];
    [self setupNavBtn];
    [self setupTabHander];
    [self setupFilterHander];
    [self setupPopHander];
    
}

- (void)setupPopHander {
    _popHander = [[HWPopViewHander alloc] init];
    _popHander.projectController = self;
}

- (void)setupFilterHander {
    
    _fileterHander = [[HWFilterHander alloc] init];
    _fileterHander.projectController = self;
}

- (void)setupTabHander {
    
    CGFloat headHeight = IS_iPhoneX ? 88:64;
    CGFloat footHeight = IS_iPhoneX ? 83:49;
    _tableViewHander = [[HWTableViewHander alloc] initWithHander:self];
    _tableViewHander.delegate = self;
    [_tableViewHander setupTableViewWithFrame:CGRectMake(0, headHeight, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - footHeight - headHeight)];
    _tableViewHander.projectTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view insertSubview:_tableViewHander.projectTableView atIndex:0];
    [self.tableViewHander setupData];
    
}

- (void)setupNavBtn {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"addBtn_Nav"]        style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonClick:)];
}

- (void)rightButtonClick:(id)sender {
    [self.popHander showButtonMenu];
}

- (void)setupTitleBtn {
    
    if (!_titleButton) {
        
        _titleButton = [[UIButton alloc] init];
        [_titleButton setTitleColor:[UIColor colorWithHexString:@"0x323A45"] forState:UIControlStateNormal];
        UIFont* font = [UIFont systemFontOfSize:18];
        UIImage* buttonImage = [UIImage imageNamed:@"btn_fliter_down"];
        [_titleButton.titleLabel setFont:font];
        [_titleButton addTarget:self action:@selector(fliterClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_titleButton setTitle:@"全部项目" forState:UIControlStateNormal];
        [_titleButton setImage:buttonImage forState:UIControlStateNormal];
        self.navigationItem.titleView = _titleButton;
        
        CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 30);
        CGSize resultSize;
        NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
        style.lineBreakMode = NSLineBreakByWordWrapping;
        resultSize = [@"全部项目" boundingRectWithSize:CGSizeMake(floor(maxSize.width), floor(maxSize.height))
                                        options:(NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin)
                                     attributes:@{NSFontAttributeName: font,
                                                  NSParagraphStyleAttributeName: style}
                                        context:nil].size;
        resultSize = CGSizeMake(floor(resultSize.width + 1), floor(resultSize.height + 1));
        
        _titleButton.titleEdgeInsets = UIEdgeInsetsMake(0, -buttonImage.size.width, 0, buttonImage.size.width);
        _titleButton.imageEdgeInsets = UIEdgeInsetsMake(0, resultSize.width + 10, 0, -resultSize.width);
    }
}

- (void)fliterClicked:(id)sender {
    self.fileterHander.projectModel = self.tableViewHander.projectModel;
    [self.fileterHander showMoreSelect];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)didSelectPerojectCellWithProject:(Project*)project {
    
    HWProjectDetailViewController* detailProject = [[HWProjectDetailViewController alloc] initWithProject:project];
    [self.navigationController pushViewController:detailProject animated:true];
    
}



@end
