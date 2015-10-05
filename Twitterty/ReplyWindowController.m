//
//  ReplyWindowController.m
//  Twitterty
//
//  Created by Wunmin on 15/9/8.
//  Copyright (c) 2015年 Wunmin. All rights reserved.
//

#import "ReplyWindowController.h"
#import "HomeTimelineViewController.h"
#import "STTwitterAPI.h"
#import "SSKeychain.h"

@interface ReplyWindowController () {
    
    STTwitterAPI *twitterAPI;
}

@property (weak) IBOutlet NSWindow *replyWindow;

@end


@implementation ReplyWindowController
@synthesize replyText;
@synthesize replyName;
@synthesize tweetsData;

- (void)windowDidLoad {
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
//    HomeTimelineViewController *timelineVC = [[HomeTimelineViewController alloc] initWithNibName:@"HomeTimelineViewController" bundle:nil];
//    
//    [timelineVC changeReplyTextInRow];
    
    NSArray *tokenServices = [SSKeychain accountsForService:kOauthTokenKeychainService];
    NSArray *tokenSecretServices = [SSKeychain accountsForService:kOauthTokenSecretKeychainService];
    NSString *accessToken = [SSKeychain passwordForService:kOauthTokenKeychainService account:tokenServices[0]];
    NSString *accessTokenSecret = [SSKeychain passwordForService:kOauthTokenSecretKeychainService account:tokenSecretServices[0]];

    twitterAPI = [STTwitterAPI twitterAPIWithOAuthConsumerKey:kConsumerKey
                                            consumerSecret:kConsuemrSecret
                                                oauthToken:accessToken
                                          oauthTokenSecret:accessTokenSecret];
//    [twitterAPI getHomeTimelineSinceID:nil
//                              count:10
//                       successBlock:^(NSArray *statuses) {
//                           //NSLog(@"Statuses:%@", statuses);
//                           tweetsData = statuses;
//                           
//                           
//                       }
//                         errorBlock:^(NSError *error) {
//                             NSLog(@"Failed with error: %@", [error localizedDescription]);
//                         }];
    
}

- (IBAction)cancelReplyText:(id)sender {
    
    [[self replyWindow] performClose:sender];

}

- (IBAction)postReplyText:(id)sender {
    
    NSString *nameStrWithSpace;
    if ([[replyName stringValue] length] > 0) {
        
        NSString *nameStr = [[replyName stringValue] substringToIndex:[[replyName stringValue] length] - 1];
        nameStrWithSpace = [NSString stringWithFormat:@"%@ ", nameStr];
    }
    
    NSString *replyData = [nameStrWithSpace stringByAppendingString:[replyText stringValue]];
    NSLog(@"replyData: %@", replyData);
    [twitterAPI postStatusUpdate:replyData
               inReplyToStatusID:nil
                        latitude:nil
                       longitude:nil
                         placeID:nil
              displayCoordinates:nil
                        trimUser:nil
                    successBlock:^(NSDictionary *status) {
//                        NSLog(@"status: %@", status);
                        
                    }
                      errorBlock:^(NSError *error) {
                          NSLog(@"status: %@", error);
                      }];
    [[self replyWindow] performClose:sender];
}

@end
