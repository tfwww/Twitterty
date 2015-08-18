//
//  Sidebar.h
//  Twitterty
//
//  Created by Wunmin on 15/8/11.
//  Copyright (c) 2015年 Wunmin. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ItemCell.h"
#import <QuartzCore/QuartzCore.h>

@interface Sidebar : NSView {
    
    NSImageView *selectionImageView;
}

@property (strong, nonatomic) NSMatrix *itemsMatrix;
@property (strong, nonatomic) NSColor *backgroundColor;
@property CGFloat noiseAlpha;

- (void)setSelectionImage:(NSImage *)image;
- (void)drawBackground:(NSRect)rect;
- (void)addButtonCell:(ItemCell *)cell;
- (void)addButtonCellWithImage:(NSImage *)image alternateImage:(NSImage *)altImage;
- (void)addButtonCellWithImage:(NSImage *)image alternateImage:(NSImage *)altImage target:(id)target action:(SEL)action;

@end
