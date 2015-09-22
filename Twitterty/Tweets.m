//
//  Tweet.m
//  Twitterty
//
//  Created by Wunmin on 15/9/9.
//  Copyright (c) 2015年 Wunmin. All rights reserved.
//

#import "Tweets.h"

NSString *const kConsumerKey = @"9cdFRYobskEMT2FcP0YZ5w2Zw";
NSString *const kConsuemrSecret = @"KCa6WUcv8DCkB6mfMK3EBmd6aBX5DpTNajgneYgjVbJEw4bJYu";
NSString *const kOauthToken = @"105745339-TujlsXUir2p8B8gEVNSgOev8cS3kHGEHQ4Sa1AR1";
NSString *const kOauthTokenSecret = @"7W2hfl7jl5QjY8LubOjBFOI5P2kmHr7OD2CmzMPV2c";

@implementation Tweets

- (id)init {
    
    self = [super init];
    if (self) {
        
        // Get authentication from twitter
        twitter = [STTwitterAPI twitterAPIWithOAuthConsumerKey:kConsumerKey
                                                consumerSecret:kConsuemrSecret
                                                    oauthToken:kOauthToken
                                              oauthTokenSecret:kOauthTokenSecret];
    }
    
    return self;
}

- (void)getHomeTimeline {
    
    [twitter verifyCredentialsWithUserSuccessBlock:^(NSString *username, NSString *userID) {
        
        NSLog(@"Success with username: %@ and userID: %@", username, userID);
        
        // GetUserTimeline
        //        [twitter getUserTimelineWithScreenName:screenName
        //                                  successBlock:^(NSArray *statuses) {
        //                                      NSLog(@"Statuses: %@", statuses);
        //
        //                                  }
        //                                    errorBlock:^(NSError *error) {
        //                                      NSLog(@"Failed with error: %@", [error localizedDescription]);
        //                                  }];
        
        // GetUserTimeline with count
        //        [twitter getUserTimelineWithScreenName:screenName
        //                                         count:50
        //                                  successBlock:^(NSArray *statuses) {
        //                                      NSLog(@"Statuses: %@", statuses);
        //                                  }
        //                                    errorBlock:^(NSError *error) {
        //                                        NSLog(@"Failed with error: %@", [error localizedDescription]);
        //                                    }];
        
        // Get Home timeline
        [twitter getHomeTimelineSinceID:nil
                                  count:2
                           successBlock:^(NSArray *statuses) {
                               //NSLog(@"Statuses:%@", statuses);
                               self.tweetData = statuses;
                               //NSLog(@"number of elements: %lu", (unsigned long)[self.tweetData count]);

                               //[[self tweetsTable] reloadData];
                           }
                             errorBlock:^(NSError *error) {
                                 NSLog(@"Failed with error: %@", [error localizedDescription]);
                             }];
        
    } errorBlock:^(NSError *error) {
        NSLog(@"Failed with error: %@", [error localizedDescription]);
    }];

}

@end
