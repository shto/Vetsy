//
//  FEEventLoader.m
//  FB Events
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
        eventsURL = url;
        waitingDelegate = delegate;
    }
    return self;
}

- (void)startGettingEvents {
    urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:eventsURL]
                                  cachePolicy:NSURLRequestUseProtocolCachePolicy
                              timeoutInterval:30.0];
    
    urlConnection = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
    if (urlConnection) {
        receivedData = [[NSMutableData data] retain];
    } else {
        // call delegate
        [waitingDelegate failWithError:nil];
    }
}

// calculate events from data
- (NSArray *)events {
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

# pragma mark - Delegates for URL connection

// failed with error
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Failed!");
    [waitingDelegate failWithError:error];
}

// received data
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    if (connection == urlConnection) {
        [receivedData appendData:data];
    }
}

// done! we got all the data
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    if (connection == urlConnection) {
        if (waitingDelegate && [waitingDelegate respondsToSelector:@selector(eventsLoaded:)]) {
            [waitingDelegate eventsLoaded:[self events]];
            [urlConnection release];
        }
    }
}

@end
