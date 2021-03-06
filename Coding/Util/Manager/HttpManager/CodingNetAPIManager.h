//
//  CodingNetAPIManager.h
//  Coding
//
//  Created by 黄文海 on 2018/3/13.
//  Copyright © 2018年 huang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ProjectCount;
@class HWProjectModel;
@class HWTaskModel;
@class MessageModel;
@class UserServiceInfo;

@interface CodingNetAPIManager : NSObject

+ (instancetype)sharedManager;

- (void)requestLoginWithPath:(NSString*)path Params:(id)params andBlock:(void (^)(id data, NSError* error))block;

- (void)requestProjectMessageWithPath:(NSString *)Path Params:(id)params andBlock:(void(^)(id response, NSError* error))block;

- (void)requestProjectCountsWithCompleteBlock:(void(^)(ProjectCount* response, NSError* error))block;

- (void)requestProjectsHaveTasksWithCompleteBlock:(void(^)(HWProjectModel* projectModel, NSError* error))block;

- (void)requestTasksSearchWithParams:(NSDictionary*)params CompleteBlock:(void(^)(HWTaskModel* taskModel, NSError* error))block;

- (void)requestBannersWithBlock:(void(^)(id data, NSError* error))block;

- (void)requestTweetsWithComplectionBlock:(void (^)(id data, NSError* error))block;

- (void)requestUnReadNotificationsWithBlock:(void(^)(id data, NSError *error))block;

- (void)requestMessageWithParam:(NSDictionary*)param andBlock:(void (^)(MessageModel* messageModel, NSError *error))block;

- (void)requestUnReadTotalNotificationWithBlock:(void(^)(id data, NSError *error))block;

- (void)requestServiceInfoBlock:(void(^)(UserServiceInfo* userServiceInfo, NSError *error))block;

- (void)requestProjectGitMessageWithUrl:(NSString*)url andCallback:(void(^)(id gitMessage, NSError* error))block;

@end
