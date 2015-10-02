//
//  PreferenceController.m
//  Twitterty
//
//  Created by Wunmin on 15/9/25.
//  Copyright (c) 2015年 Wunmin. All rights reserved.
//

#import "PreferenceController.h"
#import "WebWindowController.h"

@interface PreferenceController () {
    
    NSMutableArray *users;
    NSImage *imageForUser;
}

@end

@implementation PreferenceController

- (void)windowDidLoad {
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

//#pragma mark - WebFrameLoadDelegate Methods
//
//- (void)webView:(WebView *)sender didFinishLoadForFrame:(WebFrame *)webFrame {
//    
//    NSView *contentView = [accountSheet contentView];
//    WebView *webView = [[WebView alloc] initWithFrame:[contentView bounds]];
//    [webView setTranslatesAutoresizingMaskIntoConstraints:NO];
//    
//    [contentView addSubview:webView];
//    NSDictionary *views = NSDictionaryOfVariableBindings(webView);
//    [contentView addConstraints:
//     [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[webView]|"
//                                            options:0
//                                            metrics:nil
//                                              views:views]];
//    [contentView addConstraints:
//     [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[webView]|"
//                                             options:0
//                                             metrics:nil
//                                               views:views]];
//    
//}

- (IBAction)showAddingAccountPanel:(id)sender {
    
//    [preferenceWindow beginSheet:accountSheet
//               completionHandler:^(NSModalResponse returnCode) {
//                   NSLog(@"completionHandler: %ld", (long)returnCode);
//               }];
}

- (IBAction)loginWithOauth:(id)sender {
    
    twitter = [STTwitterAPI twitterAPIWithOAuthConsumerKey:kConsumerKey
                                            consumerSecret:kConsuemrSecret];
    webViewWC = [[WebWindowController alloc] initWithWindowNibName:@"WebWindowController"];
    [webViewWC showWindow:self];

//    [twitter postAccessTokenRequestWithPIN:(NSString *)pin
//successBlock:(void(^)(NSString *oauthToken, NSString *oauthTokenSecret, NSString *userID, NSString *screenName))successBlock
//errorBlock:(void(^)(NSError *error))errorBlock
    
    [twitter postTokenRequest:^(NSURL *url, NSString *oauthToken) {
//        NSLog(@"-- url: %@", url);
//        NSLog(@"-- oauthToken: %@", oauthToken);
        
        [[[webViewWC webView] mainFrame] loadRequest:[NSURLRequest requestWithURL:url]];
        
    } authenticateInsteadOfAuthorize:NO
                    forceLogin:@(YES)
                    screenName:nil
                 oauthCallback:@"twitterty://www.google.com/"
                    errorBlock:^(NSError *error) {
//                        NSLog(@"-- error: %@", error);
                    }];
}

- (void)setOAuthToken:(NSString *)token oauthVerifier:(NSString *)verifier {
    
    [twitter postAccessTokenRequestWithPIN:verifier
                              successBlock:^(NSString *oauthToken, NSString *oauthTokenSecret, NSString *userID, NSString *screenName) {
                                  
                                  users = [[NSMutableArray alloc] init];
                                  [users addObject:screenName];
                                  
                                  NSLog(@"screenName: %@", users[0]);
                                  
//                                  [twitter profileImageFor:screenName
//                                          successBlock:^(id image) {
//
//                                              [userTable reloadData];
//                                          }
//                                            errorBlock:^(NSError *error) {
//                                                NSLog(@"imageError: %@", error);
//                                            }];
                                  
                                  [userTable reloadData];
                              }
                                errorBlock:^(NSError *error) {
                                    NSLog(@"authenticate error: %@", error);
                                }];
}

#pragma mark - Table View Data Source

- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView {
    
//    NSLog(@"users: %ld", [users count]);
    return [users count];
}

- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex {
    
    NSTableCellView *cellView = [userTable makeViewWithIdentifier:@"userItem" owner:self];
    
    [[cellView textField] setStringValue:[users objectAtIndex:rowIndex]];
    
    return cellView;
}

#pragma mark - Table View Delegate

- (NSView *)tableView:(NSTableView *)tableView
   viewForTableColumn:(NSTableColumn *)tableColumn
                  row:(NSInteger)row {
    
    NSTableCellView *cellView = [userTable makeViewWithIdentifier:@"userItem" owner:self];
    
    if (cellView == nil) {
        
        cellView = [[NSTableCellView alloc] initWithFrame:NSMakeRect(0, 0, 20.0, 20.0)];
        [cellView setIdentifier:@"userItem"];
    }
    [[cellView textField] setStringValue:[users objectAtIndex:row]];
    
//    [cellView.imageView setImage:[self getProfileImageInRow:row]];
    
    [twitter profileImageFor:[users objectAtIndex:row]
                successBlock:^(id image) {
                    [cellView.imageView setImage:image];
                }
                  errorBlock:^(NSError *error) {
                      NSLog(@"imageError: %@", error);
                  }];
    
    return cellView;
}

//- (NSImage *)getProfileImageInRow:(NSInteger)row {
//    
//    imageForUser = [[NSImage alloc] init];
//    
//    [twitter profileImageFor:[users objectAtIndex:row]
//                successBlock:^(id image) {
//                    imageForUser = image;
////                    NSLog(@"imageForUser: %@", imageUser);
//                }
//                  errorBlock:^(NSError *error) {
//                      NSLog(@"imageError: %@", error);
//                  }];
//    NSLog(@"imageForUser: %@", imageForUser);
//    return imageForUser;
//}

@end
