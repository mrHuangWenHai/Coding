//
//  HWTextCell.h
//  Coding
//
//  Created by 黄文海 on 2018/3/30.
//  Copyright © 2018年 huang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HWTextCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *textImageView;

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;

@property (strong, nonatomic) IBOutlet UILabel *statusLabel;
@end
