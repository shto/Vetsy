//
//  FEProxy.h
//  Vetsy
//
//  Created by Andrei on 8/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FEProxyProtocol <NSObject>

- (void)failedWithError:(NSError *)error;
- (void)done:(NSData *)data;

@end

@interface FEProxy : NSObject <NSURLConnectionDelegate, NSURLConnectionDataDelegate> {
    NSURLConnection *urlConnection;
    NSURLRequest *urlRequest;
    NSMutableData *data;
    
    id<FEProxyProtocol> callingDelegate;
}

@property (nonatomic, retain) id callingDelegate;

- (id)initAndGetFromURL:(NSURL *)url delegate:(id)delegate;

@end
