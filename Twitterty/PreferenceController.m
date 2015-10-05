//
//  PreferenceController.m
//  Twitterty
//
//  Created by Wunmin on 15/9/25.
//  Copyright (c) 2015年 Wunmin. All rights reserved.
//

#import "PreferenceController.h"
#import "SSKeychain.h"
#import "UserInfo.h"

@interface PreferenceController () {
    
    NSMutableArray *users;
    NSImage *imageForUser;
}

@end

@implementation PreferenceController

- (void)windowDidLoad {
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    NSData *usersAsData = [[NSUserDefaults standardUserDefaults] objectForKey:@"users"];
    users = [NSKeyedUnarchiver unarchiveObjectWithData:usersAsData];
    
    [userTable reloadData];
    NSLog(@"windowDidLoad users: %@", ((UserInfo *)users[0]).profileImage);

}

#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder *)encoder {
    
    [encoder encodeObject:users forKey:@"users"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    
    self = [super initWithCoder:decoder];
    if (self) {
        
        users = [decoder decodeObjectForKey:@"users"];
    }
    return self;
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
    
//    if ([SSKeychain accountsForService:@"TwittertyAccessToken"]) {
//        
//        NSString *accessToken = [SSKeychain passwordForService:@"TwittertyAccessToken"
//                                                       account:@"com.twitterty.keychain"];
//        
//        NSString *accessSecret = [SSKeychain passwordForService:@"TwittertyAccessTokenSecret"
//                                                        account:@"com.twitterty.keychain"];
//        
//        twitter = [STTwitterAPI twitterAPIWithOAuthConsumerKey:kConsumerKey
//                                      consumerSecret:kConsuemrSecret
//                                          oauthToken:accessToken
//                                    oauthTokenSecret:accessSecret];
//        
//        [twitter verifyCredentialsWithUserSuccessBlock:^(NSString *username, NSString *userID) {
//            
//            UserInfo *user = [[UserInfo alloc] init];
//            [user setScreenName:username];
//            
//            users = [[NSMutableArray alloc] init];
//            [users addObject:user];
//            
//            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//            NSData *usersAsData = [NSKeyedArchiver archivedDataWithRootObject:users];
//
//            [userDefaults setObject:usersAsData forKey:@"users"];
//            [userDefaults synchronize];
//
//            NSLog(@"userDefaults: %@", [userDefaults objectForKey:@"users"]);
//
//            
//            NSLog(@"screenName: %@", users[0]);
//            [userTable reloadData];
//            
////            NSLog(@"Success with username: %@ and userID: %@", username, userID);
//            
//        } errorBlock:^(NSError *error) {
//            NSLog(@"Failed with error: %@", [error localizedDescription]);
//        }];
//
//    } else {
    
            [twitter postAccessTokenRequestWithPIN:verifier successBlock:^(NSString *oauthToken, NSString *oauthTokenSecret, NSString *userID, NSString *screenName) {
            
                UserInfo *user = [[UserInfo alloc] init];
                [user setScreenName:screenName];
                
                users = [[NSMutableArray alloc] init];
                [users addObject:user];
                
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                NSData *usersAsData = [NSKeyedArchiver archivedDataWithRootObject:users];

                [userDefaults setObject:usersAsData forKey:@"users"];
                [userDefaults synchronize];
                
                NSLog(@"userDefaults: %@", [userDefaults objectForKey:@"users"]);

                
                NSLog(@"screenName: %@", users[0]);
                
                // Store the token in keychain
                //        [SSKeychain setAccessibilityType:kSecAttrAccessibleWhenUnlocked];
                [SSKeychain setPassword:twitter.oauthAccessToken forService:@"TwittertyAccessToken" account:@"com.twitterty.keychain"];
                [SSKeychain setPassword:twitter.oauthAccessTokenSecret forService:@"TwittertyAccessTokenSecret" account:@"com.twitterty.keychain"];
            
                //        NSLog(@"SSKeychain oauthAccessToken: %@", [SSKeychain passwordForService:@"TwittertyAccessToken" account:@"com.twitterty.keychain"]);
            
            
                //        twitter.oauthAccessToken
                //        twitter.oauthAccessTokenSecret
                [userTable reloadData];
            
            } errorBlock:^(NSError *error) {
            
                NSLog(@"authenticate error: %@", error);
            }];

}

#pragma mark - Table View Data Source

- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView {
    
    NSLog(@"users: %ld", [users count]);
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
    
   
//    [[cellView textField] setStringValue:[[users objectAtIndex:row] screenName]];
    
//    [cellView.imageView setImage:[self getProfileImageInRow:row]];
    
    [twitter profileImageFor:[[users objectAtIndex:row] screenName]
                successBlock:^(id image) {
                    [cellView.imageView setImage:image];
                    
                    [[users objectAtIndex:row] setProfileImage:image];
//                    NSLog(@"profileImage: %@", ((UserInfo *)users[0]).profileImage);
                    
                    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                    
                    NSData *usersAsData = [NSKeyedArchiver archivedDataWithRootObject:users];
                    [userDefaults setObject:usersAsData forKey:@"users"];
                    [userDefaults synchronize];
                    
                }
                  errorBlock:^(NSError *error) {
                      NSLog(@"imageError: %@", error);
                  }];
    
    NSData *usersAsData = [[NSUserDefaults standardUserDefaults] objectForKey:@"users"];
    
    NSArray *decodedUsers = [NSKeyedUnarchiver unarchiveObjectWithData:usersAsData];
    
    [[cellView textField] setStringValue:[[decodedUsers objectAtIndex:row] screenName]];
    [[cellView imageView] setImage:((UserInfo *)users[0]).profileImage];
//    NSLog(@"decodedUsers screenName: %@", [[decodedUsers objectAtIndex:row] profileImage]);

    
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
