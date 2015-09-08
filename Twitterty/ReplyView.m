//
//  ReplyView.m
//  Twitterty
//
//  Created by Wunmin on 15/9/7.
//  Copyright (c) 2015年 Wunmin. All rights reserved.
//

#import "ReplyView.h"

@implementation ReplyView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

- (void)awakeFromNib {
    
    [self addSubview:[self replyText]];
    
}

@end
