//
//  HWProjectModel.m
//  Coding
//
//  Created by 黄文海 on 2018/3/15.
//  Copyright © 2018年 huang. All rights reserved.
//

#import "HWProjectModel.h"
#import "MJExtension.h"
#import <UIKit/UIKit.h>

@implementation Project

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"userId":@"id",
             @"backendProjectPath":@"backend_project_path",
             @"createdAt":@"created_at",
             @"emailValidation":@"email_validation",
             @"fansCount":@"fans_count",
             @"followsCount":@"follows_count",
             @"globalKey":@"global_key",
             @"isMember":@"is_member",
             @"isPhoneValidated":@"is_phone_validated",
             @"lastActivityAt":@"last_activity_at",
             @"lastLoginedAt":@"last_logined_at",
             @"namePinyin":@"name_pinyin",
             @"phoneCountryCode":@"phone_country_code",
             @"phoneValidation":@"phone_validation",
             @"pointsLeft":@"points_left",
             @"tagsStr":@"tags_str",
             @"tweetsCount":@"tweets_count",
             @"twofaEnabled":@"twofa_enabled",
             @"updatedAt":@"updated_at",
             @"des":@"description",
             @"forkCount":@"fork_count",
             @"gitUrl":@"git_url",
             @"httpsUrl":@"https_url",
             @"isPublic":@"is_public",
             @"maxMember":@"max_member",
             @"ownerId":@"owner_id",
             @"ownerUserHome":@"owner_user_home",
             @"ownerUserName":@"owner_user_name",
             @"ownerUserPicture":@"owner_user_picture",
             @"projectPath":@"project_path",
             @"sshUrl":@"ssh_url",
             @"starCount":@"star_count",
             @"svnUrl":@"svn_url",
             @"unReadActivitiesCount":@"un_read_activities_count",
             @"updatedAt":@"updated_at",
             @"watchCount":@"watch_count",
             @"parentDepotPath":@"parent_depot_path"
             };
}

- (float)cellHeight {
    
    NSString* descriptionOfProject;
    if (_cellHeight == 0) {
        if ([self.des isEqualToString:@""]) {
            descriptionOfProject = @"未填写";
        } else {
            descriptionOfProject = self.des;
        }
        _cellHeight = [self heightForString:descriptionOfProject andWidth:[UIScreen mainScreen].bounds.size.width - 16];
    }
    
    return _cellHeight + 20;
}

- (float)heightForString:(NSString*)value andWidth:(float)width {
    NSMutableAttributedString* attrStr = [[NSMutableAttributedString alloc] initWithString:value];
    NSRange range = NSMakeRange(0, attrStr.length);
    UIFont *font = [UIFont systemFontOfSize:15];
    [attrStr addAttribute:NSFontAttributeName value:font range:range];
    NSDictionary* dic = [attrStr attributesAtIndex:0 effectiveRange:&range];
    CGSize sizeToFit = [value boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                           options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                        attributes:dic
                                           context:nil].size;
    return sizeToFit.height;
}

@end

@implementation HWProjectModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{ @"list" : @"Project"};
}


@end
