//
//  FEEventLoader.m
//  Vetsy
//
//  Created by Andrei on 8/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FEEventLoader.h"

@implementation FEEventLoader

@synthesize numberOfLoadedEvents;

- (id)initWithEventsURL:(NSString *)url andDelegate:(id<FEEventLoaderDelegate>)delegate
{
    self = [super init];
    if (self) {
        eventsURL = [url retain];
        waitingDelegate = [delegate retain];
        self.numberOfLoadedEvents = 0;
    }
    return self;
}

- (void)dealloc
{
    [eventsURL release];
    [waitingDelegate release];
    [super dealloc];
}

- (void)startGettingEvents {
    proxy = [[FEProxy alloc] initAndGetFromURL:[NSURL URLWithString:eventsURL] delegate:self];
}

// calculate events from data
- (NSArray *)eventsFromData:(NSData *)receivedData {
    NSMutableArray *returnedArray = [NSMutableArray array];        
    NSDictionary *dictionary = [receivedData yajl_JSON];

    NSArray *allEvents = [dictionary objectForKey:@"data"];
    for (NSDictionary *eventDict in allEvents) {
        // only get events from now onwards
        NSLog(@"event start date: %@", [eventDict objectForKey:@"start_time"]);
        if ([[FacebookObject dateFromString:[eventDict objectForKey:@"start_time"]] 
                                    compare:[NSDate date]] == NSOrderedDescending) 
        {
            Event *event = [[Event alloc] initWithID:[eventDict objectForKey:@"id"]];
            [event setLoadedDelegate:self];
            [returnedArray addObject:event];
            [event release];
        }        
    }
    
    return returnedArray;
}

# pragma mark - FEProxy Delegates

- (void)failedWithError:(NSError *)error {
    NSLog(@"Failed!");
    [waitingDelegate failWithError:error];
}

- (void)done:(NSData *)data {
    if (waitingDelegate && [waitingDelegate respondsToSelector:@selector(eventsLoaded:)]) {
        [waitingDelegate eventsLoaded:[self eventsFromData:data]];
    }
}

#pragma mark - FacebookObject Loaded Delegate

- (void)loadComplete {
    self.numberOfLoadedEvents++;
}

@end
