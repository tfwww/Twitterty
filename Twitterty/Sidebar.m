//
//  Sidebar.m
//  Twitterty
//
//  Created by Wunmin on 15/8/11.
//  Copyright (c) 2015年 Wunmin. All rights reserved.
//

#import "Sidebar.h"

#define DEFAULT_BUTTON_HEIGHT 60.0

@implementation Sidebar

- (id)initWithCoder:(NSCoder *)code {
    
    self = [super initWithCoder:code];
    if (self) {
        
        _itemsMatrix = [[NSMatrix alloc] initWithFrame:[self frame]
                                                  mode:NSRadioModeMatrix
                                             cellClass:[Sidebar class]
                                          numberOfRows:0
                                       numberOfColumns:1];
        [[self itemsMatrix] setAllowsEmptySelection:NO];
        [[self itemsMatrix] setCellSize:NSMakeSize([self bounds].size.width, DEFAULT_BUTTON_HEIGHT)];
        [self addSubview:[self itemsMatrix]];
        
        // Resize notification, so that the sidebar will always top to the window
        [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(viewResized:)
                                               name:NSViewFrameDidChangeNotification
                                             object:self];
    }
    return self;
}

- (void)viewResized:(NSNotification *)notification {
    
    [self resizeMatrix];
}

- (void)setSelectionImage:(NSImage *)image {
    
    if (selectionImageView == nil) {
        
        NSRect rect = [self frame];
        selectionImageView = [[NSImageView alloc] initWithFrame:NSMakeRect(NSMaxX(rect) - image.size.width, NSMinY(rect), image.size.width, image.size.height)];
        [selectionImageView setImage:image];
        [selectionImageView setAutoresizingMask:NSViewNotSizable];
        [[self itemsMatrix] addSubview:selectionImageView positioned:NSWindowAbove relativeTo:nil];
        [self moveSelectionImage];
    }
    
    [selectionImageView setImage:image];
    [self moveSelectionImage];
}

- (void)moveSelectionImage {
    
    if (selectionImageView == nil) {
        return;
    }
    
    NSInteger row = [[self itemsMatrix] selectedRow];
    if (row == -1) {
        NSLog(@"return");
        return;
    }
    
    NSRect rect = [[self itemsMatrix] cellFrameAtRow:row column:0];
    NSRect imageRect = [selectionImageView frame];
    imageRect.origin.x = rect.origin.x + NSWidth(rect) - [[selectionImageView image] size].width;
    imageRect.origin.y = rect.origin.y + (NSHeight(rect)/2.0) - ([[selectionImageView image] size].height/2.0);
    
    [[NSAnimationContext currentContext] setDuration:0.25];
    [[selectionImageView animator] setFrame:imageRect];
}

- (void)drawBackground:(NSRect)rect {
    
    [[self backgroundColor] set];
    NSRectFill(rect);
    if ([self noiseAlpha] > 0) {
        
        static CIImage *noisePattern = nil;
        if (noisePattern == nil) {
            
            CIFilter *randomGenerator = [CIFilter filterWithName:@"CIColorMonochrome"];
            CIFilter *outputFilter = [CIFilter filterWithName:@"CIRandomGenerator"];
            [randomGenerator setValue:[outputFilter valueForKey:@"outputImage"]
                               forKey:@"inputImage"];
            [randomGenerator setDefaults];
        }
        [noisePattern drawAtPoint:NSZeroPoint
                         fromRect:[self bounds]
                        operation:NSCompositePlusLighter
                         fraction:[self noiseAlpha]];
    }
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    [self drawBackground:dirtyRect];
}

//- (ItemCell *)addButton {
//    
//    [[self itemsMatrix] addRow];
//    ItemCell *cell = [[self itemsMatrix] cellAtRow:[[self itemsMatrix] numberOfRows] - 1
//                                     column:1];
//    
//    [cell setButtonType:NSPushOnPushOffButton];
//    
//    return cell;
//}
//
//- (void)addButtonWithImage:(NSImage *)image {
//
//    ItemCell *cell = [self addButton];
//    [cell setImageCell:image];
//}

//- (void)addButtonWithImage:(NSImage *)image alternateImage:(NSImage *)altImage {
//
//    ItemCell *cell = [self addButton];
//    [cell setImage:image];
//    [cell setAlternateImage:altImage];
//    NSLog(@"addButtonWithImage:alternateImage:");
//}


- (void)addButtonCell:(ItemCell *)cell {
    
    [[self itemsMatrix] addRowWithCells:@[ cell ]];
}

- (void)addButtonCellWithImage:(NSImage *)image alternateImage:(NSImage *)altImage {
    
    ItemCell *cell = [[ItemCell alloc] initImageCell:image];
    [cell setAlternateImage:altImage];
    [self addButtonCell:cell];
    
    [self resizeMatrix];
}

- (void)addButtonCellWithImage:(NSImage *)image alternateImage:(NSImage *)altImage target:(id)target action:(SEL)action {
    
    ItemCell *cell = [[ItemCell alloc] initImageCell:image];
    [cell setAlternateImage:altImage];
    [cell setTarget:target];
    [cell setAction:action];
    
    [self addButtonCell:cell];
    [self resizeMatrix];
}

#pragma mark - Resizing

// Make the sidebar on top to the window
- (void)resizeMatrix {
    
//    [[self itemsMatrix] sizeToCells];
//    NSRect newRect = [[self itemsMatrix] frame];
//    if (NSHeight([[self enclosingScrollView].contentView frame]) > NSHeight(newRect)) {
//        
//        newRect.size.height = NSHeight([[self enclosingScrollView].contentView frame]);
//    }
//    [[self itemsMatrix] setFrameSize:newRect.size];
//    [self setFrameSize:newRect.size];
//    //[self setFrame:newRect];
    
    NSInteger numRows = [[self itemsMatrix] numberOfRows];
    CGFloat matrixHeight = numRows * DEFAULT_BUTTON_HEIGHT;
    
    NSRect rect = [self frame];
    
    NSRect matrixRect = rect;
    matrixRect.origin.x = 0.0;
    matrixRect.size.width = NSWidth(rect);
    matrixRect.size.height = matrixHeight;
    matrixRect.origin.y = NSHeight(rect)-matrixHeight;
    [[self itemsMatrix] setFrame:matrixRect];
    [self moveSelectionImage];

}

@end
