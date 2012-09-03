//
//  Event.h
//  Vetsy
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

@interface Event : FacebookObject <FacebookObjectDelegate> {
    NSString *start_time;
    NSString *end_time;
    NSString *update_time;
}

@property (nonatomic, retain) NSString *eventID;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *description;
@property (nonatomic, retain) NSString *location;
@property (nonatomic, retain) NSString *privacy;
@property (nonatomic, retain) NSString *rsvp_status;
@property (nonatomic, retain) Venue *venue;

- (NSDate *)start_time;
- (NSDate *)end_time;
- (NSDate *)update_time;

@end
