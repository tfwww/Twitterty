
//
//  HomeTweetButtonCell.m
//  Twitterty
//
//  Created by Wunmin on 15/9/1.
//  Copyright (c) 2015年 Wunmin. All rights reserved.
//

#import "HomeTweetButtonCell.h"

@implementation HomeTweetButtonCell

- (instancetype)initImageCell:(NSImage *)anImage {
    
    self = [super initImageCell:anImage];
    if (self) {
        
        [self setButtonType:NSPushOnPushOffButton];
    }
    
    return self;
}

- (void)drawWithFrame:(NSRect)cellFrame inView:(NSView *)controlView {
    
    NSColor *cellColor = nil;
    NSImage *cellImage = nil;
    if ([self state] == NSOnState) {
        cellColor = [NSColor darkGrayColor];
        cellImage = [self image];
    } else {
        cellColor = [NSColor whiteColor];
        cellImage = [self alternateImage];
    }
    [cellColor setFill];
    
    [self drawImage:cellImage withFrame:cellFrame inView:controlView];
    
//    NSColor *cellColor = nil;
//    if ([self state] == NSOnState) {
//        cellColor = [NSColor colorWithDeviceWhite:54.0/255.0 alpha:1.0];
//    } else {
//        cellColor = [NSColor colorWithDeviceWhite:65.0/255.0 alpha:1.0];
//    }
//    [cellColor setFill];
//    NSRectFill(cellFrame);
//    
//    NSImage *cellImage = nil;
//    if ([self state] == NSOnState) {
//        cellImage = [self image];
//    } else {
//        cellImage = [self alternateImage];
//    }
//    
//    [self drawImage:cellImage withFrame:cellFrame inView:controlView];

}

@end
