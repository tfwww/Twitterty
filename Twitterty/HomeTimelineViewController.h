//
//  AuthenticationViewController.h
//  Twitterty
//
//  Created by Wunmin on 15/8/25.
//  Copyright (c) 2015年 Wunmin. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "STTwitter.h"

@interface HomeTimelineViewController : NSViewController <NSTableViewDataSource, NSTableViewDelegate> {
    
    STTwitterAPI *twitter;
    NSArray *tweetData;
}

@property (weak) IBOutlet NSTableView *tweetsTable;

@end
