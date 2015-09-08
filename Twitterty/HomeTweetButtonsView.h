//
//  HomeTweetButtonsView.h
//  Twitterty
//
//  Created by Wunmin on 15/9/1.
//  Copyright (c) 2015年 Wunmin. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ReplyWindowController.h"


@interface HomeTweetButtonsView : NSView {
    
    NSMatrix *buttonsMatrix;
    ReplyWindowController *replyController;
}

- (void)addButtonCellWithImage:(NSImage *)image alternateImage:(NSImage *)altImage target:(id)target action:(SEL)action;

@end
