//
//  Login.m
//  Coding
//
//  Created by 黄文海 on 2018/3/11.
//  Copyright © 2018年 huang. All rights reserved.
//

#import "Login.h"
#import "HWTaskModel.h"
#import "MJExtension.h"


static User* user;

@implementation Login

+ (BOOL) isLogin {
    return true;
}

+ (User*) getCurUser {
    if (!user) {
        NSDictionary* userDictionary = [[NSUserDefaults standardUserDefaults] valueForKey:@"userDict"];
        user = [User mj_objectWithKeyValues:userDictionary];
    }
    return user;
}
@end
