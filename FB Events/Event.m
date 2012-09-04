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
@synthesize location;
@synthesize name;
@synthesize privacy;
@synthesize venue;
@synthesize rsvp_status;
@synthesize eventID;

#pragma mark Overriden Properties

- (void)populateObject:(NSData *)data {
    [super populateObject:data];
    
    NSDictionary *dictionary = [data yajl_JSON];
    NSLog(@"event dictionary: %@", dictionary);
    
    self.eventID = [dictionary valueForKey:@"id"];
    
    for (NSString *key in dictionary) {
        if ([self respondsToSelector:NSSelectorFromString(key)]) {
            [self setValue:[dictionary valueForKey:key] forKey:key];
        }
    }
    
    loaded = YES;
}

- (void)dealloc
{
    [description release];
    [location release];
    [name release];
    [privacy release];
    [venue release];
    [rsvp_status release];
    [eventID release];
    
    [start_time release];
    [end_time release];
    [update_time release];
    [super dealloc];
}

#pragma mark - Setters and Getters

// we set a string in the different setters
- (void)setEnd_time:(NSString *)endTime {
    if (end_time) {
        [end_time release];
    }
    
    end_time = [endTime retain];
}

- (void)setStart_time:(NSString *)startTime {
    if (start_time) {
        [start_time release];
    }
    
    start_time = [startTime retain];
}

- (void)setUpdate_time:(NSString *)updateTime {
    if (update_time) {
        [update_time release];
    }
    
    update_time = [updateTime retain];
}

// we get back a date from the getters
- (NSDate *)end_time {
    return [FacebookObject dateFromString:end_time];
}

- (NSDate *)start_time {
    return [FacebookObject dateFromString:start_time];
}

- (NSDate *)update_time {
    return [FacebookObject dateFromString:update_time];
}

@end
