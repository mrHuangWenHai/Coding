//
//  Tweet.h
//  Coding
//
//  Created by 黄文海 on 2018/4/11.
//  Copyright © 2018年 huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "HWTaskModel.h"
#import "HtmlMedia.h"
#import "HWProjectModel.h"
#import "Comment.h"


@class TweetImage;

@interface Tweet : NSObject
@property (readwrite, nonatomic, strong) NSString *content, *device, *location, *coord, *address;
@property(nonatomic, assign)BOOL liked,rewarded;
@property (readwrite, nonatomic, assign)NSInteger activity_id, uid, comments, likes, rewards;
@property (readwrite, nonatomic, assign) NSInteger created_at, sort_time;
@property (readwrite, nonatomic, strong) User *owner;
@property (readwrite, nonatomic, strong) NSMutableArray *comment_list, *like_users, *reward_users;
@property (readwrite, nonatomic, strong) NSDictionary *propertyArrayMap;
@property (assign, nonatomic) BOOL canLoadMore, willLoadMore, isLoading;
@property (readwrite, nonatomic, strong) HtmlMedia *htmlMedia;
//@property (nonatomic,strong) TweetSendLocationResponse *locationData;

@property (readwrite, nonatomic, strong) NSMutableArray *tweetImages;//对 selectedAssetURLs 操作即可，最好不要直接赋值。。应用跳转带的图片会直接对 tweetImages赋值
@property (readwrite, nonatomic, strong) NSMutableArray *selectedAssetLocalIdentifiers;
@property (readwrite, nonatomic, strong) NSString *tweetContent;
@property (readwrite, nonatomic, strong) NSString *nextCommentStr;
@property (strong, nonatomic) NSString *callback;
@property (assign, nonatomic) CGFloat contentHeight;

@property (strong, nonatomic) NSString *user_global_key;
@property (strong, nonatomic) Project *project;
@property (strong, nonatomic) NSNumber *project_id;
@property(nonatomic, assign)CGFloat totalHeight;
@property(nonatomic, assign)CGFloat textHeight;
@property(nonatomic, assign)CGFloat imageHeight;
@property(nonatomic, assign)CGFloat leaveMessageHeight;
@property(nonatomic, assign)CGFloat contentMessageHeight;
@property(nonatomic, assign)BOOL isFinshImageLoad;

+ (CGFloat)getDefaultLeftSpare;

@end

@interface Tweets : NSObject
@property(nonatomic, copy)NSArray* data;
@property(nonatomic, assign)NSInteger code;
@end


typedef NS_ENUM(NSInteger, TweetImageUploadState)
{
    TweetImageUploadStateInit = 0,
    TweetImageUploadStateIng,
    TweetImageUploadStateSuccess,
    TweetImageUploadStateFail
};

typedef NS_ENUM(NSInteger, TweetImageDownloadState)
{
    TweetImageDownloadStateInit = 0,
    TweetImageDownloadStateIng,
    TweetImageDownloadStateSuccess,
    TweetImageDownloadStateFail
};

@interface TweetImage : NSObject
@property (readwrite, nonatomic, strong) UIImage *image, *thumbnailImage;
@property (strong, nonatomic) NSString *assetLocalIdentifier;
@property (assign, nonatomic) TweetImageUploadState uploadState;
@property (assign, nonatomic) TweetImageDownloadState downloadState;
@property (readwrite, nonatomic, strong) NSString *imageStr;
@end

