//
//  FEEventHelper.h
//  Vetsy
//
//  Created by Andrei on 9/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <EventKit/EventKit.h>
#import "Event.h"

#define kNSUserDefaults_SyncedEventsIDsKey          @"syncedEvents"

@interface FEEventHelper : NSObject

+ (BOOL)addEvents:(NSArray *)events;
+ (BOOL)removeSyncedEvents:(NSError **)error;

@end
