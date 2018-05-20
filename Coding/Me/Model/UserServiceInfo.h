//
//  UserServiceInfo.h
//  Coding
//
//  Created by 黄文海 on 2018/5/12.
//  Copyright © 2018年 huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserServiceInfo : NSObject
@property(nonatomic, strong)NSString* balance ,*point_left;
@property (strong, nonatomic)NSString *pri, *pub, *team;
@property (strong, nonatomic) NSString *private_project_quota, *public_project_quota;
@end
