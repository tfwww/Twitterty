//
//  AuthenticationViewController.m
//  Twitterty
//
//  Created by Wunmin on 15/8/25.
//  Copyright (c) 2015年 Wunmin. All rights reserved.
//

#import "HomeTimelineViewController.h"
#import "Sidebar.h"

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
    NSString *consumerKey = @"9cdFRYobskEMT2FcP0YZ5w2Zw";
    NSString *consuemrSecret = @"KCa6WUcv8DCkB6mfMK3EBmd6aBX5DpTNajgneYgjVbJEw4bJYu";
    NSString *oauthToken = @"105745339-TujlsXUir2p8B8gEVNSgOev8cS3kHGEHQ4Sa1AR1";
    NSString *oauthTokenSecret = @"7W2hfl7jl5QjY8LubOjBFOI5P2kmHr7OD2CmzMPV2c";
    // NSString *screenName = @"MyEvil_";
    
    twitter = [STTwitterAPI twitterAPIWithOAuthConsumerKey:consumerKey
                                            consumerSecret:consuemrSecret
                                                oauthToken:oauthToken
                                          oauthTokenSecret:oauthTokenSecret];
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
                                  count:50
                           successBlock:^(NSArray *statuses) {
                               NSLog(@"Statuses: %lu", (unsigned long)[statuses count]);
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
    
    return [[tweetData objectAtIndex:rowIndex] valueForKey:@"text"];
}

#pragma mark - Table View Delegate

- (NSView *)tableView:(NSTableView *)tableView
   viewForTableColumn:(NSTableColumn *)tableColumn
                  row:(NSInteger)row {
    
    NSTextField *result = [tableView makeViewWithIdentifier:@"tweetItem" owner:self];
    
    if (result == nil) {
        
        result = [[NSTextField alloc] initWithFrame:NSMakeRect(0, 0, 20.0, 20.0)];
        [result setIdentifier:@"tweetItem"];
    }
    
    [result setObjectValue:[tweetData objectAtIndex:row]];
    return result;
    
}

@end
