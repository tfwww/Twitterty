//
//  AppDelegate.m
//  Twitterty
//
//  Created by Wunmin on 15/8/11.
//  Copyright (c) 2015年 Wunmin. All rights reserved.
//

#import "AppDelegate.h"
#import "STTwitter.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {

    [self wakeUpHomeTimelineView];
}

- (void)awakeFromNib {
    
    // Add the cells with image
    [theBar addButtonCellWithImage:[NSImage imageNamed:@"star-pushed"]
                    alternateImage:[NSImage imageNamed:@"star-pushed"]
                            target:self
                            action:@selector(starClicked:)];
    [theBar addButtonCellWithImage:[NSImage imageNamed:@"tag"]
                    alternateImage:[NSImage imageNamed:@"tag"]
                            target:self
                            action:@selector(tagClicked:)];
    [theBar addButtonCellWithImage:[NSImage imageNamed:@"watch-pushed"]
                    alternateImage:[NSImage imageNamed:@"watch-pushed"]
                            target:self
                            action:@selector(watchClicked:)];
    [theBar addButtonCellWithImage:[NSImage imageNamed:@"trash-pushed"]
                    alternateImage:[NSImage imageNamed:@"trash-pushed"]
                            target:self
                            action:@selector(trashClicked:)];
    
    [theBar.itemsMatrix setState:NSOnState atRow:0 column:0];
    NSImage *selImage = [self buildTriangleSelection];
    [theBar setSelectionImage:selImage];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
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

- (IBAction)starClicked:(id)sender {
    
    NSImage *selImage = [self buildTriangleSelection];
    [theBar setSelectionImage:selImage];
    
    //[self wakeUpHomeTimelineView];
    
}

- (IBAction)tagClicked:(id)sender {
    
    [label setStringValue:@"TAG"];
    NSImage *selImage = [self buildTriangleSelection];
    [theBar setSelectionImage:selImage];
}

- (IBAction)watchClicked:(id)sender {
    
    [label setStringValue:@"WATCH"];
    NSImage *selImage = [self buildTriangleSelection];
    [theBar setSelectionImage:selImage];
}

- (IBAction)trashClicked:(id)sender {
    
    [label setStringValue:@"TRASH"];
    NSImage *selImage = [self buildTriangleSelection];
    [theBar setSelectionImage:selImage];
}

#pragma mark - Wake Up the Nibs

- (void)wakeUpHomeTimelineView {
    
    homeTimelineVC = [[HomeTimelineViewController alloc] initWithNibName:@"HomeTimelineViewController" bundle:nil];
    
    // Draw the HomeTimelineView frame
    NSRect tableViewRect;
    NSRect windowRect = [[self window] frame];
    NSRect sideBarRect = [theBar frame];
    
    tableViewRect.origin.x = sideBarRect.size.width;
    tableViewRect.origin.y = 0.0;
    tableViewRect.size.width = NSWidth(windowRect) - sideBarRect.size.width;
    tableViewRect.size.height = NSHeight(windowRect);
    
    [[homeTimelineVC view] setFrame:tableViewRect];
    [[[self window] contentView] addSubview:[homeTimelineVC view]];
}

@end
