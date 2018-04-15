//
//  HWBannerModel.h
//  Coding
//
//  Created by 黄文海 on 2018/4/9.
//  Copyright © 2018年 huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWBannerModel : NSObject
@property(nonatomic, copy)NSString* code;
@property(nonatomic, copy)NSString* created_at;
@property(nonatomic, copy)NSString* image;
@property(nonatomic, copy)NSString* link;
@property(nonatomic, copy)NSString* name;
@property(nonatomic, assign)NSUInteger sort;
@property(nonatomic, assign)NSUInteger status;
@property(nonatomic, copy)NSString* title;
@property(nonatomic, copy)NSString* updated_at;
@end

@interface HWBannerList : NSObject
@property(nonatomic, copy)NSArray* data;
@property(nonatomic, assign)NSInteger code;
@end
