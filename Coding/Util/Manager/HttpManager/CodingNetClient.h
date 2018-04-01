//
//  CodingNetClient.h
//  Coding
//
//  Created by 黄文海 on 2018/3/13.
//  Copyright © 2018年 huang. All rights reserved.
//

#import "AFHTTPSessionManager.h"

typedef enum {
    Get = 0,
    Post,
    Put,
    Delete
} NetworkMethod;

@interface CodingNetClient : AFHTTPSessionManager

+ (CodingNetClient *)sharedJsonClient;

- (void)requestJsonDataWithPath:(NSString*)path
                         Params:(NSDictionary*)params
                 withMethodType:(NetworkMethod)method
                  autoShowError:(BOOL)autoShowError
                       andBlock:(void(^)(id data, NSError *error)) block;
@end
