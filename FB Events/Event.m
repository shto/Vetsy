//
//  Event.m
//  Vetsy
//
//  Created by Andrei on 8/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Event.h"

@implementation Event

@synthesize description;
@synthesize end_time;
@synthesize location;
@synthesize name;
@synthesize privacy;
@synthesize start_time;
@synthesize updated_time;
@synthesize venue;
@synthesize rsvp_status;
@synthesize eventID;

#pragma mark Overriden Properties

- (void)populateObject:(NSData *)data {
    [super populateObject:data];
    
    NSDictionary *dictionary = [data yajl_JSON];
    NSLog(@"event dictionary: %@", dictionary);
    
    for (NSString *key in dictionary) {
        if ([self respondsToSelector:NSSelectorFromString(key)]) {
            [self setValue:[dictionary valueForKey:key] forKey:key];
        }
    }
    
    loaded = YES;
}

@end
