//
//  Login.h
//  Coding
//
//  Created by 黄文海 on 2018/3/11.
//  Copyright © 2018年 huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class User;

@interface Login : NSObject

+ (BOOL) isLogin;

+ (User*) getCurUser;
@end
