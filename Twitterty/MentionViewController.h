//
//  MentionViewController.h
//  Twitterty
//
//  Created by Wunmin on 15/9/22.
//  Copyright (c) 2015年 Wunmin. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "STTwitter.h"
#import "HomeTimelineViewController.h"
#import "ReplyWindowController.h"

@interface MentionViewController : NSViewController <NSTableViewDataSource, NSTableViewDelegate> {
    
    STTwitterAPI *twitterAPI;
    NSArray *mentionTweets;
    ReplyWindowController *replyWC;
    
    __weak IBOutlet NSTableView *mentionTable;
}
- (IBAction)mentionTweetReply:(id)sender;

@end
