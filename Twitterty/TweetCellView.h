//
//  HomeTweetCellView.h
//  Twitterty
//
//  Created by Wunmin on 15/9/1.
//  Copyright (c) 2015年 Wunmin. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ReplyWindowController.h"

@interface TweetCellView : NSTableCellView {
    
    ReplyWindowController *replyController;
    NSString *nameWithSymbol;
}

@property (weak) IBOutlet NSButton *replyButton;
@property (weak) IBOutlet NSTextField *screenNameLabel;

@end
