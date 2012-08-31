//
//  FEFacebookObject.m
//  Vetsy
//
//  Created by Andrei on 8/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FacebookObject.h"

@implementation FacebookObject

@synthesize objectFacebookGraphID;
@synthesize loaded;

- (id)initWithID:(NSString *)objectID {
    self = [super init];
    if (self) {
        loaded = NO;
        objectFacebookGraphID = objectID;
        [self beginPopulatingObject];
    }
    return self;
}

- (void)beginPopulatingObject {
    NSURL *getURL = [NSURL URLWithString:[kFacebookGraphURL stringByAppendingFormat:
                                          @"%@?access_token=%@",
                                          objectFacebookGraphID, 
                                          [[FESessionSingleton session] accessToken]]];
    
    proxy = [[FEProxy alloc] initAndGetFromURL:getURL delegate:self];
}

- (void)populateObject:(NSData *)data {
    // nothing to do here. should be overriden in children classes
}

#pragma mark - Proxy Delegate

- (void)failedWithError:(NSError *)error {
    
}

- (void)done:(NSData *)data {
    [proxy release]; proxy = nil;
    [self populateObject:data];
}

@end
