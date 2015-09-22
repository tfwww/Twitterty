//
//  Tweet.h
//  Twitterty
//
//  Created by Wunmin on 15/9/9.
//  Copyright (c) 2015年 Wunmin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STTwitter.h"

extern NSString *const kConsumerKey;
extern NSString *const kConsuemrSecret;
extern NSString *const kOauthToken;
extern NSString *const kOauthTokenSecret;

@interface Tweets : NSObject {
    
    STTwitterAPI *twitter;
}

@property (nonatomic, retain) NSArray *tweetData;

- (void)getHomeTimeline;

@end
