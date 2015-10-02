//
//  HomeTweetCellView.m
//  Twitterty
//
//  Created by Wunmin on 15/9/1.
//  Copyright (c) 2015年 Wunmin. All rights reserved.
//

#import "TweetCellView.h"
#import "HomeTimelineViewController.h"

@implementation TweetCellView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

//- (instancetype)initWithCoder:(NSCoder *)coder {
//    
//    self = [super initWithCoder:coder];
//    if (self) {
//        
//        [self.buttonsView addButtonCellWithImage:[NSImage imageNamed:@"reply"]
//                                  alternateImage:[NSImage imageNamed:@"reply"]
//                                          target:self
//                                          action:@selector(replyButtonClicked:)];
//    }
//
//    return self;
//}

//- (IBAction)replyButtonClicked:(id)sender {
//    
//    replyController = [[ReplyWindowController alloc] initWithWindowNibName:@"ReplyWindowController"];
//    [replyController showWindow:self];
//    
//    HomeTimelineViewController *homeTimelineVC = [[HomeTimelineViewController alloc] initWithNibName:@"HomeTimelineViewController" bundle:nil];
//    [[homeTimelineVC tweetsTable] selectedRow];
//    NSLog(@"RowForView: %ld", [[homeTimelineVC tweetsTable] selectedRow]);
//
//}

//- (IBAction)replyButtonClicked:(id)sender {
//    
//    nameWithSymbol = [[self delegate] replyButtonDidClicked:self];
//    NSLog(@"nameWithSymbol: %@", nameWithSymbol);
//    
//    replyController = [[ReplyWindowController alloc] initWithWindowNibName:@"ReplyWindowController"];
//    [replyController showWindow:self];
//    
//    [[replyController replyText] setStringValue:nameWithSymbol];
//
//}

@end
