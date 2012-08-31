//
//  Event.h
//  FB Events
//
//  Created by Andrei on 8/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Venue.h"
#import "FacebookObject.h"
#import "FESessionSingleton.h"

#define kRSVPStatusAttending            @"attending"
#define kRSVPStatusUnsure               @"unsure"

#define kFacebookGraphURL               @"https://graph.facebook.com/"

@interface Event : FacebookObject <NSURLConnectionDelegate, NSURLConnectionDataDelegate> {
    BOOL loaded;
    NSURLRequest *urlRequest;
    NSURLConnection *urlConnection;
    NSMutableData *receivedData;
}

@property (nonatomic, retain) NSString *eventID;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *description;
@property (nonatomic, retain) NSDate *start_time;
@property (nonatomic, retain) NSDate *end_time;
@property (nonatomic, retain) NSString *location;
@property (nonatomic, retain) Venue *venue;
@property (nonatomic, retain) NSString *privacy;
@property (nonatomic, retain) NSString *updated_time;
@property (nonatomic, retain) NSString *rsvp_status;

// loading event properties
@property (nonatomic, readonly) BOOL loaded;

- (id)initWithID:(NSString *)evID;
- (id)initFromJSONDictionary:(NSDictionary *)jsonDict;

@end
