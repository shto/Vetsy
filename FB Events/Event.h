//
//  Event.h
//  FB Events
//
//  Created by Andrei on 8/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Venue.h"

#define kRSVPStatusAttending            @"attending"
#define kRSVPStatusUnsure               @"unsure"

@interface Event : NSObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *description;
@property (nonatomic, retain) NSDate *start_time;
@property (nonatomic, retain) NSDate *end_time;
@property (nonatomic, retain) NSString *location;
@property (nonatomic, retain) Venue *venue;
@property (nonatomic, retain) NSString *privacy;
@property (nonatomic, retain) NSString *updated_time;
@property (nonatomic, retain) NSString *rsvp_status;

- (id)initFromJSONDictionary:(NSDictionary *)jsonDict;

@end
