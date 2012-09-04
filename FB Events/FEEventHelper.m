//
//  FEEventHelper.m
//  Vetsy
//
//  Created by Andrei on 9/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FEEventHelper.h"

@implementation FEEventHelper

// adds an NSArray of Event objects to the calendar and 
// stores the relationship between the FB ID and the calendar ID in user defaults
+ (BOOL)addEvents:(NSArray *)events {   
    // key - facebook ID | value - calendar ID
    NSMutableDictionary *correspondingIDs = [[[NSUserDefaults standardUserDefaults] objectForKey:kNSUserDefaults_SyncedEventsIDsKey] mutableCopy];
    if (!correspondingIDs) {
        correspondingIDs = [[NSMutableDictionary dictionary] retain];
    }
    
    NSError *error = nil;
    NSString *eventInCalendarID = @"";
    
    for (Event *event in events) {
        eventInCalendarID = [correspondingIDs objectForKey:event.eventID];
        
        if (eventInCalendarID) {
            if ([self removeEventWithIdentifier:eventInCalendarID error:&error]) {
                if ((eventInCalendarID = [self addEventToCalendar:event error:&error])) {
                    [correspondingIDs setObject:eventInCalendarID forKey:event.eventID];
                }
            }
        } else {
            if ((eventInCalendarID = [self addEventToCalendar:event error:&error])) {
                [correspondingIDs setObject:eventInCalendarID forKey:event.eventID];
            }
        }        
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:correspondingIDs forKey:kNSUserDefaults_SyncedEventsIDsKey];
    [correspondingIDs release];
    return YES;
}

+ (EKEvent *)eventWithID:(NSString *)eventInCalendarID {
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    EKEvent *returnedEvent = [eventStore eventWithIdentifier:eventInCalendarID];
    [eventStore release];
    
    return returnedEvent;
}

// returns the event's identifier in the calendar store; nil if an error has occured
+ (NSString *)addEventToCalendar:(Event *)event error:(NSError **)error {
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    EKEvent *ekEvent = [EKEvent eventWithEventStore:eventStore];
    
    ekEvent.title = event.name;
    ekEvent.startDate = event.start_time;
    ekEvent.endDate = event.end_time;
    ekEvent.notes = event.description;
    
    [ekEvent setCalendar:[eventStore defaultCalendarForNewEvents]];
    
    BOOL eventSaved = [eventStore saveEvent:ekEvent span:EKSpanThisEvent error:error];
    [eventStore release];
    
    if (!eventSaved) {
        return nil;
    }
    
    return ekEvent.eventIdentifier;
}

// removes all the facebook synced events from the iPhone's calendar
+ (BOOL)removeSyncedEvents:(NSError **)error {
    NSMutableDictionary *correspondingIDs = [[NSUserDefaults standardUserDefaults] objectForKey:kNSUserDefaults_SyncedEventsIDsKey];
    for (NSString *eventFacebookID in correspondingIDs) {
        NSString *eventCalendarID = [correspondingIDs objectForKey:eventFacebookID];
        [self removeEventWithIdentifier:eventCalendarID error:error];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:kNSUserDefaults_SyncedEventsIDsKey];
    return YES;
}

+ (BOOL)removeEventWithIdentifier:(NSString *)identifier error:(NSError **)error {
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    EKEvent *theEvent = [eventStore eventWithIdentifier:identifier];
    BOOL eventRemoved = YES;
    if (theEvent) {
        eventRemoved = [eventStore removeEvent:theEvent span:EKSpanThisEvent error:error];
    }
    
    [eventStore release];
    return eventRemoved;
}

@end
