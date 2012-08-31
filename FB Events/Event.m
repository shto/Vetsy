//
//  Event.m
//  FB Events
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

@synthesize loaded;

- (id)initWithID:(NSString *)evID
{
    self = [super init];
    if (self) {
        loaded = NO;
        self.eventID = evID;
        
        // begin process of getting the event data
        [self beginPopulatingEvent];
    }
    return self;
}

- (id)initFromJSONDictionary:(NSDictionary *)jsonDict
{
    self = [super init];
    if (self) {
        for (NSString *key in jsonDict) {
            if ([self respondsToSelector:NSSelectorFromString(key)]) {
                [self setValue:[jsonDict objectForKey:key] forKey:key];
            }
        }
    }
    return self;
}

- (void)populateProperties {
    NSDictionary *dictionary = [receivedData yajl_JSON];
    NSLog(@"event dictionary: %@", dictionary);
    
    for (NSString *key in dictionary) {
        if ([self respondsToSelector:NSSelectorFromString(key)]) {
            [self setValue:[dictionary valueForKey:key] forKey:key];
        }
    }
    
    loaded = YES;
}

#pragma mark - Connection

- (void)beginPopulatingEvent {
    NSString *urlString = [kFacebookGraphURL stringByAppendingFormat:
                           @"%@?access_token=%@",
                           eventID, [[FESessionSingleton session] accessToken]];
    
    urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]
                                  cachePolicy:NSURLRequestUseProtocolCachePolicy
                              timeoutInterval:30.0];
    
    urlConnection = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
    if (urlConnection) {
        receivedData = [[NSMutableData data] retain];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    if (connection == urlConnection) {
        [receivedData appendData:data];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    if (connection == urlConnection) {
        [self populateProperties];
        [self closeConnection];
    }
}

- (void)closeConnection {
    [urlConnection release];
    urlConnection = nil;
    [receivedData release];
    receivedData = nil;
}

@end
