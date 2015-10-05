//
//  UserInfo.m
//  
//
//  Created by Wunmin on 15/10/4.
//
//

#import "UserInfo.h"

@implementation UserInfo

@synthesize screenName;
@synthesize profileImage;

- (void)encodeWithCoder:(NSCoder *)encoder {
    
    [encoder encodeObject:[self screenName] forKey:@"screenName"];
    [encoder encodeObject:[self profileImage] forKey:@"profileImage"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    
    self = [super init];
    if (self) {
        
        screenName = [decoder decodeObjectForKey:@"screenName"];
        profileImage = [decoder decodeObjectForKey:@"profileImage"];
    }
    
    return self;
}

-(id)copyWithZone:(NSZone *)zone {
    
    return self;
}

@end
