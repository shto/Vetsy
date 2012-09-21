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
        if ((eventInCalendarID = [self addEventToVetsyCalendarStore:event
                                                              error:&error])) {
            [correspondingIDs setObject:eventInCalendarID forKey:event.eventID];
        }
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:correspondingIDs forKey:kNSUserDefaults_SyncedEventsIDsKey];
    [correspondingIDs release];
    return YES;
}

+ (EKEvent *)eventWithID:(NSString *)eventID {
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    EKEvent *returnedEvent = [eventStore eventWithIdentifier:eventID];
    [eventStore release];
    
    return returnedEvent;
}

+ (NSString *)addEventToVetsyCalendarStore:(Event *)event error:(NSError **)error {
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    EKEvent *ekEvent = [EKEvent eventWithEventStore:eventStore];
    
    EKCalendar *vetsyCalendar = [self newOrExistingVetsyCalendarForEventStore:eventStore error:error];
    
    ekEvent.title = event.name;
    ekEvent.startDate = event.start_time;
    ekEvent.endDate = event.end_time;
    ekEvent.notes = event.description;
    
    [ekEvent setCalendar:vetsyCalendar];
    [vetsyCalendar release];
    
    BOOL eventSaved = [eventStore saveEvent:ekEvent span:EKSpanThisEvent error:error];
    [eventStore release];
    
    if (!eventSaved) {
        return nil;
    }
    
    return ekEvent.eventIdentifier;
}

+ (EKCalendar *)newOrExistingVetsyCalendarForEventStore:(EKEventStore *)eventStore 
                                                  error:(NSError **)error 
{    
    EKCalendar* calendar;
    
    // Get the calendar source
    EKSource* localSource;
    for (EKSource* source in eventStore.sources) {
        NSLog(@"source: %@", source);
        if (source.sourceType == EKSourceTypeLocal)
        {
            localSource = source;
            break;
        }
    }
    
    if (!localSource)
    {
        *error = [NSError errorWithDomain:@"vetsy.error"
                                     code:100 
                                 userInfo:[NSDictionary dictionaryWithObject:@"No local source found" forKey:@"explanation"]];
        return nil;
    }
    
    NSString *calIdentifier = [[NSUserDefaults standardUserDefaults] objectForKey:kNSUserDefaults_VestyCalendarID];    
    for (EKCalendar *calendar in localSource.calendars) {
        if ([calendar.calendarIdentifier isEqualToString:calIdentifier]) {
            return [calendar retain];
        }
    }
    
    calendar = [[EKCalendar calendarWithEventStore:eventStore] retain];
    calendar.source = localSource;
    calendar.title = kVetsyCalendarName;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat components[4] = {59.0/255.0f, 89.0/255.0f, 182.0/255.0f, 1.0f};//facebook blue
    CGColorRef facebookBlue = CGColorCreate(colorSpace, components);
    calendar.CGColor = facebookBlue;
    
    if ([eventStore saveCalendar:calendar commit:YES error:error]) {
        [[NSUserDefaults standardUserDefaults] setObject:calendar.calendarIdentifier forKey:kNSUserDefaults_VestyCalendarID];
        return calendar;
    } else {
        return nil;
    }
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
