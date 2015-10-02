//
//  WebWindowController.m
//  Twitterty
//
//  Created by Wunmin on 15/9/27.
//  Copyright (c) 2015年 Wunmin. All rights reserved.
//

#import "WebWindowController.h"
#import "HomeTimelineViewController.h"

NSString *const kAuthorizeURL = @"https://api.twitter.com/oauth/authorize";

@interface WebWindowController ()

@end

@implementation WebWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.

}

#pragma mark - WebFrameLoadDelegate

- (void)webView:(WebView *)sender didFinishLoadForFrame:(WebFrame *)frame {
    
    if (frame == [sender mainFrame]) {
        
        NSString *url = [[[[frame dataSource] request] URL] absoluteString];
        if ([url isEqualToString:kAuthorizeURL]) {
            
            [self close];
        }
    }
}

@end
