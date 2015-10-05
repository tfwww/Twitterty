//
//  UserInfo.h
//  
//
//  Created by Wunmin on 15/10/4.
//
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject <NSCopying, NSCoding> {
    
    NSString *screenName;
    NSImage *profileImage;
}

@property (nonatomic, retain) NSString *screenName;
@property (nonatomic, retain) NSImage *profileImage;

@end
