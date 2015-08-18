//
//  AppDelegate.m
//  Twitterty
//
//  Created by Wunmin on 15/8/11.
//  Copyright (c) 2015年 Wunmin. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
}

- (void)awakeFromNib {
    
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

- (IBAction)starClicked:(id)sender {
    
    [label setStringValue:@"STAR"];
    NSImage *selImage = [self buildTriangleSelection];
    [theBar setSelectionImage:selImage];
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

@end
