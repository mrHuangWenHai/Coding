//
//  CodingNetAPIManager.m
//  Coding
//
//  Created by 黄文海 on 2018/3/13.
//  Copyright © 2018年 huang. All rights reserved.
//

#import "CodingNetAPIManager.h"
#import "CodingNetClient.h"
#import "HWProjectModel.h"
#import "MJExtension.h"
#import "ProjectCount.h"
#import "HWTaskModel.h"
#import "HWBannerModel.h"
#import "Tweet.h"
#import "MessageModel.h"
#import "UserServiceInfo.h"
#import "HWGitModel.h"

@implementation CodingNetAPIManager

+ (instancetype)sharedManager {
    static CodingNetAPIManager *shared_manager = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        shared_manager = [[self alloc] init];
    });
    return shared_manager;
}

- (void)requestLoginWithPath:(NSString *)path Params:(id)params andBlock:(void (^)(id, NSError *))block {
    [[CodingNetClient sharedJsonClient] requestJsonDataWithPath:path Params:params withMethodType:Post autoShowError:NO andBlock:^(id data, NSError *error) {
        block(data, error);
    }];
}

- (void)requestProjectMessageWithPath:(NSString *)Path Params:(id)params andBlock:(void(^)(id response, NSError*))block {
    [[CodingNetClient sharedJsonClient] requestJsonDataWithPath:Path Params:params withMethodType:Get autoShowError:NO andBlock:^(id data, NSError *error) {
        if (data == NULL) {
            block(NULL,error);
        } else {
            NSDictionary* dataDictionary = (NSDictionary*)[data valueForKey:@"data"];
            HWProjectModel* projectModel = [HWProjectModel mj_objectWithKeyValues:dataDictionary];
            projectModel.list = [self sortProject:projectModel.list];
            block(projectModel,NULL);
        }
       
    }];
}

- (NSArray*)sortProject:(NSArray*)projectArray {
   return [projectArray sortedArrayUsingComparator:^NSComparisonResult(Project* obj1, Project* obj2) {
        return obj1.pin < obj2.pin;
    }];
}

- (void)requestProjectCountsWithCompleteBlock:(void(^)(ProjectCount* response, NSError* error))block {
    [[CodingNetClient sharedJsonClient] requestJsonDataWithPath:@"api/project_count" Params:nil withMethodType:Get autoShowError:NO andBlock:^(id data, NSError *error) {
        if (data) {
            NSDictionary* dataDictionary = (NSDictionary*)[data valueForKey:@"data"];
            ProjectCount* projectCount = [ProjectCount mj_objectWithKeyValues:dataDictionary];
            block(projectCount,NULL);
        } else {
            block(NULL, error);
        }
    }];
}

- (void)requestProjectsHaveTasksWithCompleteBlock:(void(^)(HWProjectModel* projectModel, NSError* error))block {
    NSDictionary* params = @{
                             @"page":@"1",
                             @"pageSize":@"99999999",
                             @"sort":@"hot",
                             @"type":@"all"
                             };
    [[CodingNetClient sharedJsonClient] requestJsonDataWithPath:@"api/projects" Params:params withMethodType:Get autoShowError:NO andBlock:^(id data, NSError *error) {
        if (data) {
            NSDictionary* dataDictionary = (NSDictionary*)[data valueForKey:@"data"];
            HWProjectModel* projectModel = [HWProjectModel mj_objectWithKeyValues:dataDictionary];
            
            [[CodingNetClient sharedJsonClient] requestJsonDataWithPath:@"api/tasks/projects/count" Params:nil withMethodType:Get autoShowError:NO andBlock:^(id datatasks, NSError *error) {
                if (datatasks) {
                    NSMutableArray* list = [[NSMutableArray alloc] initWithCapacity:projectModel.list.count];
                    NSArray *taskProArray = [datatasks objectForKey:@"data"];
                    for (NSDictionary* dict in taskProArray) {
                        for (Project* project in projectModel.list) {
                            if (project.userId.integerValue == ((NSNumber *)[dict objectForKey:@"project"]).intValue) {
                                [list addObject:project];
                            }
                        }
                    }
                    projectModel.list = list;
                    block(projectModel, nil);
                } else {
                    block(nil, error);
                }
            }];
        } else {
            block(nil, error);
        }
    }];
}

- (void)requestTasksSearchWithParams:(NSDictionary*)params CompleteBlock:(void(^)(HWTaskModel* taskModel, NSError* error))block {
    [[CodingNetClient sharedJsonClient] requestJsonDataWithPath:@"api/tasks/search" Params:params withMethodType:Get autoShowError:NO andBlock:^(id data, NSError *error) {
        
        if (data) {
            NSDictionary* dataDictionary = (NSDictionary*)[data valueForKey:@"data"];
            HWTaskModel* taskModel = [HWTaskModel mj_objectWithKeyValues:dataDictionary];
            NSLog(@"%@",data);
            block(taskModel, NULL);
        } else {
            block(NULL, error);
        }
    }];
}

- (void)requestBannersWithBlock:(void (^)(id, NSError *))block {
    
    [[CodingNetClient sharedJsonClient] requestJsonDataWithPath:@"api/banner/type/app" Params:nil withMethodType:Get autoShowError:NO andBlock:^(id data, NSError *error) {
        if (data) {
            HWBannerList* bannerList = [HWBannerList mj_objectWithKeyValues:data];
            block(bannerList, NULL);
        } else {
            block(nil, error);
        }
    }];
}

- (void)requestTweetsWithComplectionBlock:(void (^)(id data, NSError *))block {
    NSString* path = @"api/tweet/public_tweets";
    NSDictionary* params = @{@"sort":@"time"};
    [[CodingNetClient sharedJsonClient] requestJsonDataWithPath:path Params:params withMethodType:Get autoShowError:NO andBlock:^(id data, NSError *error) {
        if (data) {
            Tweets* tweets = [Tweets mj_objectWithKeyValues:data];
            block(tweets, NULL);
        } else {
            block(nil, error);
        }
    }];
}

- (void)requestUnReadTotalNotificationWithBlock:(void(^)(id data, NSError *error))block {
    [[CodingNetClient sharedJsonClient] requestJsonDataWithPath:@"api/notification/unread-count" Params:nil withMethodType:Get autoShowError:true andBlock:^(id data, NSError *error) {
        block(data, error);
    }];
}

- (void)requestUnReadNotificationsWithBlock:(void(^)(id data, NSError *error))block {
    
    NSMutableDictionary *notificationDict = [[NSMutableDictionary alloc] init];
    
    [[CodingNetClient sharedJsonClient] requestJsonDataWithPath:@"api/notification/unread-count" Params:@{@"type" : @(0)} withMethodType:Get autoShowError:true andBlock:^(id data, NSError *error) {
        if (data) {
            NSLog(@"%@",data);
            [notificationDict setObject:[data valueForKeyPath:@"data"] forKey:@"notification_at"];
            [[CodingNetClient sharedJsonClient] requestJsonDataWithPath:@"api/notification/unread-count?type=1&type=2" Params:nil withMethodType:Get autoShowError:true andBlock:^(id dataComment, NSError *errorComment) {
                if (dataComment) {
                    [notificationDict setObject:[dataComment valueForKeyPath:@"data"] forKey:@"notification_comment"];
                    [[CodingNetClient sharedJsonClient] requestJsonDataWithPath:@"api/notification/unread-count?type=4&type=6" Params:nil withMethodType:Get autoShowError:true andBlock:^(id dataSystem, NSError *errorSystem) {
                        if (dataSystem) {
                            [notificationDict setObject:[dataSystem valueForKeyPath:@"data"] forKey:@"notification_system"];
                            block(notificationDict, nil);
                        } else {
                            block(nil, errorSystem);
                        }
                    }];

                } else {
                    block(nil,errorComment);
                }
            }];

        } else {
            block(nil, error);
        }
    }];
}

- (void)requestMessageWithParam:(NSDictionary*)param andBlock:(void (^)(MessageModel* messageModel, NSError *error))block {
    [[CodingNetClient sharedJsonClient] requestJsonDataWithPath:@"api/message/conversations" Params:param withMethodType:Get autoShowError:true andBlock:^(id data, NSError *error) {
        NSLog(@"%@",data);
        if (data) {
            NSDictionary* dataDictionary = (NSDictionary*)[data valueForKey:@"data"];
            MessageModel* messageModel = [MessageModel mj_objectWithKeyValues:dataDictionary];
            block(messageModel, nil);
        } else {
            block(nil, error);
        }
    }];
}

- (void)requestServiceInfoBlock:(void(^)(UserServiceInfo* userServiceInfo, NSError *error))block {
    [[CodingNetClient sharedJsonClient] requestJsonDataWithPath:@"api/user/service_info" Params:nil withMethodType:Get autoShowError:true andBlock:^(id data, NSError *error) {
        if (data) {
            UserServiceInfo* userServiceInfo = [UserServiceInfo mj_objectWithKeyValues:(NSDictionary*)data[@"data"]];
            block(userServiceInfo, nil);
        } else {
            block(nil, error);
        }
    }];
}

- (void)requestProjectGitMessageWithUrl:(NSString*)url andCallback:(void(^)(id gitMessage, NSError* error))block {
    [[CodingNetClient sharedJsonClient] requestJsonDataWithPath:url Params:nil withMethodType:Get autoShowError:true andBlock:^(id data, NSError *error) {
        if (data) {
            HWGitModel* gitModel = [HWGitModel mj_objectWithKeyValues:data];
            block(gitModel, nil);
        } else {
            block(nil, error);
        }
    }];
}


@end
