//
//  AppDelegate.h
//  Twitterty
//
//  Created by Wunmin on 15/8/11.
//  Copyright (c) 2015年 Wunmin. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Sidebar.h"
#import "HomeTimelineViewController.h"
#import "MentionViewController.h"

@interface AppDelegate : NSObject <NSApplicationDelegate> {
    
    IBOutlet Sidebar *theBar;
    IBOutlet NSTextField *label;
    
    HomeTimelineViewController *homeTimelineVC;
    MentionViewController *mentionVC;
}


@end

