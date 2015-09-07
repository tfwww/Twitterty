//
//  AuthenticationViewController.h
//  Twitterty
//
//  Created by Wunmin on 15/8/25.
//  Copyright (c) 2015年 Wunmin. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "STTwitter.h"
#import "HomeTweetCellView.h"

extern NSString *const kConsumerKey;
extern NSString *const kConsuemrSecret;
extern NSString *const kOauthToken;
extern NSString *const kOauthTokenSecret;

@interface HomeTimelineViewController : NSViewController <NSTableViewDataSource, NSTableViewDelegate> {
    
    STTwitterAPI *twitter;
    NSArray *tweetData;
    HomeTweetCellView *tweetCellView;
}

@property (weak) IBOutlet NSTableView *tweetsTable;

@end
