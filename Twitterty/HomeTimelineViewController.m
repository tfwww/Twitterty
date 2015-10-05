//
//  AuthenticationViewController.m
//  Twitterty
//
//  Created by Wunmin on 15/8/25.
//  Copyright (c) 2015年 Wunmin. All rights reserved.
//

#import "HomeTimelineViewController.h"
#import "Sidebar.h"
#import "TweetCellView.h"
#import "ReplyWindowController.h"
#import "SSKeychain.h"
#import "PreferenceController.h"
#import "UserInfo.h"

NSString *const kConsumerKey = @"9cdFRYobskEMT2FcP0YZ5w2Zw";
NSString *const kConsuemrSecret = @"KCa6WUcv8DCkB6mfMK3EBmd6aBX5DpTNajgneYgjVbJEw4bJYu";
NSString *const kOauthTokenKeychainService = @"com.wunmin.twitter.AccessToken";
NSString *const kOauthTokenSecretKeychainService = @"com.wunmin.twitter.AccessTokenSecret";

@interface HomeTimelineViewController ()

@end

@implementation HomeTimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do view setup here.
    
    [self getHomeTimeline];
    
//    [self changeReplyTextInRow];
    //[self drawBorderWithColor:[NSColor whiteColor]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(changeHomeTimeline:)
                                                 name:kAccountChangedNotificaton
                                               object:nil];
}

//- (NSString *)changeAccountToken {
//    
//    // Access the token in the keychain
//    // only allow one account in keychain, will support mult-accounts in the future
//    NSArray *tokenServices = [SSKeychain accountsForService:kOauthTokenKeychainService];
//    NSString *accessToken = [SSKeychain passwordForService:kOauthTokenKeychainService account:[tokenServices[0] objectForKey:@"acct"]];
//    return accessToken;
//}
//
//- (NSString *)changeAccountTokenSecret {
//    
//    NSArray *tokenSecretServices = [SSKeychain accountsForService:kOauthTokenSecretKeychainService];
//    NSString *accessTokenSecret = [SSKeychain passwordForService:kOauthTokenSecretKeychainService account:[tokenSecretServices[0] objectForKey:@"acct"]];
//
//    return accessTokenSecret;
//}

- (void)getHomeTimeline {
    
    // Access the token in the keychain
    // only allow one account in keychain, will support mult-accounts in the future
    NSArray *tokenServices = [SSKeychain accountsForService:kOauthTokenKeychainService];
    NSArray *tokenSecretServices = [SSKeychain accountsForService:kOauthTokenSecretKeychainService];
    
//    NSLog(@"tokenServices: %@", [tokenServices[0] objectForKey:@"acct"]);
//    NSLog(@"tokenSecretServices: %@", tokenSecretServices[0]);
    
    NSString *accessToken = [SSKeychain passwordForService:kOauthTokenKeychainService account:[tokenServices[0] objectForKey:@"acct"]];
    NSString *accessTokenSecret = [SSKeychain passwordForService:kOauthTokenSecretKeychainService account:[tokenSecretServices[0] objectForKey:@"acct"]];
    
//    NSLog(@"accessToken: %@", accessToken);
//    NSLog(@"accessTokenSecret: %@", accessTokenSecret);
    
    // Get authentication from twitter
    twitter = [STTwitterAPI twitterAPIWithOAuthConsumerKey:kConsumerKey
                                            consumerSecret:kConsuemrSecret
                                                oauthToken:accessToken
                                          oauthTokenSecret:accessTokenSecret];
    
    [twitter verifyCredentialsWithUserSuccessBlock:^(NSString *username, NSString *userID) {
        
        NSLog(@"Success with username: %@ and userID: %@", username, userID);
    
        // GetUserTimeline
//        [twitter getUserTimelineWithScreenName:screenName
//                                  successBlock:^(NSArray *statuses) {
//                                      NSLog(@"Statuses: %@", statuses);
//                                      
//                                  }
//                                    errorBlock:^(NSError *error) {
//                                      NSLog(@"Failed with error: %@", [error localizedDescription]);
//                                  }];
        
        // GetUserTimeline with count
//        [twitter getUserTimelineWithScreenName:screenName
//                                         count:50
//                                  successBlock:^(NSArray *statuses) {
//                                      NSLog(@"Statuses: %@", statuses);
//                                  }
//                                    errorBlock:^(NSError *error) {
//                                        NSLog(@"Failed with error: %@", [error localizedDescription]);
//                                    }];
        
        // Get Home timeline
        [twitter getHomeTimelineSinceID:nil
                                  count:10
                           successBlock:^(NSArray *statuses) {
//                               NSLog(@"Statuses:%@", statuses);
                               tweetData = statuses;
                               
//                               [replyController setValue:[tweetData[1] valueForKeyPath:@"user.screen_name"] forKey:@"replyText"];
//                               replyController->tweetsData = [NSMutableArray arrayWithArray:statuses];
//                               NSLog(@"reply: %@", [replyController valueForKey:@"replyText"]);
                               
                               [[self tweetsTable] reloadData];
//                               [[self tweetsTable] selectedRow];
                               
                           }
                             errorBlock:^(NSError *error) {
                                 NSLog(@"Failed with error: %@", [error localizedDescription]);
                             }];
        
    } errorBlock:^(NSError *error) {
        NSLog(@"Failed with error: %@", [error localizedDescription]);
    }];
}

//- (void)getProfileImage {

//    twitter = [STTwitterAPI twitterAPIWithOAuthConsumerKey:kConsumerKey
//                                            consumerSecret:kConsuemrSecret
//                                                oauthToken:kOauthToken
//                                          oauthTokenSecret:kOauthTokenSecret];
//    [twitter verifyCredentialsWithUserSuccessBlock:^(NSString *username, NSString *userID) {
//        
//        NSLog(@"Success with username: %@ and userID: %@", username, userID);
//        
//        [twitter getUsersShowForUserID:nil orScreenName:@"barackobama" includeEntities:nil successBlock:^(NSDictionary *user) {
//            
//            NSString *profileImageURLString = [user valueForKey:@"profile_image_url"];
//            NSURL *url = [NSURL URLWithString:profileImageURLString];
//            profileImage = [[NSImage alloc] initWithContentsOfURL:url];
//            NSLog(@"profileImage: %@", profileImage);
//            
//        } errorBlock:^(NSError *error) {
//            NSLog(@"Failed with error: %@", [error localizedDescription]);
//        }];
//        
//    } errorBlock:^(NSError *error) {
//        NSLog(@"Failed with error: %@", [error localizedDescription]);
//    }];
//}

//- (void)drawBorderWithColor:(NSColor *)color {
//    
//    // Convert to CGColorRef
//    NSInteger numberOfComponents = [color numberOfComponents];
//    CGFloat components[numberOfComponents];
//    CGColorSpaceRef colorSpace = [[color colorSpace] CGColorSpace];
//    [color getComponents:(CGFloat *)&components];
//    CGColorRef whiteCGColor = CGColorCreate(colorSpace, components);
//    self.view.layer.borderColor = whiteCGColor;
//    
//}

#pragma mark - Table View Data Source

- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView {

    return [tweetData count];
}

- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex {
    
    TweetCellView *cellView = [[self tweetsTable] makeViewWithIdentifier:@"tweetItem" owner:self];
    [[cellView textField] setStringValue:[[tweetData objectAtIndex:rowIndex] valueForKey:@"text"]];
    
    return cellView;
}

#pragma mark - Table View Delegate

- (NSView *)tableView:(NSTableView *)tableView
   viewForTableColumn:(NSTableColumn *)tableColumn
                  row:(NSInteger)row {
    
    TweetCellView *cellView = [[self tweetsTable] makeViewWithIdentifier:@"tweetItem" owner:self];
    
    if (cellView == nil) {
        
        cellView = [[TweetCellView alloc] initWithFrame:NSMakeRect(0, 0, 20.0, 20.0)];
        [cellView setIdentifier:@"tweetItem"];
    }
    [[cellView textField] setStringValue:[[tweetData objectAtIndex:row] valueForKey:@"text"]];
    
    [cellView.imageView setImage:[self getProfileImageInRow:row]];
    [[cellView screenNameLabel] setStringValue:[[tweetData objectAtIndex:row] valueForKeyPath:@"user.screen_name"]];
    
    return cellView;
}

#pragma mark -

- (NSImage *)getProfileImageInRow:(NSInteger)row {
    
    NSDictionary *tweetDictionary = [tweetData objectAtIndex:row];
    NSString *imageURLString = [tweetDictionary valueForKeyPath:@"user.profile_image_url"];
    NSURL *imageURL = [[NSURL alloc] initWithString:imageURLString];
    NSImage *image = [[NSImage alloc] initWithContentsOfURL:imageURL];
    
    return image;
}

//- (IBAction)replyButtonClicked:(id)sender {
//    
//    replyController = [[ReplyWindowController alloc] initWithWindowNibName:@"ReplyWindowController"];
//    [replyController showWindow:self];
//
//    NSInteger selectedRow = [[self tweetsTable] selectedRow];
//    NSString *screenName = [[tweetData objectAtIndex:selectedRow] valueForKeyPath:@"user.screen_name"];
//    NSString *screenNameWithSymbol = [NSString stringWithFormat:@"@%@ ", screenName];
//    [[replyController replyText] setStringValue:screenNameWithSymbol];
//
//    NSLog(@"screenName: %@", screenNameWithSymbol);
//
//    [[self tweetsTable] selectedRow];
//    NSLog(@"selectedRow: %ld", [[self tweetsTable] selectedRow]);
//
//}

//- (void)replyButton:(id)sender {
//    
////    [self getHomeTimeline];
////    
////    ReplyWindowController *replyController = [[ReplyWindowController alloc] initWithWindowNibName:@"ReplyWindowController"];
////    [replyController showWindow:self];
//    
////    HomeTweetCellView *cellView = [[self tweetsTable] makeViewWithIdentifier:@"tweetItem" owner:self];
//    
//    NSInteger selectedRow = [[self tweetsTable] selectedRow];
//    [tweetData objectAtIndex:selectedRow];
//    NSLog(@"RowForView: %ld", [[self tweetsTable] selectedRow]);
//    
//}

- (IBAction)replyButtonClicked:(id)sender {
    
    replyController = [[ReplyWindowController alloc] initWithWindowNibName:@"ReplyWindowController"];
    [replyController showWindow:self];

    NSInteger row = [[self tweetsTable] rowForView:sender];
//    NSDictionary *tweetInRow = [tweetData objectAtIndex:row];
//    [replyController setValue:tweetInRow forKey:@"_tweetToReply"];
    
    NSString *screenName = [[tweetData objectAtIndex:row] valueForKeyPath:@"user.screen_name"];
    NSString *screenNameWithSymbol = [NSString stringWithFormat:@"@%@:", screenName];
    
    [[replyController replyName] setStringValue:screenNameWithSymbol];
}

#pragma mark - When the login account changes

- (void)changeHomeTimeline:(NSNotification *)notification {
    
    NSArray *users = [[notification userInfo] objectForKey:@"users"];
    NSLog(@"notification: %@", ((UserInfo *)users[0]).screenName);
    
    NSString *accessToken = [SSKeychain passwordForService:kOauthTokenKeychainService account:((UserInfo *)users[0]).screenName];
    NSString *accessTokenSecret = [SSKeychain passwordForService:kOauthTokenSecretKeychainService account:((UserInfo *)users[0]).screenName];

    twitter = [STTwitterAPI twitterAPIWithOAuthConsumerKey:kConsumerKey
                                            consumerSecret:kConsuemrSecret
                                                oauthToken:accessToken
                                          oauthTokenSecret:accessTokenSecret];

    [twitter getHomeTimelineSinceID:nil
                              count:10
                       successBlock:^(NSArray *statuses) {
                           tweetData = statuses;

                           [[self tweetsTable] reloadData];
                           
                       }
                         errorBlock:^(NSError *error) {
                             NSLog(@"Failed with error: %@", [error localizedDescription]);
                         }];
}

@end
