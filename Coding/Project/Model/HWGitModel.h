//
//  HWGitModel.h
//  Coding
//
//  Created by 黄文海 on 2018/6/2.
//  Copyright © 2018年 huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GitProject:NSObject
@property(nonatomic, copy)NSString* path;
@property(nonatomic, copy)NSString* full_name;
@property(nonatomic, copy)NSString* name;
@end

@interface GitUser:NSObject
@property(nonatomic, copy)NSString* path;
@property(nonatomic, copy)NSString* global_key;
@property(nonatomic, copy)NSString* name;
@property(nonatomic, copy)NSString* avatar;
@end

@interface GitMessage : NSObject
@property(nonatomic, copy)NSString* target_type;
@property(nonatomic, strong)GitProject* gitProject;
@property(nonatomic, copy)NSString* action;
@property(nonatomic, assign)NSInteger created_at;
@property(nonatomic, assign)NSInteger gitId;
@property(nonatomic, strong)GitUser* user;
@property(nonatomic, copy)NSString* action_msg;
@end


@interface HWGitModel : NSObject
@property(nonatomic, assign)int code;
@property(nonatomic, strong)NSArray* data;
@property(nonatomic, strong)NSMutableArray* dataGroup;
@end
