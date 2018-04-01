//
//  HWProjectTableViewCell.h
//  Coding
//
//  Created by 黄文海 on 2018/3/14.
//  Copyright © 2018年 huang. All rights reserved.
//

#import "SWTableViewCell.h"
#import "HWProjectModel.h"

@interface HWProjectTableViewCell : SWTableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *projectImageView;
@property (strong, nonatomic) IBOutlet UILabel *projectLabel;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (strong, nonatomic) IBOutlet UILabel *ownerUserNameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *pinImageView;
@property (strong, nonatomic) Project* project;
@end
