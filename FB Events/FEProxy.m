//
//  FEProxy.m
//  Vetsy
//
//  Created by Andrei on 8/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FEProxy.h"

@implementation FEProxy

@synthesize callingDelegate;

- (id)initAndGetFromURL:(NSURL *)url delegate:(id)delegate
{
    self = [super init];
    if (self) {
        callingDelegate = delegate;
        urlRequest = [NSURLRequest requestWithURL:url
                                      cachePolicy:NSURLRequestUseProtocolCachePolicy
                                  timeoutInterval:30.0];
        
        urlConnection = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
        if (urlConnection) {
            data = [[NSMutableData data] retain];
        }
    }
    return self;
}

#pragma mark - Connection Delegates

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    if (connection == urlConnection) {
        if (callingDelegate && [callingDelegate respondsToSelector:@selector(failedWithError:)]) {
            [callingDelegate failedWithError:error];
            [self closeConnection];
        }
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)receivedData {
    if (connection == urlConnection) {
        [data appendData:receivedData];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    if (connection == urlConnection) {
        if (callingDelegate && [callingDelegate respondsToSelector:@selector(done:)]) {
            [callingDelegate done:data];
            [self closeConnection];
        }
    }
}

- (void)closeConnection {
    [urlConnection release];
    urlConnection = nil;
    
    [data release];
    data = nil;
}

@end
