//
//  CodingNetClient.m
//  Coding
//
//  Created by 黄文海 on 2018/3/13.
//  Copyright © 2018年 huang. All rights reserved.
//

#import "CodingNetClient.h"

@implementation CodingNetClient

+ (CodingNetClient *)sharedJsonClient {
    static CodingNetClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[CodingNetClient alloc] initWithBaseURL:[NSURL URLWithString:@"https://coding.net"]];
        [_sharedClient.requestSerializer setHTTPShouldHandleCookies:true];
        
    });
    return _sharedClient;
}

- (void)requestJsonDataWithPath:(NSString*)path
                         Params:(NSDictionary*)params
                 withMethodType:(NetworkMethod)method
                  autoShowError:(BOOL)autoShowError
                       andBlock:(void(^)(id data, NSError *error)) block {
    

    
    for (NSHTTPCookie *tempC in [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]) {
        if ([tempC.name isEqualToString:@"XSRF-TOKEN"]) {
        }
        NSLog(@"%@ , %@",tempC.value,tempC.name);
    }
    
    switch (method) {
        case Get:{
            
            NSString* sid = @"sid=c566ac28-7224-43b0-9ff3-f6293c6c71f9";
            [self.requestSerializer setValue:sid forHTTPHeaderField:@"Cookie"];
            
            [self GET:path parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"%@",responseObject);
                NSLog(@"%@",[[responseObject valueForKey:@"msg"] valueForKey:@"user_not_login"]);
                block(responseObject,NULL);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                block(NULL, error);
            }];
            break;
        }
        case Post:{
            [self POST:path parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"%@",responseObject);
                NSError* error = [self handleResponse:responseObject autoShowError:autoShowError path:path];
                block(responseObject, error);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"%@",error);
            }];
            break;
        }
        default:
            break;
    }
    
    
}

- (id)handleResponse:(id)responseJSON autoShowError:(BOOL)autoShowError path:(NSString*)path{
    NSError* error = nil;
    NSInteger errorcode = [(NSNumber*)[responseJSON valueForKey:@"code"] integerValue];
    if (errorcode != 0) {
        error = [NSError errorWithDomain:path code:errorcode userInfo:responseJSON];
    }
    return error;
}

@end
