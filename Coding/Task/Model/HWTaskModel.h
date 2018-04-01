//
//  HWTaskModel.h
//  Coding
//
//  Created by 黄文海 on 2018/3/27.
//  Copyright © 2018年 huang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    Create,
    Show
} TaskStatus;

@interface User : NSObject
@property(nonatomic, copy)NSString* location,*company,*slogan,*website,*introduction,*avatar,*gravatar,*lavatar,*created_at,*last_logined_at,
    *global_key,*name,*name_pinyin,*updated_at,*path,*status,*is_member,*userId,*school;
@property(nonatomic, assign)NSInteger sex,vip,degree,follows_count,fans_count,tweets_count;
@property(nonatomic, assign)BOOL followed,follow;
@end

@interface Task : NSObject
@property(nonatomic, copy)NSString* messageId;
@property(nonatomic, assign)NSInteger number;
@property(nonatomic, copy)NSString* owner_id;
@property(nonatomic, copy)NSString* creator_id;
@property(nonatomic, copy)NSString* project_id;
@property(nonatomic, assign)NSInteger created_at;
@property(nonatomic, strong)NSDate* updated_at;
@property(nonatomic, assign)NSInteger status;
@property(nonatomic, copy)NSString* content;
@property(nonatomic, copy)NSString* has_description;
@property(nonatomic, assign)NSInteger priority;
@property(nonatomic, assign)NSInteger comments;
@property(nonatomic, assign)BOOL watch;
@property(nonatomic, copy)NSArray* labels;
@property(nonatomic, copy)NSString* current_user_role_id;
@property(nonatomic, strong)User* user;
@end

@interface HWTaskModel : NSObject
@property(nonatomic, copy)NSArray* list;
@property(nonatomic, assign)NSInteger page;
@property(nonatomic, assign)NSInteger pageSize;
@property(nonatomic, assign)NSInteger totalPage;
@property(nonatomic, assign)NSInteger totalRow;
@property(nonatomic, assign)NSInteger processing;
@property(nonatomic, assign)BOOL finished;
@end
