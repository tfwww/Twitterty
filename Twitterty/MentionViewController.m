//
//  MentionViewController.m
//  Twitterty
//
//  Created by Wunmin on 15/9/22.
//  Copyright (c) 2015年 Wunmin. All rights reserved.
//

#import "MentionViewController.h"
#import "TweetCellView.h"

@interface MentionViewController ()

@end

@implementation MentionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    twitterAPI = [STTwitterAPI twitterAPIWithOAuthConsumerKey:kConsumerKey
                                               consumerSecret:kConsuemrSecret
                                                   oauthToken:kOauthToken
                                             oauthTokenSecret:kOauthTokenSecret];
    [twitterAPI getMentionsTimelineSinceID:nil
                                     count:10
                              successBlock:^(NSArray *statuses) {
                                  mentionTweets = statuses;
                                  [mentionTable reloadData];

//                                  NSLog(@"mention: %@", mentionTweets);
                              }
                                errorBlock:^(NSError *error) {
                                    NSLog(@"mentionError: %@", error);
                                }];

}

#pragma mark - Table View Data Source

- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView {

    return [mentionTweets count];
}

- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex {
    
    TweetCellView *cellView = [mentionTable makeViewWithIdentifier:@"tweetItem" owner:self];
    [[cellView textField] setStringValue:[[mentionTweets objectAtIndex:rowIndex] valueForKey:@"text"]];
    
    return cellView;
}

#pragma mark - Table View Delegate

- (NSView *)tableView:(NSTableView *)tableView
   viewForTableColumn:(NSTableColumn *)tableColumn
                  row:(NSInteger)row {
    
    TweetCellView *cellView = [mentionTable makeViewWithIdentifier:@"tweetItem" owner:self];
    
    if (cellView == nil) {
        
        cellView = [[TweetCellView alloc] initWithFrame:NSMakeRect(0, 0, 20.0, 20.0)];
        [cellView setIdentifier:@"tweetItem"];
    }
    [[cellView textField] setStringValue:[[mentionTweets objectAtIndex:row] valueForKey:@"text"]];
    
    [cellView.imageView setImage:[self getProfleImageInRow:row]];
    [[cellView screenNameLabel] setStringValue:[[mentionTweets objectAtIndex:row] valueForKeyPath:@"user.screen_name"]];
    
    return cellView;
}

#pragma mark -

- (NSImage *)getProfleImageInRow:(NSInteger)row {
    
    NSDictionary *tweetDictionary = [mentionTweets objectAtIndex:row];
    NSString *imageURLString = [tweetDictionary valueForKeyPath:@"user.profile_image_url"];
    NSURL *imageURL = [[NSURL alloc] initWithString:imageURLString];
    NSImage *image = [[NSImage alloc] initWithContentsOfURL:imageURL];
    
    return image;
}

- (IBAction)mentionTweetReply:(id)sender {
    
    replyWC = [[ReplyWindowController alloc] initWithWindowNibName:@"ReplyWindowController"];
    [replyWC showWindow:self];
    
    NSInteger row = [mentionTable rowForView:sender];
//    NSDictionary *tweetInRow = [mentionTweets objectAtIndex:row];
//    [replyWC setValue:tweetInRow forKey:@"_tweetToReply"];
    
    NSString *screenName = [[mentionTweets objectAtIndex:row] valueForKeyPath:@"user.screen_name"];
    NSString *screenNameWithSymbol = [NSString stringWithFormat:@"@%@:", screenName];
    
    [[replyWC replyName] setStringValue:screenNameWithSymbol];
}
@end
