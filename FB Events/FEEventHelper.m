//
//  FEEventHelper.m
//  Vetsy
//
//  Created by Andrei on 9/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FEEventHelper.h"

@implementation FEEventHelper

+ (BOOL)addEventToCalendar:(Event *)event error:(NSError **)error {
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    EKEvent *ekEvent = [EKEvent eventWithEventStore:eventStore];
    
    ekEvent.title = event.name;
    ekEvent.startDate = event.start_time;
    ekEvent.endDate = event.end_time;
    ekEvent.notes = event.description;
    
    [ekEvent setCalendar:[eventStore defaultCalendarForNewEvents]];
    
    [eventStore saveEvent:ekEvent span:EKSpanThisEvent error:error];
    [eventStore release];
    
    if (error) {
        return NO;
    }
    
    return YES;
}

@end
