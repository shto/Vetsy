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

@end
