//
//  Tweet.m
//  Coding
//
//  Created by 黄文海 on 2018/4/11.
//  Copyright © 2018年 huang. All rights reserved.
//

#import "Tweet.h"
#import "NSString+Common.h"

static Tweet *_tweetForSend = nil;

@implementation Tweet
@synthesize imageHeight = _imageHeight;
+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"comment_list":@"Comment",
             @"like_users":@"User",
             @"reward_users":@"User"
             };
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"uid":@"id"
            };
}

+ (CGFloat)getDefaultLeftSpare {
    return 18;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _propertyArrayMap = [NSDictionary dictionaryWithObjectsAndKeys:
                             @"Comment", @"comment_list",
                             @"User", @"like_users",
                             @"User", @"reward_users", nil];
        _canLoadMore = YES;
        _isLoading = _willLoadMore = NO;
        _contentHeight = 1;
    }
    return self;
}


- (void)setContent:(NSString *)content {
    if (_content != content) {
        _htmlMedia = [HtmlMedia htmlMediaWithString:content showType:MediaShowTypeNone];
        _content = _htmlMedia.contentDisplay;
    }
}

- (CGFloat)textHeight {
    if (_textHeight == 0 && self.content.length != 0) {
        
        CGFloat width = [UIScreen mainScreen].bounds.size.width - 2 * [self.class getDefaultLeftSpare];
        _textHeight = [self.content boundingRectWithSize:CGSizeMake(width, MAXFLOAT) font:[UIFont systemFontOfSize:16] lineSpacing:0 maxLines:10];
        return _textHeight;
    }
    return _textHeight;
}

- (CGFloat)imageHeight {
    if (_imageHeight == 0 && !self.isFinshImageLoad) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width - [self.class getDefaultLeftSpare] * 2;
        switch (self.htmlMedia.imageItems.count) {
            case 0:
                _imageHeight = 0;
                self.isFinshImageLoad = true;
                break;
            case 1:
                _imageHeight = (width - 10) / 3;
                break;
            case 2:
            case 3:
                _imageHeight = (width - 10) / 3;
                self.isFinshImageLoad = true;
                break;
            case 4:
            case 5:
            case 6:
                _imageHeight = ((width - 10) / 3) * 2 + 5;
                self.isFinshImageLoad = true;
                break;
            default:
                break;
        }
    }
    return _imageHeight;
}

- (void)setImageHeight:(CGFloat)imageHeight {
    _totalHeight = 0;
    _imageHeight = imageHeight;
    [self totalHeight];
}


- (CGFloat)totalHeight {
    
    if (_totalHeight == 0) {
        _totalHeight = 0;
        CGFloat textHeight = self.textHeight;
        _totalHeight += textHeight;
        _totalHeight += self.imageHeight;
        _totalHeight += 70;
        if (self.content.length > 0) {
            _totalHeight += 10;
        }
        
        if (self.htmlMedia.imageItems.count > 0) {
            _totalHeight += 10;
        }
        
        _totalHeight += 10;
        _totalHeight += self.leaveMessageHeight;
        

        
    }
    return _totalHeight;
}

- (CGFloat)contentMessageHeight {
    if (_contentMessageHeight == 0 && self.comment_list.count > 0) {
        _contentMessageHeight = self.comment_list.count * 50;
        if (self.comments > 5) {
            _contentMessageHeight += 30;
        }
    }
    return _contentMessageHeight;
}

- (CGFloat)leaveMessageHeight {
    
    if (_leaveMessageHeight == 0) {
        _leaveMessageHeight = 47;
        
        CGFloat locationSpare = 0;
        if (self.location.length > 0) {
            _leaveMessageHeight += 20;
            locationSpare = 5;
         }
        
        if (self.device.length > 0) {
            _leaveMessageHeight += (locationSpare + 20);
         }
        
        if (self.like_users.count > 0) {
            _leaveMessageHeight += 35 + 7 + 5 + 5;
        }
        
        _leaveMessageHeight += self.contentMessageHeight;
    }
    
    return _leaveMessageHeight;
}

- (NSString *)address{
    if (!_address || _address.length == 0) {
        return @"未填写";
    }else{
        return _address;
    }
}

//- (NSInteger)numOfComments{
//    return MIN(_comment_list.count +1,
//               MIN(_comments.intValue,
//                   6));
//}
//- (BOOL)hasMoreComments{
//    return (_comments.intValue > _comment_list.count || _comments.intValue > 5);
//}
//
//- (NSArray *)like_reward_users{
//    NSMutableArray *like_reward_users = _like_users.count > 0? _like_users.mutableCopy: @[].mutableCopy;//点赞的人多，用点赞的人列表做基
//    [_reward_users enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(User *obj, NSUInteger idx, BOOL *stop) {
//        __block NSInteger originalIndex = NSNotFound;
//        [like_reward_users enumerateObjectsUsingBlock:^(User *obj_, NSUInteger idx_, BOOL *stop_) {
//            if ([obj.global_key isEqualToString:obj_.global_key]) {
//                originalIndex = idx_;
//            }
//        }];
//        if (originalIndex != NSNotFound) {
//            [like_reward_users exchangeObjectAtIndex:originalIndex withObjectAtIndex:0];
//        }else{
//            [like_reward_users insertObject:obj atIndex:0];
//        }
//    }];
//    return like_reward_users;
//}
//- (BOOL)hasLikesOrRewards{
//    return (_likes.integerValue + _rewards.integerValue) > 0;
//}
//- (BOOL)hasMoreLikesOrRewards{
//    return (_like_users.count + _reward_users.count == 10 && _likes.integerValue + _rewards.integerValue > 10);
//    //    return (_likes.integerValue > _like_users.count || _rewards.integerValue > _reward_users.count);
//}
//- (BOOL)rewardedBy:(User *)user{
//    for (User *obj in _reward_users) {
//        if ([obj.global_key isEqualToString:user.global_key]) {
//            return YES;
//        }
//    }
//    return NO;
//}
//
//- (NSString *)toDoLikePath{
//    NSString *doLikePath;
//    doLikePath = [NSString stringWithFormat:@"api/tweet/%d/%@", self.id.intValue, (!_liked.boolValue? @"unlike":@"like")];
//    return doLikePath;
//}
//
//- (NSString *)toDoCommentPath{
//    if (self.project_id) {
//        return [NSString stringWithFormat:@"api/project/%@/tweet/%@/comment", self.project_id.stringValue, self.id.stringValue];
//    }else{
//        return [NSString stringWithFormat:@"api/tweet/%d/comment", self.id.intValue];
//    }
//}
//
//- (NSString *)toLikesAndRewardsPath{
//    return [NSString stringWithFormat:@"api/tweet/%d/allLikesAndRewards", _id.intValue];
//}
//- (NSDictionary *)toLikesAndRewardsParams{
//    return @{@"page" : [NSNumber numberWithInteger:1],
//             @"pageSize" : [NSNumber numberWithInteger:500]};
//}
//
//- (NSString *)toLikersPath{
//    return [NSString stringWithFormat:@"api/tweet/%d/likes", _id.intValue];
//}
//- (NSDictionary *)toLikersParams{
//    return @{@"page" : [NSNumber numberWithInteger:1],
//             @"pageSize" : [NSNumber numberWithInteger:500]};
//}
//- (NSString *)toCommentsPath{
//    NSString *path;
//    if (self.project_id) {
//        path = [NSString stringWithFormat:@"api/project/%@/tweet/%@/comments", self.project_id.stringValue, self.id.stringValue];
//    }else{
//        path = [NSString stringWithFormat:@"api/tweet/%d/comments", _id.intValue];
//    }
//    return path;
//}
//- (NSDictionary *)toCommentsParams{
//    return @{@"page" : [NSNumber numberWithInteger:1],
//             @"pageSize" : [NSNumber numberWithInteger:500]};
//}
//- (NSString *)toDeletePath{
//    if (self.project_id) {
//        return [NSString stringWithFormat:@"api/project/%@/tweet/%@", self.project_id.stringValue, self.id.stringValue];
//    }else{
//        return [NSString stringWithFormat:@"api/tweet/%d", self.id.intValue];
//    }
//}
//- (NSString *)toDetailPath{
//    NSString *path;
//    if (self.project_id) {
//        path = [NSString stringWithFormat:@"api/project/%@/tweet/%@", self.project_id.stringValue, self.id.stringValue];
//    }else if (self.project){
//        //需要先去获取project_id
//    }else if (self.user_global_key) {
//        path = [NSString stringWithFormat:@"api/tweet/%@/%@", self.user_global_key, self.id.stringValue];
//    }else{
//        path = [NSString stringWithFormat:@"api/tweet/%@/%@", self.owner.global_key, self.id.stringValue];
//    }
//    return path;
//}
//
////+(Tweet *)tweetForSend{
////    if (!_tweetForSend) {
////        _tweetForSend = [[Tweet alloc] init];
////        [_tweetForSend loadSendData];
////    }
////    return _tweetForSend;
////}
//
//+(Tweet *)tweetWithGlobalKey:(NSString *)user_global_key andPPID:(NSString *)pp_id{
//    Tweet *tweet = [[Tweet alloc] init];
//    tweet.id = [NSNumber numberWithInteger:pp_id.integerValue];
//    tweet.user_global_key = user_global_key;
//    return tweet;
//}
//+(Tweet *)tweetInProject:(Project *)project andPPID:(NSString *)pp_id{
//    Tweet *tweet = [[Tweet alloc] init];
//    tweet.id = [NSNumber numberWithInteger:pp_id.integerValue];
//    tweet.project = project;
//    return tweet;
//}
//
//- (BOOL)isAllImagesDoneSucess{
//    for (TweetImage *imageItem in _tweetImages) {
//        if (imageItem.imageStr.length <= 0) {
//            return NO;
//        }
//    }
//    return YES;
//}
//- (void)addNewComment:(Comment *)comment{
//    if (!comment) {
//        return;
//    }
//    if (_comment_list) {
//        [_comment_list insertObject:comment atIndex:0];
//    }else{
//        _comment_list = [NSMutableArray arrayWithObject:comment];
//    }
//    _comments = [NSNumber numberWithInteger:_comments.integerValue +1];
//}
//- (void)deleteComment:(Comment *)comment{
//    if (_comment_list) {
//        NSUInteger index = [_comment_list indexOfObject:comment];
//        if (index != NSNotFound) {
//            [_comment_list removeObjectAtIndex:index];
//            _comments = [NSNumber numberWithInteger:_comments.integerValue -1];
//        }
//    }
//}
//
//#pragma mark PHAsset
////- (void)setSelectedAssetLocalIdentifiers:(NSMutableArray *)selectedAssetLocalIdentifiers{
////    NSMutableArray *needToAdd = [NSMutableArray new];
////    NSMutableArray *needToDelete = [NSMutableArray new];
////    [self.selectedAssetLocalIdentifiers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
////        if (![selectedAssetLocalIdentifiers containsObject:obj]) {
////            [needToDelete addObject:obj];
////        }
////    }];
////    [needToDelete enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
////        [self deleteSelectedAssetLocalIdentifier:obj];
////    }];
////    [selectedAssetLocalIdentifiers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
////        if (![self.selectedAssetLocalIdentifiers containsObject:obj]) {
////            [needToAdd addObject:obj];
////        }
////    }];
////    [needToAdd enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
////        [self addSelectedAssetLocalIdentifier:obj];
////    }];
////}
//
//- (BOOL)isProjectTweet{
//    return self.project_id != nil || _project != nil;
//}
//
////- (void)addSelectedAssetLocalIdentifier:(NSString *)localIdentifier{
////    if (!_selectedAssetLocalIdentifiers) {
////        _selectedAssetLocalIdentifiers = [NSMutableArray new];
////    }
////    if (!_tweetImages) {
////        _tweetImages = [NSMutableArray new];
////    }
////
////    [_selectedAssetLocalIdentifiers addObject:localIdentifier];
////
////    NSMutableArray *tweetImages = [self mutableArrayValueForKey:@"tweetImages"];//为了kvo
////    TweetImage *tweetImg = [TweetImage tweetImageWithAssetLocalIdentifier:localIdentifier];
////    [tweetImages addObject:tweetImg];
////}
//
//- (void)deleteSelectedAssetLocalIdentifier:(NSString *)localIdentifier{
//    [self.selectedAssetLocalIdentifiers removeObject:localIdentifier];
//    NSMutableArray *tweetImages = [self mutableArrayValueForKey:@"tweetImages"];//为了kvo
//    [tweetImages enumerateObjectsUsingBlock:^(TweetImage *obj, NSUInteger idx, BOOL *stop) {
//        if (obj.assetLocalIdentifier == localIdentifier) {
//            [tweetImages removeObject:obj];
//            *stop = YES;
//        }
//    }];
//}
//- (void)deleteTweetImage:(TweetImage *)tweetImage{
//    NSMutableArray *tweetImages = [self mutableArrayValueForKey:@"tweetImages"];//为了kvo
//    [tweetImages removeObject:tweetImage];
//    if (tweetImage.assetLocalIdentifier) {
//        [self.selectedAssetLocalIdentifiers removeObject:tweetImage.assetLocalIdentifier];
//    }
//}
//
@end

@implementation Tweets

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"data":@"Tweet"
             };
}

@end

@implementation TweetImage

@end

