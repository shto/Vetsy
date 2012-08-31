//
//  FESessionSingleton.m
//  Vetsy
//
//  Created by Andrei on 8/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FESessionSingleton.h"

static FESessionSingleton *feSessionSingletonObject;

@implementation FESessionSingleton
@synthesize session;
@synthesize eventsURL;

+ (FBSession *)session {
    return [[self sharedSession] session];
}

+ (FESessionSingleton *)sharedSession {
    if (!feSessionSingletonObject) {
        feSessionSingletonObject = [[FESessionSingleton alloc] init];
    }
    
    return feSessionSingletonObject;
}

- (id)init
{
    self = [super init];
    if (self) {
        session = [[FBSession alloc] initWithPermissions:[NSArray arrayWithObjects:@"user_events", @"friends_events", nil]];
    }
    return self;
}

- (NSString *)eventsURL {
    if (!eventsURL) {
        if (session.accessToken) {
            eventsURL = [NSString stringWithFormat:@"https://graph.facebook.com/me/events?access_token=%@", session.accessToken];
        }
    }
    
    return eventsURL;
}

@end
