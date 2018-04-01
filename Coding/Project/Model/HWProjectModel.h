//
//  HWProjectModel.h
//  Coding
//
//  Created by 黄文海 on 2018/3/15.
//  Copyright © 2018年 huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Project : NSObject
@property(nonatomic, copy)NSString* backendProjectPath;
@property(nonatomic, copy)NSString* createdAt;
@property(nonatomic, copy)NSString* currentUserRole;
@property(nonatomic, copy)NSString* currentUserRoleId;
@property(nonatomic, copy)NSString* depotPath;
@property(nonatomic, copy)NSString* des;
@property(nonatomic, assign)NSInteger forkCount;
@property(nonatomic, assign)NSInteger forked;
@property(nonatomic, copy)NSString* gitUrl;
@property(nonatomic, copy)NSString* groupId;
@property(nonatomic, copy)NSString* httpsUrl;
@property(nonatomic, copy)NSString* icon;
@property(nonatomic, copy)NSString* userId;
@property(nonatomic, assign)BOOL isTeam;
@property(nonatomic, assign)BOOL isPublic;
@property(nonatomic, assign)NSInteger maxMember;
@property(nonatomic, copy)NSString* name;
@property(nonatomic, copy)NSString* ownerId;
@property(nonatomic, copy)NSString* ownerUserHome;
@property(nonatomic, copy)NSString* ownerUserName;
@property(nonatomic, copy)NSString* ownerUserPicture;
@property(nonatomic, copy)NSString* parentDepotPath;
@property(nonatomic, assign)NSInteger pin;
@property(nonatomic, assign)NSInteger plan;
@property(nonatomic, copy)NSString* projectPath;
@property(nonatomic, assign)NSString* recommended;
@property(nonatomic, copy)NSString* sshUrl;
@property(nonatomic, assign)NSInteger starCount;
@property(nonatomic, assign)NSInteger stared;
@property(nonatomic, assign)NSInteger status;
@property(nonatomic, copy)NSString* svnUrl;
@property(nonatomic, assign)NSInteger type;
@property(nonatomic, assign)NSInteger unReadActivitiesCount;
@property(nonatomic, assign)NSInteger updatedAt;
@property(nonatomic, assign)NSInteger watchCount;
@property(nonatomic, assign)NSInteger watched;
@property(nonatomic, assign)float cellHeight;
@property(nonatomic, assign)NSInteger done;
@property(nonatomic, assign)NSInteger processing;

@end

@interface HWProjectModel : NSObject
@property(nonatomic, copy)NSArray* list;
@property(nonatomic, assign)NSInteger page;
@property(nonatomic, assign)NSInteger pageSize;
@property(nonatomic, assign)NSInteger totalPage;
@property(nonatomic, assign)NSInteger totalRow;
@end
