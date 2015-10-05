//
//  AuthenticationViewController.h
//  Twitterty
//
//  Created by Wunmin on 15/8/25.
//  Copyright (c) 2015年 Wunmin. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "STTwitter.h"
#import "TweetCellView.h"
#import "ReplyWindowController.h"

extern NSString *const kConsumerKey;
extern NSString *const kConsuemrSecret;
extern NSString *const kOauthTokenKeychainService;
extern NSString *const kOauthTokenSecretKeychainService;

@interface HomeTimelineViewController : NSViewController <NSTableViewDataSource, NSTableViewDelegate> {
    
    STTwitterAPI *twitter;
    NSArray *tweetData;
    ReplyWindowController *replyController;
//    HomeTweetCellView *tweetCellView;
}

@property (weak) IBOutlet NSTableView *tweetsTable;

- (IBAction)replyButtonClicked:(id)sender;

//- (void)replyButton:(id)sender;

//- (void)changeReplyTextInRow;

@end
