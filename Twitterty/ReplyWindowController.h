//
//  ReplyWindowController.h
//  Twitterty
//
//  Created by Wunmin on 15/9/8.
//  Copyright (c) 2015年 Wunmin. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ReplyWindowController : NSWindowController {
    
    NSArray *tweetsData;
//    NSDictionary *_tweetToReply;
    IBOutlet __weak NSTextField *replyText;
    IBOutlet __weak NSTextField *replyName;
    
}

@property (nonatomic) NSArray *tweetsData;

@property (weak) IBOutlet NSTextField *replyName;
@property (weak) IBOutlet NSTextField *replyText;
//@property (weak) NSMutableArray *tweetsData;

- (IBAction)cancelReplyText:(id)sender;
- (IBAction)postReplyText:(id)sender;

@end
