//
//  AppDelegate.h
//  Twitterty
//
//  Created by Wunmin on 15/8/11.
//  Copyright (c) 2015年 Wunmin. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Sidebar.h"

@interface AppDelegate : NSObject <NSApplicationDelegate> {
    
    IBOutlet Sidebar *theBar;
    IBOutlet NSTextField *label;
}


@end

