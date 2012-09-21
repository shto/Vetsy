//
//  FEEventLoader.h
//  Vetsy
//
//  Created by Andrei on 8/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YAJLiOS/YAJL.h>
#import "Event.h"
#import "FEProxy.h"

@protocol FEEventLoaderDelegate <NSObject>
@required
- (void)eventsLoaded:(NSArray *)events;

@optional
- (void)failWithError:(NSError *)error;

@end

@interface FEEventLoader : NSObject <FEProxyProtocol, FacebookObjectLoadedCompleteDelegate> {
    NSString *eventsURL;
    FEProxy *proxy;
    id<FEEventLoaderDelegate> waitingDelegate;
    
    NSInteger numberOfLoadedEvents;
}

@property (nonatomic, readwrite) NSInteger numberOfLoadedEvents;

- (id)initWithEventsURL:(NSString *)url andDelegate:(id<FEEventLoaderDelegate>)delegate;
- (void)startGettingEvents;

@end