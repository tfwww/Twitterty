//
//  WebWindowController.h
//  Twitterty
//
//  Created by Wunmin on 15/9/27.
//  Copyright (c) 2015年 Wunmin. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Webkit/Webkit.h>
#import "STTwitter.h"

extern NSString *const kAuthorizeURL;

@interface WebWindowController : NSWindowController <NSWindowDelegate> {
    
    __weak IBOutlet NSTextField *urlAddressLabel;
    
}

@property (weak) IBOutlet WebView *webView;




@end
