//
//  AppDelegate.h
//  Twitterty
//
//  Created by Wunmin on 15/8/11.
//  Copyright (c) 2015年 Wunmin. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Security/Security.h>
#import "Sidebar.h"
#import "HomeTimelineViewController.h"
#import "MentionViewController.h"
#import "FavTweetViewController.h"
#import "PreferenceController.h"
#import "WebWindowController.h"

@interface AppDelegate : NSObject <NSApplicationDelegate> {
    
    IBOutlet Sidebar *theBar;
    IBOutlet NSTextField *label;
    
    HomeTimelineViewController *homeTimelineVC;
    MentionViewController *mentionVC;
    FavTweetViewController *favVC;
    PreferenceController *preferenceController;
    WebWindowController *webViewWC;
}

- (IBAction)showPreferencePanel:(id)sender;


@end

