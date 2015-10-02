//
//  FavTweetViewController.h
//  Twitterty
//
//  Created by Wunmin on 15/9/24.
//  Copyright (c) 2015年 Wunmin. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ReplyWindowController.h"
#import "STTwitter.h"
#import "HomeTimelineViewController.h"

@interface FavTweetViewController : NSViewController <NSTableViewDelegate, NSTableViewDataSource> {
    
    __weak IBOutlet NSTableView *favTable;
    STTwitterAPI *twitterAPI;
    NSArray *favTweets;
    ReplyWindowController *replyWC;
}

@end
