//
//  AuthenticationViewController.m
//  Twitterty
//
//  Created by Wunmin on 15/8/25.
//  Copyright (c) 2015年 Wunmin. All rights reserved.
//

#import "HomeTimelineViewController.h"
#import "Sidebar.h"

NSString *const kConsumerKey = @"9cdFRYobskEMT2FcP0YZ5w2Zw";
NSString *const kConsuemrSecret = @"KCa6WUcv8DCkB6mfMK3EBmd6aBX5DpTNajgneYgjVbJEw4bJYu";
NSString *const kOauthToken = @"105745339-TujlsXUir2p8B8gEVNSgOev8cS3kHGEHQ4Sa1AR1";
NSString *const kOauthTokenSecret = @"7W2hfl7jl5QjY8LubOjBFOI5P2kmHr7OD2CmzMPV2c";

@interface HomeTimelineViewController ()

@end

@implementation HomeTimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do view setup here.
    
    [self getHomeTimeline];
    //[self drawBorderWithColor:[NSColor whiteColor]];
}

- (void)getHomeTimeline {
    
    // Get authentication from twitter
    twitter = [STTwitterAPI twitterAPIWithOAuthConsumerKey:kConsumerKey
                                            consumerSecret:kConsuemrSecret
                                                oauthToken:kOauthToken
                                          oauthTokenSecret:kOauthTokenSecret];
    
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
                               //NSLog(@"Statuses:%@", statuses);
                               tweetData = statuses;
                               
                               [[self tweetsTable] reloadData];
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
    
    NSTableCellView *cellView = [[self tweetsTable] makeViewWithIdentifier:@"tweetItem" owner:self];
    [[cellView textField] setStringValue:[[tweetData objectAtIndex:rowIndex] valueForKey:@"text"]];
    
    return cellView;
}

#pragma mark - Table View Delegate

- (NSView *)tableView:(NSTableView *)tableView
   viewForTableColumn:(NSTableColumn *)tableColumn
                  row:(NSInteger)row {
    
//    NSTableCellView *cellView = [[self tweetsTable] makeViewWithIdentifier:@"tweetItem" owner:self];
//    [[cellView textField] setStringValue:[tweetData objectAtIndex:row]];
//    [cellView.imageView setImage:profileImage];
    
    NSTableCellView *cellView = [[self tweetsTable] makeViewWithIdentifier:@"tweetItem" owner:self];
    
//    if (result == nil) {
//        
//        result = [[NSTextField alloc] initWithFrame:NSMakeRect(0, 0, 20.0, 20.0)];
//        [result setIdentifier:@"tweetItem"];
//    }
    
//    [cellView setObjectValue:[tweetData objectAtIndex:row]];
    
    if (cellView == nil) {
        
        cellView = [[NSTableCellView alloc] initWithFrame:NSMakeRect(0, 0, 20.0, 20.0)];
        [cellView setIdentifier:@"tweetItem"];
    }
    [[cellView textField] setStringValue:[[tweetData objectAtIndex:row] valueForKey:@"text"]];
    [cellView.imageView setImage:[self getProfleImageInRow:row]];
    return cellView;
}

- (NSImage *)getProfleImageInRow:(NSInteger)row {
    
    NSDictionary *tweetDictionary = [tweetData objectAtIndex:row];
    NSString *imageURLString = [tweetDictionary valueForKeyPath:@"user.profile_image_url"];
    NSURL *imageURL = [[NSURL alloc] initWithString:imageURLString];
    NSImage *image = [[NSImage alloc] initWithContentsOfURL:imageURL];
    
    return image;
}

@end
