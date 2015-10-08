//
//  AppDelegate.m
//  Twitterty
//
//  Created by Wunmin on 15/8/11.
//  Copyright (c) 2015年 Wunmin. All rights reserved.
//

#import "AppDelegate.h"
#import "STTwitter.h"
#import "PreferenceController.h"
#import "SSKeychain.h"
#import "SSKeychainQuery.h"
#import "PreferenceController.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {

//    [self wakeUpHomeTimelineView];
//    [self wakeUpMentionView];
    
    homeTimelineVC = [[HomeTimelineViewController alloc] initWithNibName:@"HomeTimelineViewController" bundle:nil];
    mentionVC = [[MentionViewController alloc] initWithNibName:@"MentionViewController" bundle:nil];
    favVC = [[FavTweetViewController alloc] initWithNibName:@"FavTweetViewController" bundle:nil];
    webViewWC = [[WebWindowController alloc] initWithWindowNibName:@"WebWindowController"];
    
    

    [self displayViewController:homeTimelineVC];

}

- (void)applicationWillFinishLaunching:(NSNotification *)aNotification {
    
    NSAppleEventManager *appleEventManager = [NSAppleEventManager sharedAppleEventManager];
    [appleEventManager setEventHandler:self
                           andSelector:@selector(handleGetURLEvent:withReplyEvent:)
                         forEventClass:kInternetEventClass
                            andEventID:kAEGetURL];
}

//- (id)init {
//    
//    self = [super init];
//    
//    NSAppleEventManager *appleEventManager = [NSAppleEventManager sharedAppleEventManager];
//    [appleEventManager setEventHandler:self
//                           andSelector:@selector(handleGetURLEvent:withReplyEvent:)
//                         forEventClass:kInternetEventClass
//                            andEventID:kAEGetURL];
//
//    return self;
//}

#pragma mark - URL Scheme

- (void)handleGetURLEvent:(NSAppleEventDescriptor *)event
           withReplyEvent:(NSAppleEventDescriptor *)replyEvent {
    
    NSString *urlStr = [[event paramDescriptorForKeyword:keyDirectObject] stringValue];
//    NSString *urlStr = [[[[NSAppleEventManager sharedAppleEventManager] currentAppleEvent] paramDescriptorForKeyword:keyDirectObject] stringValue];
//    NSLog(@"URL: %@", urlStr);
    
    NSDictionary *dict = [self parameterDictionaryFromURLString:urlStr];
    
    NSString *oauth = [dict objectForKey:@"oauth_token"];
    NSString *verifier = [dict objectForKey:@"oauth_verifier"];
    
//    NSLog(@"oauth: %@", oauth);
//    NSLog(@"verifier: %@", verifier);
    
    [preferenceWC setOAuthToken:oauth oauthVerifier:verifier];
    
    // close the webView window
    [webViewWC close];
}

- (NSDictionary *)parameterDictionaryFromURLString:(NSString *)urlString {
    
    NSMutableDictionary *mutableDictionary = [NSMutableDictionary dictionary];
    NSArray *urlComponents = [urlString componentsSeparatedByString:@"?"];
    NSArray *pairs = [[urlComponents lastObject] componentsSeparatedByString:@"&"];
    
    for (NSString *s in pairs) {
        
        NSArray *pair = [s componentsSeparatedByString:@"="];
        NSString *key = pair[0];
        NSString *value = pair[1];
        
        mutableDictionary[key] = value;
    }
    
    return mutableDictionary;
}

#pragma mark -

- (void)awakeFromNib {
    
    // Add the cells with image
    [theBar addButtonCellWithImage:[NSImage imageNamed:@"home"]
                    alternateImage:[NSImage imageNamed:@"home"]
                            target:self
                            action:@selector(homeClicked:)];
    [theBar addButtonCellWithImage:[NSImage imageNamed:@"reply"]
                    alternateImage:[NSImage imageNamed:@"reply"]
                            target:self
                            action:@selector(mentionClicked:)];
    [theBar addButtonCellWithImage:[NSImage imageNamed:@"star"]
                    alternateImage:[NSImage imageNamed:@"star"]
                            target:self
                            action:@selector(favClicked:)];
    [theBar addButtonCellWithImage:[NSImage imageNamed:@"more"]
                    alternateImage:[NSImage imageNamed:@"more"]
                            target:self
                            action:@selector(moreClicked:)];
    
    [theBar.itemsMatrix setState:NSOnState atRow:0 column:0];
    NSImage *selImage = [self buildTriangleSelection];
    [theBar setSelectionImage:selImage];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (IBAction)showPreferencePanel:(id)sender {
    
    if (!preferenceWC) {
        preferenceWC = [[PreferenceController alloc] initWithWindowNibName:@"PreferenceController"];
    }
    [preferenceWC showWindow:self];
}

// triangle selection
- (NSImage *)buildTriangleSelection {
    
    NSInteger imageWidth = 12, imageHeight = 22;
    NSImage *destImage = [[NSImage alloc] initWithSize:NSMakeSize(imageWidth, imageHeight)];
    
    [destImage lockFocus];
    
    NSBezierPath *triangle = [NSBezierPath bezierPath];
    [triangle setLineWidth:1.0];
    [triangle moveToPoint:NSMakePoint(imageWidth + 1, 0)];
    [triangle lineToPoint:NSMakePoint(imageWidth + 1, imageHeight)];
    [triangle lineToPoint:NSMakePoint(0, imageHeight / 2)];
    [triangle closePath];
    [[NSColor controlColor] setFill];
    [[NSColor darkGrayColor] setStroke];
    [triangle fill];
    [triangle stroke];
    
    [destImage unlockFocus];
    
    return destImage;
}

#pragma mark - Mouse Clicked Action

- (IBAction)homeClicked:(id)sender {
    
    NSImage *selImage = [self buildTriangleSelection];
    [theBar setSelectionImage:selImage];
    
//    [self wakeUpHomeTimelineView];
    [self displayViewController:homeTimelineVC];
    
}

- (IBAction)mentionClicked:(id)sender {
    
    NSImage *selImage = [self buildTriangleSelection];
    [theBar setSelectionImage:selImage];
    
//    [self wakeUpMentionView];
    [self displayViewController:mentionVC];
}

- (IBAction)favClicked:(id)sender {
    
    NSImage *selImage = [self buildTriangleSelection];
    [theBar setSelectionImage:selImage];
    
    [self displayViewController:favVC];
}

- (IBAction)moreClicked:(id)sender {
    
    [label setStringValue:@"TRASH"];
    NSImage *selImage = [self buildTriangleSelection];
    [theBar setSelectionImage:selImage];
    
    [self showPreferencePanel:sender];
}

//#pragma mark - Wake Up the Nibs
//
//- (void)wakeUpHomeTimelineView {
//    
//    homeTimelineVC = [[HomeTimelineViewController alloc] initWithNibName:@"HomeTimelineViewController" bundle:nil];
//    
//    // Draw the HomeTimelineView frame
//    NSRect tableViewRect;
//    NSRect windowRect = [[self window] frame];
//    NSRect sideBarRect = [theBar frame];
//    
//    tableViewRect.origin.x = sideBarRect.size.width;
//    tableViewRect.origin.y = 0.0;
//    tableViewRect.size.width = NSWidth(windowRect) - sideBarRect.size.width;
//    tableViewRect.size.height = NSHeight(windowRect);
//    
//    [[homeTimelineVC view] setFrame:tableViewRect];
//    [[[self window] contentView] addSubview:[homeTimelineVC view]];
//}

//- (void)wakeUpMentionView {
//    
//    mentionVC = [[MentionViewController alloc] initWithNibName:@"MentionViewController" bundle:nil];
//    
//    // Draw the wakeUpMentionView frame
//    NSRect tableViewRect;
//    NSRect windowRect = [[self window] frame];
//    NSRect sideBarRect = [theBar frame];
//    
//    tableViewRect.origin.x = sideBarRect.size.width;
//    tableViewRect.origin.y = 0.0;
//    tableViewRect.size.width = NSWidth(windowRect) - sideBarRect.size.width;
//    tableViewRect.size.height = NSHeight(windowRect);
//    
//    NSLog(@"tableViewRect width: %f", tableViewRect.size.width);
//    NSLog(@"tableViewRect height:%f", tableViewRect.size.height);
//    
//    [[mentionVC view] setFrame:tableViewRect];
//    [[[self window] contentView] addSubview:[mentionVC view]];
//}

#pragma mark - Change and Display View

- (void)displayViewController:(NSViewController *)vc {
    
    NSView *v = [vc view];
    NSRect tableViewRect;
    NSRect windowRect = [[self window] frame];
    NSRect sideBarRect = [theBar frame];
    
    tableViewRect.origin.x = sideBarRect.size.width;
    tableViewRect.origin.y = 0.0;
    tableViewRect.size.width = NSWidth(windowRect) - sideBarRect.size.width;
    tableViewRect.size.height = NSHeight(windowRect);
    [v setFrame:tableViewRect];
    [[[self window] contentView] addSubview:v];
}

@end
