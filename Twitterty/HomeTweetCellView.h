//
//  HomeTweetCellView.h
//  Twitterty
//
//  Created by Wunmin on 15/9/1.
//  Copyright (c) 2015年 Wunmin. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "HomeTweetButtonsView.h"

@interface HomeTweetCellView : NSTableCellView

@property (weak) IBOutlet NSTextField *screenNameLabel;
@property (weak) IBOutlet HomeTweetButtonsView *buttonsView;

@end
