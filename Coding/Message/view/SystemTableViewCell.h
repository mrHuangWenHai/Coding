//
//  SystemTableViewCell.h
//  Coding
//
//  Created by 黄文海 on 2018/5/6.
//  Copyright © 2018年 huang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SystemTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *headImageView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;

@property (strong, nonatomic) IBOutlet UILabel *contentLabel;
@end
