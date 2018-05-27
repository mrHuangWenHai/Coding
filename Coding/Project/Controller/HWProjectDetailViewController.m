//
//  HWProjectDetailViewController.m
//  Coding
//
//  Created by 黄文海 on 2018/3/17.
//  Copyright © 2018年 huang. All rights reserved.
//

#import "HWProjectDetailViewController.h"
#import "HWProjectDetailCell.h"
#import "UIColor+Expanded.h"
#import "HWProjectDescriptionCell.h"
#import <SDWebImage/UIImageView+WebCache.h>


@interface HWProjectDetailViewController ()<UITableViewDataSource, UITableViewDelegate>
@property(nonatomic, strong)UITableView* detailTableView;
@property(nonatomic, strong)Project* project;
@property(nonatomic, strong)NSArray* optionTittleArray;
@property(nonatomic, strong)NSArray* optionImageArray;
@end

@implementation HWProjectDetailViewController

- (instancetype)initWithProject:(Project*)project {
    
    self = [super init];
    if (self) {
        _project = project;
    }
    return self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"项目首页";
    self.tabBarController.tabBar.hidden = true;
    [self setTabView];
    
}

- (void)setTabView {
    
    _detailTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64) style:UITableViewStyleGrouped];
    _detailTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _detailTableView.dataSource = self;
    _detailTableView.delegate = self;
    [_detailTableView registerNib:[UINib nibWithNibName:@"HWProjectDetailCell" bundle:nil] forCellReuseIdentifier:@"detail"];
    [_detailTableView registerClass:[HWProjectDescriptionCell class] forCellReuseIdentifier:@"description"];
    [self.view addSubview:_detailTableView];
    
    _optionTittleArray = @[@"动态",@"讨论",@"代码",@"成员",@"README",@"Pull Request"];
    _optionImageArray = @[@"project_item_activity",@"project_item_topic",@"project_item_code",@"project_item_member",@"project_item_readme",@"project_item_mr_pr"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell* cell = NULL;
    NSString* urlString = NULL;
    
    if ([self.project.icon hasPrefix:@"http"]) {
        urlString = self.project.icon;
    } else {
        urlString = [NSString stringWithFormat:@"https://coding.net%@",self.project.icon];
    }
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            
            HWProjectDetailCell* detailCell = [tableView dequeueReusableCellWithIdentifier:@"detail"];
            [detailCell.projectImageView sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"logo_coding"]];
            detailCell.projectNameLabel.text = [NSString stringWithFormat:@"%@/%@",self.project.ownerUserName,self.project.name];
            
            if (self.project.parentDepotPath != NULL) {
                
                NSString* textString = [NSString stringWithFormat:@"Fork 自 %@",self.project.parentDepotPath];
                NSMutableAttributedString* attrString = [[NSMutableAttributedString alloc] initWithString:textString];
                NSRange range1 = NSMakeRange(0, [@"Fork 自 " length]);
                NSRange range2 = [textString rangeOfString:self.project.parentDepotPath];
                [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:196/255.0 green:196/255.0 blue:196/255.0 alpha:1] range:range1];
                [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:112/255.0 green:210/255.0 blue:161/255.0 alpha:1] range:range2];
                detailCell.sourceLabel.attributedText = attrString;
                
            } else {
                detailCell.sourceLabel.text = self.project.ownerUserName;
                detailCell.sourceLabel.textColor = [UIColor colorWithRed:112/255.0 green:210/255.0 blue:161/255.0 alpha:1];
            }
            
            detailCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell = detailCell;
            
        } else {
            HWProjectDescriptionCell* desCell = [tableView dequeueReusableCellWithIdentifier:@"description"];
            if (desCell == NULL) {
                NSLog(@"11");
            }
            NSString* desString = NULL;
            if ([self.project.des isEqualToString:@""]) {
                desString = @"未填写";
            } else {
                desString = self.project.des;
            }
            desCell.descriptionLabel.text = desString;
            cell = desCell;
        }
    }
    
    if (indexPath.section == 1) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"normal"];
        if (cell == NULL) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"normal"];
        }
        cell.imageView.image = [UIImage imageNamed:self.optionImageArray[indexPath.row]];
        cell.textLabel.text = self.optionTittleArray[indexPath.row];
    }
    
    if (indexPath.section == 2) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"normal"];
        if (cell == NULL) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"normal"];
        }
        cell.imageView.image = [UIImage imageNamed:self.optionImageArray[indexPath.row + 4]];
        cell.textLabel.text = self.optionTittleArray[indexPath.row + 4];
    }
    return cell;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return 0;
    }
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        if (indexPath.row == 1) {
            return self.project.cellHeight;
        }
        return 80;
    }
    return 40;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 1)
        return 4;
    return 2;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

@end
