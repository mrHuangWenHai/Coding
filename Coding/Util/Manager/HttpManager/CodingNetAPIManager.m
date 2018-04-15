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























@end
