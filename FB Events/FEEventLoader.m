//
//  FEEventLoader.m
//  Vetsy
//
//  Created by Andrei on 8/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FEEventLoader.h"

@implementation FEEventLoader

- (id)initWithEventsURL:(NSString *)url andDelegate:(id<FEEventLoaderDelegate>)delegate
{
    self = [super init];
    if (self) {
        eventsURL = [url retain];
        waitingDelegate = [delegate retain];
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
        Event *event = [[Event alloc] initWithID:[eventDict objectForKey:@"id"]];
        [returnedArray addObject:event];
        [event release];
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

@end
