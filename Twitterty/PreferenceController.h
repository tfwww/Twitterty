//
//  PreferenceController.h
//  Twitterty
//
//  Created by Wunmin on 15/9/25.
//  Copyright (c) 2015年 Wunmin. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "STTwitter.h"
#import "HomeTimelineViewController.h"
#import "WebWindowController.h"

@interface PreferenceController : NSWindowController <NSCoding> {
    
    IBOutlet NSWindow *accountSheet;
    IBOutlet NSWindow *preferenceWindow;
    
    __weak IBOutlet NSTableView *userTable;
    
    STTwitterAPI *twitter;
    WebWindowController *webViewWC;
    
}

- (IBAction)loginWithOauth:(id)sender;

- (void)setOAuthToken:(NSString *)token oauthVerifier:(NSString *)verifier;

@end
