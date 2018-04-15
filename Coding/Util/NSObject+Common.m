//
//  NSObject+Common.m
//  Coding
//
//  Created by 黄文海 on 2018/4/11.
//  Copyright © 2018年 huang. All rights reserved.
//


#define kBaseURLStr @"https://coding.net/"

#import "NSObject+Common.h"
#import "Login.h"
#import "AppDelegate.h"

@implementation NSObject (Common)
+ (NSString *)baseURLStr{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults valueForKey:kBaseURLStr] ?: kBaseURLStr;
}

@end

