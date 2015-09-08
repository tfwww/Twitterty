//
//  HomeTweetButtonsView.m
//  Twitterty
//
//  Created by Wunmin on 15/9/1.
//  Copyright (c) 2015年 Wunmin. All rights reserved.
//

#import "HomeTweetButtonsView.h"
#import "HomeTweetButtonCell.h"

#define NUMBER_OF_ROWS 1
#define NUMBER_OF_COLUMNS 0
#define WIDTH_CELL 31
#define HEIGHT_CELL 31

@implementation HomeTweetButtonsView

- (void)awakeFromNib {
    
    buttonsMatrix = [[NSMatrix alloc] initWithFrame:[self frame]
                                                mode:NSRadioModeMatrix
                                            cellClass:[HomeTweetButtonCell class]
                                        numberOfRows:NUMBER_OF_ROWS
                                    numberOfColumns:NUMBER_OF_COLUMNS];
    [buttonsMatrix setAllowsEmptySelection:YES];
    [buttonsMatrix setCellSize:[[self class] defaultCellSize]];
//    NSLog(@"width: %f, height: %f", [self bounds].size.width, [self bounds].size.height);
    [buttonsMatrix setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
    [self addSubview:buttonsMatrix];
//    [self addButtonCellWithImage:[NSImage imageNamed:@"reply"]
//                                       alternateImage:[NSImage imageNamed:@"reply"]
//                                               target:self
//                                               action:@selector(replyButtonClicked:)];
//    [self addButtonCellWithImage:[NSImage imageNamed:@"reply.png"] alternateImage:[NSImage imageNamed:@"reply.png"]];
//    [self addButtonCellWithImage:[NSImage imageNamed:@"reply.png"] alternateImage:[NSImage imageNamed:@"reply.png"]];
//    [self addButtonCellWithImage:[NSImage imageNamed:@"reply.png"] alternateImage:[NSImage imageNamed:@"reply.png"]];
    
    [self addButtonCellWithImage:[NSImage imageNamed:@"reply.png"]
                                  alternateImage:[NSImage imageNamed:@"reply.png"]
                                          target:self
                                          action:@selector(replyButtonClicked)];
    [self addButtonCellWithImage:[NSImage imageNamed:@"reply.png"]
                  alternateImage:[NSImage imageNamed:@"reply.png"]
                          target:self
                          action:@selector(replyButtonClicked)];
    [self addButtonCellWithImage:[NSImage imageNamed:@"reply.png"]
                  alternateImage:[NSImage imageNamed:@"reply.png"]
                          target:self
                          action:@selector(replyButtonClicked)];
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    [[NSColor whiteColor] set];
    [NSBezierPath fillRect:dirtyRect];

//    NSRectFill(dirtyRect);

}


+ (NSSize)defaultCellSize {
    
    return NSMakeSize(WIDTH_CELL, HEIGHT_CELL);
}

- (void)addButtonCell:(HomeTweetButtonCell *)cell {
    
    [buttonsMatrix addColumnWithCells:@[ cell ]];
}

- (HomeTweetButtonCell *)addButtonCellWithImage:(NSImage *)image alternateImage:(NSImage *)altImage {
    
    HomeTweetButtonCell *cell = [[HomeTweetButtonCell alloc] initImageCell:image];
    [cell setAlternateImage:altImage];
    [self addButtonCell:cell];
    
    return cell;
}

- (void)addButtonCellWithImage:(NSImage *)image alternateImage:(NSImage *)altImage target:(id)target action:(SEL)action {
    
    HomeTweetButtonCell *cell = [self addButtonCellWithImage:image alternateImage:altImage];
    [cell setTarget:target];
    [cell setAction:action];
}

#pragma mark - Clicked Action Method

- (void)replyButtonClicked {
    
    replyController = [[ReplyWindowController alloc] initWithWindowNibName:@"ReplyWindowController"];
    [replyController showWindow:self];
}

@end
